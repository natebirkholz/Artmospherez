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




    var weather: CurrentWeather!
    var image: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = image
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
