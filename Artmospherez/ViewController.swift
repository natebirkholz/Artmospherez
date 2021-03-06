//
//  ViewController.swift
//  Artmospherez
//
//  Created by Nathan Birkholz on 5/22/17.
//  Copyright © 2017 natebirkholz. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Properties

    @IBOutlet weak var tableView: UITableView!

    var forecasts = [Forecast]()
    var currentWeather: CurrentWeather?
    var networkController: NetworkController?
    let weatherImageFactory = WeatherImageFactory()
    var loadingIndicator: UIActivityIndicatorView?
    var reloadButton: UIButton?
    var loadingInfoView: InfoView?
    var didRejectLocationAuthorization: Bool? {
        didSet {
            // If going from unauthorized to authorized, should force update
            if let old = oldValue, old == true && didRejectLocationAuthorization == false {
                forceRefresh()
                showLoadingInfo()
            } else if didRejectLocationAuthorization == false {
                // Initial set should force refresh due to order of operations
                forceRefresh()
            } else {
                // let the user know what heppens without authorization (shows Utqiagvik)
                alertForRejectedAuthorization()
            }
        }
    }
    
    override var prefersStatusBarHidden: Bool { return true }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkController = NetworkController(from: self)
        navigationController?.delegate = self

        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()

        tableView.register((UINib(nibName: "ForecastCell", bundle: Bundle.main)), forCellReuseIdentifier: "FORECAST_CELL")
        tableView.register((UINib(nibName: "WeatherCell", bundle: Bundle.main)), forCellReuseIdentifier: "WEATHER_CELL")

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.refreshControl = refreshControl

        view.bringSubviewToFront(tableView)
        tableView.isHidden = true

        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse  {
            networkController?.locationController?.updateLocation { [weak self] (maybeError) in
                guard maybeError ==  nil else {
                    self?.handleNetworkError(error: .failedLocation)
                    return
                }

                self?.networkController?.getJSONForForecasts { (maybeForecasts, maybeError) in
                    self?.loadingIndicator?.stopAnimating()

                    if let error = maybeError {
                        self?.handleNetworkError(error: error)
                        return
                    }
                    guard let forecasts = maybeForecasts  else {
                        self?.handleNetworkError(error: .noData)
                        return
                    }

                    self?.forecasts = forecasts
                    self?.tableView.reloadData()
                }

                self?.networkController?.getCurrentWeather { (maybeWeather, maybeError) in
                    if let error = maybeError {
                        self?.handleNetworkError(error: error)
                        return
                    }
                    guard let current = maybeWeather else {
                        self?.handleNetworkError(error: .noData)
                        return
                    }

                    UIView.animate(withDuration: 0.3, animations: {
                        self?.tableView.isHidden = false
                    })

                    let date = Date()
                    UserDefaults.standard.set(date, forKey: Constants.dateKey)
                    UserDefaults.standard.synchronize()

                    self?.currentWeather = current
                    self?.tableView.reloadData()
                }
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

        let activity = UIActivityIndicatorView(style: .large)
        activity.color = .white
        activity.hidesWhenStopped = true
        activity.center = CGPoint(x: view.bounds.width / 2, y: view.bounds.height / 2)
        view.addSubview(activity)
        view.bringSubviewToFront(view)
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
        reloadButton = button

        // Only bother trying to refresh on viewWillAppear if the weather has previously loaded.
        // If the user has denied location information, only refresh if the forecasts are empty.
        if let _ = UserDefaults.standard.object(forKey: Constants.dateKey) as? Date {
            if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
                refresh()
            } else if CLLocationManager.authorizationStatus() == .denied && forecasts.count == 0 {
                forceRefresh()
            }
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // infoView needs more room on iPad because it displays at 1x dimensions
        let heightForInfoView: CGFloat
        if UIDevice.current.model.hasPrefix("iPad") {
            heightForInfoView = 50
        } else {
            heightForInfoView = 50
        }

        let infoFrame = CGRect(x: 8.0, y: -138.0, width: view.frame.width - 16.0, height: heightForInfoView)
        let info = InfoView(frame: infoFrame)
        info.textView?.text = "Still working on forecasts..."
        view.addSubview(info)

        loadingInfoView = info

        alertForRejectedAuthorization()
    }

    // MARK: - TableView methods

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 9
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: .zero)

        return view
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 128
        } else {
            return 96
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "WEATHER_CELL", for: indexPath) as? WeatherCell else {
                return UITableViewCell()
            }

            return configureWeatherCell(cell)
            
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FORECAST_CELL", for: indexPath) as? ForecastCell else {
                return UITableViewCell()
            }
            return configureForecastCell(cell, at: indexPath)
        }
    }
    
    func configureWeatherCell(_ cell: WeatherCell) -> WeatherCell {
        var weatherText = currentWeather?.kind.rawValue ?? "Unknown"

        // If time of day is *not* between 7am and 6pm, show "Clear" instead of "Sunny" for weather type.
        let timeOfDay = DateController.shared.getTimeOfDay()
        if timeOfDay == .night && currentWeather?.kind == .sunny {
            weatherText = "Clear"
        }
        cell.weatherLabel?.text = "\(weatherText)"
        cell.weatherLabel?.sizeToFit()
        if let kind = currentWeather?.kind {
            // use the current day of the year to get the index of the image, ensures daily variety
            let idx = DateController.shared.getDay()
            let weatherImageForCell = selectImageFor(weather: kind, indexOrRow: idx)
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
    }
    
    func configureForecastCell(_ cell: ForecastCell, at indexPath: IndexPath) -> ForecastCell {
        if forecasts.count > 0 {
            let forecast = forecasts[indexPath.row + 1]

            // keeps images in sequence (prevents forecast and first cell from having the same image)
            let idx = DateController.shared.getDay() + indexPath.row + 1
            let weatherImageForCell = selectImageFor(weather: forecast.kind, indexOrRow: idx)
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
            guard let detailVC = segue.destination as? DetailViewControllerWeather else { return }
            let detailWeather = currentWeather
            guard let cell = tableView.cellForRow(at: indexPathForWeather) as? WeatherCell else { return }
            let image = cell.weatherImageView.image
            detailVC.weather = detailWeather
            detailVC.weatherImage = cell.weatherImage
            detailVC.image = image
        } else if segue.identifier == "FORECAST_SEGUE" {
            guard let indexPathForForecast = tableView.indexPathForSelectedRow else { return }
            guard let detailVC = segue.destination as? DetailViewControllerForecast else { return }
            let detailForecast = forecasts[indexPathForForecast.row + 1]
            guard let cell = tableView.cellForRow(at: indexPathForForecast) as? ForecastCell else { return }
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

    func getTimeOfDay() -> TimeOfDay {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        let hourString = dateFormatter.string(from: date)
        let maybeHour = Int(hourString)

        if let hour = maybeHour {
            if hour >= 7 && hour < 18 {
                return .day
            } else {
                return .night
            }
        } else {
            return .day
        }
    }

    /// Calls refresh() with force: true
    @objc func forceRefresh() {
        if networkController?.locationController?.currentZipCode != nil {
            refresh(force: true)
        } else if UserDefaults.standard.bool(forKey: Constants.defaultLocationKey) {
            refresh(force: true)
        }

    }


    /// Check the back end for new weather data. Will only execute once every 15 minutes unless forced.
    ///
    /// - Parameter force: Force update in less than 15 minutes. Defaults to false. Convenience method forceRefresh() preferred.
    @objc dynamic func refresh(force: Bool = false) {
        
        // If the app hasn't been authorized one way or another yet we don't want to show the placeholder location of Barrow
        guard CLLocationManager.authorizationStatus() != .notDetermined else { return }

        // *Only* refesh if it has been more than 15 minutes since last API call, this prevents needless overuse of API. (Unless forced.)
        let then = UserDefaults.standard.object(forKey: Constants.dateKey) as? Date ?? Date.distantPast
        let now = Date()

        if !force {
            let secondsBetween = abs(Int(now.timeIntervalSince(then)))
            guard secondsBetween > 900 else {
                tableView.refreshControl?.endRefreshing()
                return
            }
        }

        if tableView.isHidden { loadingIndicator?.startAnimating() }

        networkController?.getJSONForForecasts { [weak self] (maybeForecasts, maybeError) in
            if let error = maybeError {
                self?.tableView.refreshControl?.endRefreshing()
                self?.handleNetworkError(error: error)
                return
            }
            guard let forecasts = maybeForecasts  else {
                self?.tableView.refreshControl?.endRefreshing()
                self?.handleNetworkError(error: .noData)
                return
            }

            self?.loadingIndicator?.stopAnimating()

            // Hide the reload button here to prevent overlap
            self?.reloadButton?.isHidden = true

            self?.forecasts = forecasts
            self?.tableView.reloadData()
        }

        networkController?.getCurrentWeather { [weak self] (maybeWeather, maybeError) in
            if let error = maybeError {
                self?.tableView.refreshControl?.endRefreshing()
                self?.handleNetworkError(error: error)
                return
            }

            guard let current = maybeWeather else {
                self?.tableView.refreshControl?.endRefreshing()
                self?.handleNetworkError(error: .noData)
                return
            }

            if let table = self?.tableView, table.isHidden {
                UIView.animate(withDuration: 0.3, animations: {
                    self?.tableView.isHidden = false
                })
            }

            UserDefaults.standard.set(now, forKey: Constants.dateKey)
            UserDefaults.standard.synchronize()

            self?.currentWeather = current
            self?.tableView.reloadData()
            self?.tableView.refreshControl?.endRefreshing()
        }
    }

    /// Fetches an image appropriate to the weather for the day in question. Non-random, prevents adjacent
    /// cells from having identical images.
    ///
    /// - Parameters:
    ///   - weather: the WeatherKind for the day
    ///   - idx: Index or tableView row to modulo and return an image from those available.
    /// - Returns: WeatherImage for the WeathrKind
    func selectImageFor(weather: WeatherKind, indexOrRow idx: Int) -> WeatherImage {
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
        case .snowy:
            return weatherImageFactory.snowyImages[idx % weatherImageFactory.snowyImages.count]
        default:
            return weatherImageFactory.sunnyImages[idx % weatherImageFactory.sunnyImages.count]
        }
    }

    /// Displays a notification if the user has rejected location services and the notification has
    /// not been shown before.
    func alertForRejectedAuthorization() {
        // Don't show if it has been shown before.
        guard UserDefaults.standard.bool(forKey: Constants.defaultLocationKey) != true else { return }

        // Shouldn't be shown if false, check for future prevention
        if let rejection = didRejectLocationAuthorization, rejection == true  {
            let alert = UIAlertController(title: "Location", message: "You can turn on location awareness for Artmospherez in the Settings app. We never collect data from your device. For now, showing you the weather in Barrow (Utqiagvik), Alaska.", preferredStyle: .alert)
            let action  = UIAlertAction(title: "OK", style: .default, handler: { [weak self] (action) in
                UserDefaults.standard.set(true, forKey: Constants.defaultLocationKey)
                UserDefaults.standard.synchronize()
                self?.forceRefresh()
            })
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }

    func showLoadingInfo() {
        if loadingInfoView?.isPresented == false, let loadingIndicator = self.loadingIndicator, loadingIndicator.isAnimating {
            UIView.animate(withDuration: 0.5, animations: { [weak self] in
                self?.loadingInfoView?.frame.origin.y = 38.0
                self?.loadingInfoView?.isPresented = true
                }, completion: { [weak self] complete in
                    UIView.animate(withDuration: 0.5, delay: 3.0, options: [], animations: {
                        self?.loadingInfoView?.frame.origin.y = -138.0
                        self?.loadingInfoView?.isPresented = false
                    }, completion: nil)
            })
        } else {
            UIView.animate(withDuration: 0.5, animations: { [weak self] in
                self?.loadingInfoView?.frame.origin.y = -138.0
                self?.loadingInfoView?.isPresented = false
            })
        }
    }
}

// MARK: - UINavigationControllerDelegate

extension ViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
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
        case .failedLocation:
            showError(message: "Unable to determine your location.")
        }
    }

    /// Show an error message.
    ///
    /// - Parameter message: The message to display
    func showError(message: String) {
        let alertController = UIAlertController(title: "Error", message: "\(message) Please verify your Internet connection and try again in a moment.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] (action) in
            self?.loadingIndicator?.stopAnimating()
            self?.showReloadButton()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    /// If the network request fails and there is no tableView visible, display the 
    /// reload button.
    func showReloadButton() {
        if tableView.isHidden {
            if let reloadButton = self.reloadButton, reloadButton.isHidden {
                reloadButton.center = CGPoint(x: view.bounds.width / 2, y: view.bounds.height - 40)
                view.bringSubviewToFront(reloadButton)
                reloadButton.isHidden = false
            }
        }
    }
}

// MARK: - LocationControllerDelegate

extension ViewController: LocationControllerDelegate {
    func refreshLocations() {
        if networkController?.locationController?.currentZipCode != nil {
            forceRefresh()
        }
    }
}

// MARK: - NetworkControllerDelegate

extension ViewController: NetworkControllerDelegate {
    func showStillWorking() {
        showLoadingInfo()
    }
}

