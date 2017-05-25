//
//  InfoView.swift
//  Artmospherez
//
//  Created by Nathan Birkholz on 5/25/17.
//  Copyright © 2017 natebirkholz. All rights reserved.
//

import UIKit

class InfoView: UIView {

    var textView: UITextView!
    var isPresented = false

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = Constants.labelColorDark
        layer.cornerRadius = 10.0
        clipsToBounds = true
        isUserInteractionEnabled = false

        let insetFrame =  CGRect(x: 8, y: 8, width: frame.width - 16, height: frame.width - 16)
        let textBox = UITextView(frame: insetFrame)
        textBox.isScrollEnabled = false
        textBox.font = UIFont(name: "Didot", size: 14)
        textBox.textColor = UIColor.white
        textBox.backgroundColor = UIColor.clear
        textBox.isUserInteractionEnabled = false
        addSubview(textBox)
        textView = textBox
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /* override func draw(_ rect: CGRect) {
        super.draw(rect)

    } */


}
