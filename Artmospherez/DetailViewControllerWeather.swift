//
//  DetailViewControllerWeather.swift
//  Artmospherez
//
//  Created by Nathan Birkholz on 5/24/17.
//  Copyright © 2017 natebirkholz. All rights reserved.
//

import UIKit

class DetailViewControllerWeather: UIViewController {


    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var mainLabel: UILabel!




    var weather: CurrentWeather!
    var image: UIImage!
    var swipeDown: UISwipeGestureRecognizer?
    var tap: UITapGestureRecognizer?

    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = image

        let downRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(dismissSelf(_:)))
        downRecognizer.direction = .down
        view.addGestureRecognizer(downRecognizer)
        swipeDown = downRecognizer

        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissSelf(_:)))
        view.addGestureRecognizer(tapRecognizer)
        tap = tapRecognizer

        let mainLabelText = " \(weather.kind.rawValue), \(weather.currentTemp)° "
        mainLabel.text = mainLabelText
        mainLabel.sizeToFit()
        mainLabel.clipsToBounds = true
        mainLabel.layer.cornerRadius = 10.0
        mainLabel.backgroundColor = UIColor.darkGray.withAlphaComponent(Constants.labelAlpha)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func dismissSelf(_ sender: UIGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }

}
