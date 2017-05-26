//
//  WeatherCell.swift
//  Artmospherez
//
//  Created by Nathan Birkholz on 5/22/17.
//  Copyright © 2017 natebirkholz. All rights reserved.
//

import UIKit

class WeatherCell: MasterCell {

    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var weatherDetailLabel: UILabel!
    @IBOutlet weak var weatherTemp: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        weatherLabel.layer.cornerRadius = Constants.cornerRadius
        weatherLabel.backgroundColor = Constants.labelColor

        weatherDetailLabel.layer.cornerRadius = Constants.cornerRadius
        weatherDetailLabel.backgroundColor = Constants.labelColor
        
        weatherTemp.layer.cornerRadius = Constants.cornerRadius
        weatherTemp.backgroundColor = Constants.labelColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
