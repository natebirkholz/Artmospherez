//
//  ViewController.swift
//  Artmospherez
//
//  Created by Nathan Birkholz on 5/22/17.
//  Copyright © 2017 natebirkholz. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    var forecasts = [Forecast]()
    var currentWeather: CurrentWeather?
    let networkController = NetworkController()
    let weatherImageController = WeatherImageController()


    override func viewDidLoad() {
        super.viewDidLoad()

        networkController.locationControllerDelegate = self

        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()

        tableView.register((UINib(nibName: "ForecastCell", bundle: Bundle.main)), forCellReuseIdentifier: "FORECAST_CELL")
        tableView.register((UINib(nibName: "WeatherCell", bundle: Bundle.main)), forCellReuseIdentifier: "WEATHER_CELL")

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.refreshControl = refreshControl

        self.view.bringSubview(toFront: tableView)

        networkController.locationController.updadeLocation {
            self.networkController.getJSONForForecasts { (maybeForecasts, maybeError) in
                guard maybeError == nil else { return }
                guard let forecasts = maybeForecasts  else { return }

                self.forecasts = forecasts
                self.tableView.reloadData()
            }

            self.networkController.getCurrentWeather { (maybeWeather, maybeError) in
                guard maybeError == nil else { return }
                guard let current = maybeWeather else { return }
                print(current)

                self.currentWeather = current
                self.tableView.reloadData()
            }
        }



    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
//            return forecasts.count
            return 6
        }
    }

//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        if section == 1 {
//            return 12
//        }
//
//        return 0
//    }

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
            cell.weatherLabel?.text = " \(weatherText) "
            cell.weatherLabel?.sizeToFit()
            cell.weatherImageview.image = weatherImageController.sunnyImages[indexPath.row % weatherImageController.sunnyImages.count].image
            let temperature = currentWeather?.currentTemp ?? 70
            cell.weatherTemp.text = " \(temperature)° "
            cell.weatherTemp.sizeToFit()
            let windDir = currentWeather?.windCompassDirection ?? "N"
            let windSpeed = currentWeather?.windSpeed ?? 0
            let high = currentWeather?.maxTemp ?? 70
            let low = currentWeather?.minTemp ?? 55

            let weatherString = " wind \(windSpeed) mph \(windDir), max: \(high)°, min: \(low)° "
            cell.weatherDetailLabel.text = weatherString
            cell.weatherDetailLabel.sizeToFit()

            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FORECAST_CELL", for: indexPath) as! ForecastCell
            if forecasts.count > 0 {
                cell.weatherImageView.image = weatherImageController.rainyImages[indexPath.row % weatherImageController.rainyImages.count].image
                let forecast = forecasts[indexPath.row + 1]
                let day = forecast.day
                let weatherType = forecast.kind.rawValue
                let max = forecast.maxTemp
                let weatherString = " \(day): \(weatherType), \(max)° "
                cell.weatherLabel.text = weatherString
                cell.weatherLabel.sizeToFit()
            }

            return cell
        }
    }

    dynamic func refresh() {
        networkController.getJSONForForecasts { (maybeForecasts, maybeError) in
            guard maybeError == nil else {
                self.tableView.refreshControl?.endRefreshing()
                return
            }
            guard let forecasts = maybeForecasts  else {
                self.tableView.refreshControl?.endRefreshing()
                return
            }

            self.forecasts = forecasts
            self.tableView.reloadData()
        }

        networkController.getCurrentWeather { (maybeWeather, maybeError) in
            guard maybeError == nil else {
                self.tableView.refreshControl?.endRefreshing()
                return
            }

            guard let current = maybeWeather else {
                self.tableView.refreshControl?.endRefreshing()
                return
            }

            print(current)

            self.currentWeather = current
            self.tableView.reloadData()
            self.tableView.refreshControl?.endRefreshing()
        }
    }

}

extension ViewController: LocationControllerDelegate {
    func refreshLocations() {
        refresh()
    }
}

