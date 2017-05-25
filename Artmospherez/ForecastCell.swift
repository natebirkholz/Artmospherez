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
    @IBOutlet weak var weatherLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        weatherLabel.layer.cornerRadius = Constants.cornerRadius
        weatherLabel.backgroundColor = Constants.labelColor

        if let indicator = activity {
            contentView.bringSubview(toFront: indicator)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
