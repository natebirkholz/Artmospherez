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

        tableView.register((UINib(nibName: "ForecastCell", bundle: Bundle.main)), forCellReuseIdentifier: "FORECAST_CELL")
        tableView.register((UINib(nibName: "WeatherCell", bundle: Bundle.main)), forCellReuseIdentifier: "WEATHER_CELL")

        self.view.bringSubview(toFront: tableView)

        networkController.getJSONForForecasts { (maybeForecasts, maybeError) in
            guard maybeError == nil else { return }
            guard let forecasts = maybeForecasts  else { return }

            self.forecasts = forecasts
            self.tableView.reloadData()
        }

        networkController.getCurrentWeather { (maybeWeather, maybeError) in
            guard maybeError == nil else { return }
            guard let current = maybeWeather else { return }
            print(current)

            self.currentWeather = current
            self.tableView.reloadData()
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

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 12
        }

        return 0
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
        return 64
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WEATHER_CELL", for: indexPath) as! WeatherCell
            cell.weatherLabel?.text = self.currentWeather?.kind.rawValue ?? "Unknown"
            cell.weatherImageview.image = weatherImageController.sunnyImages[indexPath.row % weatherImageController.sunnyImages.count].image

            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FORECAST_CELL", for: indexPath) as! ForecastCell
            if forecasts.count > 0 {
                cell.weatherLabel?.text = forecasts[indexPath.row + 1].kind.rawValue
                cell.weatherImageView.image = weatherImageController.rainyImages[indexPath.row % weatherImageController.rainyImages.count].image
            }


            return cell
        }
    }

}

extension ViewController: LocationControllerDelegate {
    func didAuthorizeLocations() {
        tableView.reloadData()
    }
}

