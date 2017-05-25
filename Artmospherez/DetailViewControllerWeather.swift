//
//  DetailViewControllerWeather.swift
//  Artmospherez
//
//  Created by Nathan Birkholz on 5/24/17.
//  Copyright © 2017 natebirkholz. All rights reserved.
//

import UIKit

class DetailViewControllerWeather: UIViewController, UINavigationControllerDelegate {

    // MARK: - Properties

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var mainLabel: WeatherLabel!
    @IBOutlet weak var windLabel: WeatherLabel!
    @IBOutlet weak var maxMinLabel: WeatherLabel!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var ghostButton: UIButton!
    
    var weather: CurrentWeather!
    var weatherImage: WeatherImage!
    var image: UIImage!
    var swipeDownRecognizer: UISwipeGestureRecognizer?
    var swipeRightRecognizer: UISwipeGestureRecognizer?
    var swipeUpRecognizer: UISwipeGestureRecognizer?
    var tapViewRecognizer: UITapGestureRecognizer?
    var infoView: InfoView?

    override var prefersStatusBarHidden: Bool { return true }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Gesture recognizers
        
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

        // Views

        imageView.image = image

        let mainLabelText = " \(weather.kind.rawValue), \(weather.currentTemp)°, \(weather.cityName) "
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

        // Has a larger hit area than the visible button
        ghostButton.addTarget(self, action: #selector(showInfo), for: .touchUpInside)

        infoButton.backgroundColor = Constants.labelColor
        infoButton.layer.cornerRadius = 14.0
        infoButton.clipsToBounds = true
        infoButton.layer.borderWidth = 1
        infoButton.layer.borderColor = UIColor.white.cgColor
        infoButton.addTarget(self, action: #selector(showInfo), for: .touchUpInside)

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // infoView needs more room on iPad because it displayes at 1x dimensions
        let heightForInfoView: CGFloat
        if UIDevice.current.model.hasPrefix("iPad") {
            heightForInfoView = 116.0
        } else {
            heightForInfoView = 100.0
        }

        let infoFrame = CGRect(x: 8.0, y: -138.0, width: view.frame.width - 16.0, height: heightForInfoView)
        let info = InfoView(frame: infoFrame)
        info.textView.text = weatherImage.detail
        view.addSubview(info)

        infoView = info
    }

    // MARK: - Actions

    /// Display the infoView if not shown, otherwise dismiss the infoView
    func showInfo() {
        if infoView?.isPresented == false {
            UIView.animate(withDuration: 0.5, animations: {
                self.infoView?.frame.origin.y = 88.0
            }, completion: { (complete) in
                self.infoView?.isPresented = true
            })
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                self.infoView?.frame.origin.y = -138.0
            }, completion: { (complete) in
                self.infoView?.isPresented = false
            })
        }
    }

    /// If the infoView is showing, dismiss it. Otherwise dismiss the detail view
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
    
    /// Dismiss the detail view
    func dismissSelf() {
        navigationController?.popViewController(animated: true)
    }
    
}
