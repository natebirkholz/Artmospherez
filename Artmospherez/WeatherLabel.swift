//
//  WeatherLabel.swift
//  Artmospherez
//
//  Created by Nathan Birkholz on 5/24/17.
//  Copyright © 2017 natebirkholz. All rights reserved.
//

import UIKit

class WeatherLabel: UILabel {

    override func drawText(in rect: CGRect) {
        let insets: UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 4.0)
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }

}
