//
//  MasterCell.swift
//  Artmospherez
//
//  Created by Nathan Birkholz on 5/24/17.
//  Copyright © 2017 natebirkholz. All rights reserved.
//

import UIKit

class MasterCell: UITableViewCell {

    var activity: UIActivityIndicatorView?
    var weatherImage: WeatherImage!

    override func awakeFromNib() {
        super.awakeFromNib()

        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
        contentView.addSubview(indicator)
        indicator.center = contentView.center
        indicator.hidesWhenStopped = true
        activity = indicator

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
