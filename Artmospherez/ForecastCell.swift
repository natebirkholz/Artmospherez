//
//  ForecastCell.swift
//  Artmospherez
//
//  Created by Nathan Birkholz on 5/22/17.
//  Copyright © 2017 natebirkholz. All rights reserved.
//

import UIKit

class ForecastCell: MasterCell {

    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var weatherLabel: WeatherLabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        weatherLabel.setup()
    }
}
