//
//  ClosureGestureRecognizer.swift
//  Artmospherez
//
//  Created by Nathan Birkholz on 6/4/17.
//  Copyright © 2017 natebirkholz. All rights reserved.
//

// Thanks to Geordie J and the Swift Users email list for help getting this working.

import UIKit

class ClosureGestureRecognizer<GestureRecognizer: UIGestureRecognizer> {
    fileprivate var recognizer: GestureRecognizer
    private var onAction: ((GestureRecognizer) -> Void)

    init(onAction: @escaping ((GestureRecognizer) -> Void)) {
        self.recognizer = GestureRecognizer()
        self.onAction = onAction

        self.recognizer.addTarget(self, action: #selector(actionHandler))
    }

    @objc dynamic private func actionHandler() {
        onAction(recognizer)
    }

    func setRecognizerDirection(_ direction: UISwipeGestureRecognizer.Direction) {
        if let swipe = recognizer as? UISwipeGestureRecognizer {
            swipe.direction = direction
        }
    }
}

extension UIView {
    func addGestureRecognizer<T>(_ gestureRecognizer: ClosureGestureRecognizer<T>) {
        self.addGestureRecognizer(gestureRecognizer.recognizer)
    }
}
