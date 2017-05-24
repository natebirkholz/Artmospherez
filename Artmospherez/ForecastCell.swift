//
//  ForecastCell.swift
//  Artmospherez
//
//  Created by Nathan Birkholz on 5/22/17.
//  Copyright © 2017 natebirkholz. All rights reserved.
//

import UIKit

class ForecastCell: UITableViewCell {

    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        weatherLabel.layer.cornerRadius = Constants.cornerRadius
        weatherLabel.backgroundColor = UIColor.darkGray.withAlphaComponent(Constants.labelAlpha)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
