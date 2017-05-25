//
//  DetailViewControllerWeather.swift
//  Artmospherez
//
//  Created by Nathan Birkholz on 5/24/17.
//  Copyright © 2017 natebirkholz. All rights reserved.
//

import UIKit

class DetailViewControllerWeather: UIViewController, UINavigationControllerDelegate {


    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var mainLabel: WeatherLabel!
    @IBOutlet weak var windLabel: WeatherLabel!
    @IBOutlet weak var maxMinLabel: WeatherLabel!
    @IBOutlet weak var infoButton: UIButton!

    var weather: CurrentWeather!
    var image: UIImage!
    var swipeDown: UISwipeGestureRecognizer?
    var swipeRight: UISwipeGestureRecognizer?
    var swipeUp: UISwipeGestureRecognizer?
    var tap: UITapGestureRecognizer?

    override var prefersStatusBarHidden: Bool { return true }

    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = image

        let downRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(dismissSelf(_:)))
        downRecognizer.direction = .down
        view.addGestureRecognizer(downRecognizer)
        swipeDown = downRecognizer

        let upRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(dismissSelf(_:)))
        upRecognizer.direction = .up
        view.addGestureRecognizer(upRecognizer)
        swipeUp = upRecognizer

        let rightRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(dismissSelf(_:)))
        rightRecognizer.direction = .right
        view.addGestureRecognizer(rightRecognizer)
        swipeRight = rightRecognizer

        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissSelf(_:)))
        view.addGestureRecognizer(tapRecognizer)
        tap = tapRecognizer

        let mainLabelText = " \(weather.kind.rawValue), \(weather.currentTemp)° "
        mainLabel.text = mainLabelText
        mainLabel.sizeToFit()
        mainLabel.frame.size.width += 6.0
        mainLabel.clipsToBounds = true
        mainLabel.layer.cornerRadius = 8.0
        mainLabel.backgroundColor = Constants.labelColor

        let windLabelText = " wind: \(weather.windCompassDirection) \(weather.windSpeed) mph "
        windLabel.text = windLabelText
        windLabel.sizeToFit()
        windLabel.frame.size.width += 6.0
        windLabel.clipsToBounds = true
        windLabel.layer.cornerRadius = Constants.cornerRadius
        windLabel.backgroundColor = Constants.labelColor

        let maxMinText = " \(weather.maxTemp)°/\(weather.minTemp)° "
        maxMinLabel.text = maxMinText
        maxMinLabel.sizeToFit()

        maxMinLabel.clipsToBounds = true
        maxMinLabel.layer.cornerRadius = Constants.cornerRadius
        maxMinLabel.frame.size.width += 24.0
        maxMinLabel.backgroundColor = Constants.labelColor

        infoButton.backgroundColor = Constants.labelColor
        infoButton.layer.cornerRadius = 8.0
        infoButton.clipsToBounds = true
        infoButton.addTarget(self, action: #selector(showInfo(_:)), for: .touchUpInside)

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    func showInfo(_ sender: UIButton) {
        print("INFO")
    }

    func hideInfo() {

    }

    func dismissSelf(_ sender: UIGestureRecognizer) {
        navigationController?.popViewController(animated: true)
    }

}
