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
    var swipeDownRecognizer: UISwipeGestureRecognizer?
    var swipeRightRecognizer: UISwipeGestureRecognizer?
    var swipeUpRecognizer: UISwipeGestureRecognizer?
    var tapViewRecognizer: UITapGestureRecognizer?
    var infoView: InfoView?

    override var prefersStatusBarHidden: Bool { return true }

    override func viewDidLoad() {
        super.viewDidLoad()

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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func showInfo() {
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
