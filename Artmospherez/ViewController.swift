//
//  ViewController.swift
//  Artmospherez
//
//  Created by Nathan Birkholz on 5/22/17.
//  Copyright © 2017 natebirkholz. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Properties

    @IBOutlet weak var tableView: UITableView!

    var forecasts = [Forecast]()
    var currentWeather: CurrentWeather?
    let networkController = NetworkController()
    let weatherImageFactory = WeatherImageFactory()
    var loadingIndicator: UIActivityIndicatorView!
    var reloadButton: UIButton!

    override var prefersStatusBarHidden: Bool { return true }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        networkController.locationControllerDelegate = self
        navigationController?.delegate = self

        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()

        tableView.register((UINib(nibName: "ForecastCell", bundle: Bundle.main)), forCellReuseIdentifier: "FORECAST_CELL")
        tableView.register((UINib(nibName: "WeatherCell", bundle: Bundle.main)), forCellReuseIdentifier: "WEATHER_CELL")

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.refreshControl = refreshControl

        self.view.bringSubview(toFront: tableView)
        tableView.isHidden = true

        let date = Date()
        UserDefaults.standard.set(date, forKey: Constants.dateKey)

        networkController.locationController.updateLocation {
            self.networkController.getJSONForForecasts { (maybeForecasts, maybeError) in
                self.loadingIndicator.stopAnimating()

                guard maybeError == nil else {
                    self.handleNetworkError(error: maybeError!)
                    return
                }
                guard let forecasts = maybeForecasts  else {
                    self.handleNetworkError(error: .noData)
                    return
                }

                self.forecasts = forecasts
                self.tableView.reloadData()
            }

            self.networkController.getCurrentWeather { (maybeWeather, maybeError) in
                guard maybeError == nil else {
                    self.handleNetworkError(error: maybeError!)
                    return
                }
                guard let current = maybeWeather else {
                    self.handleNetworkError(error: .noData)
                    return
                }

                UIView.animate(withDuration: 0.3, animations: {
                    self.tableView.isHidden = false
                })

                self.currentWeather = current
                self.tableView.reloadData()
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        for cell in tableView.visibleCells {
            cell.setSelected(false, animated: false)
        }

        view.setNeedsLayout()
        view.layoutIfNeeded()

        let activity = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activity.hidesWhenStopped = true
        activity.center = CGPoint(x: view.bounds.width / 2, y: view.bounds.height / 2)
        view.addSubview(activity)
        view.bringSubview(toFront: view)
        loadingIndicator = activity

        if tableView.isHidden {
            activity.startAnimating()
        }

        let button = UIButton()
        button.setTitle("Reload", for: .normal)
        button.titleLabel?.font = UIFont(name: "Didot", size: 20.0)
        button.titleLabel?.textColor = UIColor.white
        button.titleLabel?.textAlignment = .center
        button.clipsToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = Constants.labelColor
        button.addTarget(self, action: #selector(forceRefresh), for: .touchUpInside)
        button.center = CGPoint(x: view.bounds.width / 2, y: view.bounds.height - 40)
        button.sizeToFit()
        button.frame.size.width = button.frame.size.width + 8
        view.addSubview(button)
        button.isHidden = true
        self.reloadButton = button

        if let _ = UserDefaults.standard.object(forKey: Constants.dateKey) as? Date {
            refresh()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    // MARK: - TableView methods

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 6
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let view = UIView()
            view.frame = CGRect(x: 0, y: 0, width: 500, height: 12)
            view.backgroundColor = UIColor.lightGray

            return view
        }

        return nil
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 128
        } else {
            return 96
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WEATHER_CELL", for: indexPath) as! WeatherCell
            let weatherText = self.currentWeather?.kind.rawValue ?? "Unknown"
            cell.weatherLabel?.text = "\(weatherText)"
            cell.weatherLabel?.sizeToFit()
            if let kind = currentWeather?.kind {
                let idx = getDay() // use the current day of the year to get the index of the image, ensures daily variety
                let weatherImageForCell = generateImageFor(weather: kind, indexOrRow: idx)
                cell.weatherImage = weatherImageForCell
                cell.weatherImageView.image = weatherImageForCell.image
            }

            let temperature = currentWeather?.currentTemp ?? 70
            cell.weatherTemp.text = "\(temperature)°"
            cell.weatherTemp.sizeToFit()
            let windDir = currentWeather?.windCompassDirection ?? "N"
            let windSpeed = currentWeather?.windSpeed ?? 0
            let high = currentWeather?.maxTemp ?? 70
            let low = currentWeather?.minTemp ?? 55

            let weatherString = "wind \(windDir) \(windSpeed) mph, max: \(high)°, min: \(low)°"
            cell.weatherDetailLabel.text = weatherString
            cell.weatherDetailLabel.sizeToFit()

            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FORECAST_CELL", for: indexPath) as! ForecastCell
            if forecasts.count > 0 {
                let forecast = forecasts[indexPath.row + 1]

                let weatherImageForCell = generateImageFor(weather: forecast.kind, indexOrRow: indexPath.row)
                cell.weatherImage = weatherImageForCell
                cell.weatherImageView.image = weatherImageForCell.image

                let day = forecast.day
                let weatherType = forecast.kind.rawValue
                let max = forecast.maxTemp
                let weatherString = "\(day): \(weatherType), \(max)°"
                cell.weatherLabel.text = weatherString
                cell.weatherLabel.sizeToFit()
            }

            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            performSegue(withIdentifier: "WEATHER_SEGUE", sender: self)
        } else if indexPath.section == 1 {
            performSegue(withIdentifier: "FORECAST_SEGUE", sender: self)
        }
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WEATHER_SEGUE" {
            guard let indexPathForWeather = tableView.indexPathForSelectedRow else { return }
            let detailVC = segue.destination as! DetailViewControllerWeather
            let detailWeather = currentWeather
            let cell = tableView.cellForRow(at: indexPathForWeather) as! WeatherCell
            let image = cell.weatherImageView.image
            detailVC.weather = detailWeather
            detailVC.weatherImage = cell.weatherImage
            detailVC.image = image
        } else if segue.identifier == "FORECAST_SEGUE" {
            guard let indexPathForForecast = tableView.indexPathForSelectedRow else { return }
            let detailVC = segue.destination as! DetailViewControllerForecast
            let detailForecast = forecasts[indexPathForForecast.row + 1]
            let cell = tableView.cellForRow(at: indexPathForForecast) as! ForecastCell
            let image = cell.weatherImageView.image
            detailVC.forecast = detailForecast
            detailVC.weatherImage = cell.weatherImage
            detailVC.image = image
        }
    }

    override func performSegue(withIdentifier identifier: String, sender: Any?) {
        super.performSegue(withIdentifier: identifier, sender: sender)
    }

    // MARK: - Utilities

    /// Get the day of the year (day n of 365/366).
    ///
    /// - Returns: Int value of the day of the year
    func getDay() -> Int {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "D"
        let string = dateFormatter.string(from: date)
        let intFor = Int(string) ?? 1

        return intFor
    }

    /// Calls refresh() with force: true
    func forceRefresh() {
        refresh(force: true)
    }

    /// Check the back end for new data.
    dynamic func refresh(force: Bool = false) {
        // *Only* refesh if it has been more than 15 minutes since last call, this prevents overuse of API. Unless forced.
        let then = UserDefaults.standard.object(forKey: Constants.dateKey) as! Date
        let now = Date()

        if !force {
            let secondsBetween = abs(Int(now.timeIntervalSince(then)))
            guard secondsBetween > 900 else {
                tableView.refreshControl?.endRefreshing()
                return
            }
        }

        if tableView.isHidden { loadingIndicator.startAnimating() }

        networkController.getJSONForForecasts { (maybeForecasts, maybeError) in
            guard maybeError == nil else {
                self.tableView.refreshControl?.endRefreshing()
                self.handleNetworkError(error: maybeError!)
                return
            }
            guard let forecasts = maybeForecasts  else {
                self.tableView.refreshControl?.endRefreshing()
                self.handleNetworkError(error: .noData)
                return
            }

            self.loadingIndicator.stopAnimating()

            self.reloadButton?.isHidden = true

            self.forecasts = forecasts
            self.tableView.reloadData()
        }

        networkController.getCurrentWeather { (maybeWeather, maybeError) in
            guard maybeError == nil else {
                self.tableView.refreshControl?.endRefreshing()
                self.handleNetworkError(error: maybeError!)
                return
            }

            guard let current = maybeWeather else {
                self.tableView.refreshControl?.endRefreshing()
                self.handleNetworkError(error: .noData)
                return
            }

            if self.tableView.isHidden {
                UIView.animate(withDuration: 0.3, animations: {
                    self.tableView.isHidden = false
                })
            }

            UserDefaults.standard.set(now, forKey: Constants.dateKey)

            self.currentWeather = current
            self.tableView.reloadData()
            self.tableView.refreshControl?.endRefreshing()
        }
    }

    /// Fetches an image appropriate to the weather for the day in question. Non-random, prevents adjacent
    /// cells from having identical images.
    ///
    /// - Parameters:
    ///   - weather: the WeatherKind for the day
    ///   - idx: Index or tableView row to modulo and return an image from those available.
    /// - Returns: WeatherImage for the WeathrKind
    func generateImageFor(weather: WeatherKind, indexOrRow idx: Int) -> WeatherImage {
        switch weather {
        case .sunny:
            return weatherImageFactory.sunnyImages[idx % weatherImageFactory.sunnyImages.count]
        case .cloudy:
            return weatherImageFactory.cloudyImages[idx % weatherImageFactory.cloudyImages.count]
        case .rainy:
            return weatherImageFactory.rainyImages[idx % weatherImageFactory.rainyImages.count]
        case .tornado:
            return weatherImageFactory.tornadoImages[idx % weatherImageFactory.tornadoImages.count]
        case .foggy:
            return weatherImageFactory.foggyImages[idx % weatherImageFactory.foggyImages.count]
        case .overcast:
            return weatherImageFactory.overcastImages[idx % weatherImageFactory.overcastImages.count]
        case .windy:
            return weatherImageFactory.windyImages[idx % weatherImageFactory.windyImages.count]
        default:
            return weatherImageFactory.sunnyImages[idx % weatherImageFactory.sunnyImages.count]
        }
    }
}

