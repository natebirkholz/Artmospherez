//
//  DetailViewControllerForecast.swift
//  Artmospherez
//
//  Created by Nathan Birkholz on 5/24/17.
//  Copyright © 2017 natebirkholz. All rights reserved.
//

import UIKit

class DetailViewControllerForecast: UIViewController, UINavigationControllerDelegate, InfoDisplay {

    // MARK: - Properties

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var mainLabel: WeatherLabel!
    @IBOutlet weak var maxMinLabel: WeatherLabel!
    @IBOutlet weak var infoButton: UtilityButton!
    @IBOutlet weak var ghostButton: UtilityButton!
    @IBOutlet weak var closeButton: UtilityButton!
    @IBOutlet weak var ghostCloseButton: UtilityButton!

    var forecast: Forecast?
    var weatherImage: WeatherImage?
    var image: UIImage?
    var swipeDownRecognizer: ClosureGestureRecognizer<UISwipeGestureRecognizer>?
    var swipeRightRecognizer: ClosureGestureRecognizer<UISwipeGestureRecognizer>?
    var swipeUpRecognizer: ClosureGestureRecognizer<UISwipeGestureRecognizer>?
    var blockTapViewRecognizer: ClosureGestureRecognizer<UITapGestureRecognizer>?
    var infoView: InfoView?
    weak var navController: UINavigationController? {
        return navigationController
    }

    override var prefersStatusBarHidden: Bool { return true }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.setNeedsLayout()
        view.layoutIfNeeded()

        // Gesture recognizers

        let swipeBlock: (UISwipeGestureRecognizer) -> () = { [weak self] (_) in
            self?.dismissSelf()
        }
        
        view.clipsToBounds = true

        let downRecognizer = ClosureGestureRecognizer<UISwipeGestureRecognizer>(onAction: swipeBlock)
        downRecognizer.setRecognizerDirection(.down)
        view.addGestureRecognizer(downRecognizer)
        swipeDownRecognizer = downRecognizer

        let upRecognizer = ClosureGestureRecognizer<UISwipeGestureRecognizer>(onAction: swipeBlock)
        upRecognizer.setRecognizerDirection(.up)
        view.addGestureRecognizer(upRecognizer)
        swipeUpRecognizer = upRecognizer

        let rightRecognizer = ClosureGestureRecognizer<UISwipeGestureRecognizer>(onAction: swipeBlock)
        rightRecognizer.setRecognizerDirection(.right)
        view.addGestureRecognizer(rightRecognizer)
        swipeRightRecognizer = rightRecognizer

        let tapBlock: (UITapGestureRecognizer) -> () = { [weak self] (_) in
            self?.didTap()
        }

        let blockTapRecognizer = ClosureGestureRecognizer<UITapGestureRecognizer>(onAction: tapBlock)
        view.addGestureRecognizer(blockTapRecognizer)
        self.blockTapViewRecognizer = blockTapRecognizer

        // Views
        
        if let image = self.image {
            imageView.image = image
        }
        
        if let forecast = self.forecast {
            let mainText = "\(forecast.day), \(forecast.kind.rawValue)"
            mainLabel.text = mainText
            mainLabel.sizeToFit()
            mainLabel.setup()

            let maxMinText = "\(forecast.maxTemp)°/\(forecast.minTemp)°"
            maxMinLabel.text = maxMinText
            maxMinLabel.sizeToFit()
            maxMinLabel.setup()
        }

        let blockForInfo: () -> () = { [weak self] in
            self?.showInfo()
        }

        // Has a larger hit area than the visible button
        ghostButton.addClosure(blockForInfo)

        infoButton.backgroundColor = Constants.labelColor
        infoButton.setup()
        infoButton.addClosure(blockForInfo)

        let blockForClose: () -> () = { [weak self] in
            self?.dismissSelf()
        }

        closeButton.backgroundColor = Constants.labelColor
        closeButton.setup()
        closeButton.addClosure(blockForClose)

        // Has a larger hit area than the visible button
        ghostCloseButton.addClosure(blockForClose)
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
        
        if let weatherImage = self.weatherImage {
            let infoFrame = CGRect(x: 8.0, y: -138.0, width: view.frame.width - 16.0, height: heightForInfoView)
            let info = InfoView(frame: infoFrame)
            info.textView?.text = weatherImage.detail
            view.addSubview(info)
            
            infoView = info
        }        
    }
}
