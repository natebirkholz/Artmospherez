//
//  InfoView.swift
//  Artmospherez
//
//  Created by Nathan Birkholz on 5/25/17.
//  Copyright © 2017 natebirkholz. All rights reserved.
//

import UIKit

/// Specifies a set of properties and methods for implementing info buttons and info views
/// on detail view controllers.
protocol InfoDisplay: class {
    var infoButton: UtilityButton! { get set }
    var navController: UINavigationController? { get } // in swift 4, use composition instead
    var infoView: InfoView? { get set }
    func showInfo()
    func didTap()
    func dismissSelf()
}

extension InfoDisplay {
    /// Display the infoView if not shown, otherwise dismiss the infoView
    func showInfo() {
        if infoView?.isPresented == false {
            UIView.animate(withDuration: 0.5, animations: { [weak self] in
                self?.infoView?.frame.origin.y = 138.0
                }, completion: { [weak self] (complete) in
                    self?.infoView?.isPresented = true
            })
        } else {
            UIView.animate(withDuration: 0.5, animations: { [weak self] in
                self?.infoView?.frame.origin.y = -138.0
                }, completion: { [weak self] (complete) in
                    self?.infoView?.isPresented = false
            })
        }
    }

    /// If the infoView is showing, dismiss it. Otherwise dismiss the detail view
    func didTap() {
        if let presented = infoView?.isPresented {
            if presented {
                showInfo()
            } else {
                dismissSelf()
            }
        } else {
            dismissSelf()
        }
    }

    /// Dismiss the detail view
    func dismissSelf() {
        navController?.popViewController(animated: true)
    }
}

class InfoView: UIView {

    var textView: UITextView?
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
