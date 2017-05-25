//
//  AnimateToForecastDetailController.swift
//  Artmospherez
//
//  Created by Nathan Birkholz on 5/24/17.
//  Copyright © 2017 natebirkholz. All rights reserved.
//

import UIKit

class AnimateToForecastDetailController: NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewController(forKey: .from) as! ViewController
        let toViewController = transitionContext.viewController(forKey: .to) as! DetailViewControllerForecast
        let containerView = transitionContext.containerView
        let duration = transitionDuration(using: transitionContext)

        guard let selectedRow = fromViewController.tableView.indexPathForSelectedRow else {
            assertionFailure("no row selected in tableview")
            return
        }
        let selectedCell = fromViewController.tableView.cellForRow(at: selectedRow) as! ForecastCell
        guard let weatherImage = selectedCell.weatherImageView.image else {
            assertionFailure("Unable to fetch the selected cell's weatherImageView.image")
            return
        }
        let weatherSnapshot = UIImageView(image: weatherImage)
        weatherSnapshot.clipsToBounds = true
        weatherSnapshot.contentMode = .scaleAspectFill

        weatherSnapshot.frame = containerView.convert(selectedCell.weatherImageView.bounds, from: fromViewController.tableView.cellForRow(at: selectedRow))
        selectedCell.contentView.isHidden = true

        toViewController.view.frame = transitionContext.finalFrame(for: toViewController)
        toViewController.imageView.alpha = 0
        toViewController.view.isHidden = true
        // Update layout to clean up begnning positions of labels on detail VC, Size Classes issue
        toViewController.view.setNeedsLayout()
        toViewController.view.layoutIfNeeded()

        containerView.addSubview(toViewController.view)
        containerView.addSubview(weatherSnapshot)
        UIView.animate(withDuration: duration, animations: { () -> Void in
            // Update layout to set proper target for final frame of animation, Size Classes issue
            toViewController.view.setNeedsLayout()
            toViewController.view.layoutIfNeeded()

            weatherSnapshot.frame = toViewController.view.frame
            toViewController.imageView.alpha = 1.0

        }, completion: { (finished) -> Void in
            UIImageView.animate(withDuration: 0.5, animations: {
                toViewController.view.isHidden = false
                toViewController.imageView.isHidden = false
                selectedCell.weatherImageView.isHidden = false
                weatherSnapshot.removeFromSuperview()
                toViewController.view.setNeedsLayout()
                toViewController.view.layoutIfNeeded()
                selectedCell.contentView.isHidden = false
            }, completion: { (complete) in
                transitionContext.completeTransition(true)
            })
        })
    }
    
} // End
