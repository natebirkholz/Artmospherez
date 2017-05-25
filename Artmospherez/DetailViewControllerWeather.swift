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
    var weatherImage: WeatherImage!
    var image: UIImage!
    var swipeDownRecognizer: UISwipeGestureRecognizer?
    var swipeRightRecognizer: UISwipeGestureRecognizer?
    var swipeUpRecognizer: UISwipeGestureRecognizer?
    var tapViewRecognizer: UITapGestureRecognizer?
    var infoView: InfoView?

    override var prefersStatusBarHidden: Bool { return true }

    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = image

        let downRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(dismissSelf))
        downRecognizer.direction = .down
        view.addGestureRecognizer(downRecognizer)
        swipeDownRecognizer = downRecognizer

        let upRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(dismissSelf))
        upRecognizer.direction = .up
        view.addGestureRecognizer(upRecognizer)
        swipeUpRecognizer = upRecognizer

        let rightRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(dismissSelf))
        rightRecognizer.direction = .right
        view.addGestureRecognizer(rightRecognizer)
        swipeRightRecognizer = rightRecognizer

        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTap))
        view.addGestureRecognizer(tapRecognizer)
        tapViewRecognizer = tapRecognizer

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
        infoButton.layer.cornerRadius = 14.0
        infoButton.clipsToBounds = true
        infoButton.layer.borderWidth = 1
        infoButton.layer.borderColor = UIColor.white.cgColor
        infoButton.addTarget(self, action: #selector(showInfo), for: .touchUpInside)

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let infoFrame = CGRect(x: 8.0, y: -108.0, width: view.frame.width - 16.0, height: 100)
        let info = InfoView(frame: infoFrame)
        info.textView.text = weatherImage.detail
        view.addSubview(info)

        infoView = info
    }

    func showInfo() {
        print("INFO")
        print(weatherImage)

        if infoView?.isPresented == false {
            UIView.animate(withDuration: 0.5, animations: {
                self.infoView?.frame.origin.y = 88.0
            }, completion: { (complete) in
                self.infoView?.isPresented = true
            })
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                self.infoView?.frame.origin.y = -88.0
            }, completion: { (complete) in
                self.infoView?.isPresented = false
            })
        }
    }

    func hideInfo() {

    }

    func didTap() {
        if let presented = infoView?.isPresented {
            if presented {
                showInfo()
            } else {
                dismissSelf()
            }
        } else {
            dismissSelf()
        }
    }
    
    func dismissSelf() {
        navigationController?.popViewController(animated: true)
    }
    
}
