//
//  DetailViewControllerForecast.swift
//  Artmospherez
//
//  Created by Nathan Birkholz on 5/24/17.
//  Copyright © 2017 natebirkholz. All rights reserved.
//

import UIKit

class DetailViewControllerForecast: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var mainLabel: WeatherLabel!
    @IBOutlet weak var maxMinLabel: WeatherLabel!
    @IBOutlet weak var infoButton: UIButton!




    var forecast: Forecast!
    var weatherImage: WeatherImage!
    var image: UIImage!
    var swipeDown: UISwipeGestureRecognizer?
    var swipeRight: UISwipeGestureRecognizer?
    var swipeUp: UISwipeGestureRecognizer?
    var tap: UITapGestureRecognizer?

    override var prefersStatusBarHidden: Bool { return true }

    override func viewDidLoad() {
        super.viewDidLoad()

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

        imageView.image = image

        let mainText = " \(forecast.day), \(forecast.kind.rawValue) "
        mainLabel.text = mainText
        mainLabel.sizeToFit()
        mainLabel.layer.cornerRadius = 8.0
        mainLabel.backgroundColor = Constants.labelColor
        mainLabel.clipsToBounds = true

        let maxMinText = " \(forecast.maxTemp)°/\(forecast.minTemp)° "
        maxMinLabel.text = maxMinText
        maxMinLabel.sizeToFit()
        maxMinLabel.layer.cornerRadius = Constants.cornerRadius
        maxMinLabel.backgroundColor = Constants.labelColor
        maxMinLabel.clipsToBounds = true

        infoButton.backgroundColor = Constants.labelColor
        infoButton.layer.cornerRadius = 8.0
        infoButton.clipsToBounds = true
        infoButton.addTarget(self, action: #selector(showInfo(_:)), for: .touchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func showInfo(_ sender: UIButton) {
        print("INFO")
        print(weatherImage)
    }

    func hideInfo() {
        
    }
    

    func dismissSelf(_ sender: UIGestureRecognizer) {
        navigationController?.popViewController(animated: true)
    }

}
