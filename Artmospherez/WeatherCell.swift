//
//  WeatherCell.swift
//  Artmospherez
//
//  Created by Nathan Birkholz on 5/22/17.
//  Copyright © 2017 natebirkholz. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var weatherImageview: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var weatherDetailLabel: UILabel!
    @IBOutlet weak var weatherTemp: UILabel!



    

    override func awakeFromNib() {
        super.awakeFromNib()

        weatherLabel.layer.cornerRadius = Constants.cornerRadius
        weatherLabel.backgroundColor = UIColor.darkGray.withAlphaComponent(Constants.labelAlpha)
        weatherDetailLabel.layer.cornerRadius = Constants.cornerRadius
        weatherDetailLabel.backgroundColor = UIColor.darkGray.withAlphaComponent(Constants.labelAlpha)
        weatherTemp.layer.cornerRadius = Constants.cornerRadius
        weatherTemp.backgroundColor = UIColor.darkGray.withAlphaComponent(Constants.labelAlpha)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