// MARK: - LocationControllerDelegate

extension ViewController: LocationControllerDelegate {
    func refreshLocations() {
        refresh()
    }
}

// MARK: - UINavigationControllerDelegate

extension ViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if fromVC == self && toVC.isKind(of: DetailViewControllerWeather.self) {
            let transitionVC = AnimateToWeatherDetailController()
            return transitionVC
        } else if fromVC == self && toVC.isKind(of: DetailViewControllerForecast.self) {
            let transitionVC = AnimateToForecastDetailController()
            return transitionVC
        } else {
            return nil
        }
    }
}

// MARK: - Error Handling

extension ViewController {

    /// Factory to build an error string based on the error being handled
    ///
    /// - Parameter error: NetworkControllerError to be handled
    func handleNetworkError(error: NetworkControllerError) {
        switch error {
        case .failedResponse:
            showError(message: "The request to ther server was unrecognized.")
        case .noData:
            showError(message: "The server failed to return data.")
        case .noResponse:
            showError(message: "The server failed to respond.")
        case .parseError:
            showError(message: "The server returned unrecognized data.")
        case .unknownError:
            showError(message: "An unknown error occurred.")
        case .badURL:
            showError(message: "The request to the server failed to begin.")
        }
    }

    /// Show an error message.
    ///
    /// - Parameter message: The message to display
    func showError(message: String) {
        let alertController = UIAlertController(title: "Error", message: "\(message) Please verify your Internet connection and try again in a moment.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            self.loadingIndicator.stopAnimating()
            self.showReloadButton()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

    /// If the network request fails and there is no tableView visible, display the 
    /// reload button.
    func showReloadButton() {
        if tableView.isHidden {
            if reloadButton.isHidden {
                reloadButton.center = CGPoint(x: view.bounds.width / 2, y: view.bounds.height - 40)
                view.bringSubview(toFront: reloadButton)
                reloadButton.isHidden = false
            }
        }
    }
}

