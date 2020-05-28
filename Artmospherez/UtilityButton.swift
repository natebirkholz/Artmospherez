//
//  UtilityButton.swift
//  Artmospherez
//
//  Created by Nathan Birkholz on 5/26/17.
//  Copyright © 2017 natebirkholz. All rights reserved.
//

import UIKit

class UtilityButton: UIButton {
    fileprivate var onAction: (() -> ())?

    /// Utility instance method to set up buttons to the proper background color and corner radius
    func setup() {
        backgroundColor = Constants.labelColor
        layer.cornerRadius = 14.0
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.white.cgColor
        clipsToBounds = true
    }

    // Overrides the width of the label to privide some padding on each side. Works without
    // edge insets because all labels in the app are set to center justification
    override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        size.width = size.width + 4
        return size
    }

    func addClosure(_ closure: @escaping () -> ()) {
        self.addTarget(self, action: #selector(actionHandler), for: .touchUpInside)
        self.onAction = closure
    }

    @objc dynamic fileprivate func actionHandler() {
        onAction?()
    }

}
