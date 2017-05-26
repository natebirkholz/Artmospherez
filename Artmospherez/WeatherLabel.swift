//
//  WeatherLabel.swift
//  Artmospherez
//
//  Created by Nathan Birkholz on 5/24/17.
//  Copyright © 2017 natebirkholz. All rights reserved.
//

import UIKit

class WeatherLabel: UILabel {

    /// Utility instance method to set up labels to the proper background color and corner radius
    func setup() {
        backgroundColor = Constants.labelColor
        layer.cornerRadius = Constants.cornerRadius
        clipsToBounds = true
    }

    // Overrides the width of the label to privide some padding on each side. Works without
    // edge insets because all labels in the app are set to center justification
    override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        size.width = size.width + 8
        return size
    }
}
