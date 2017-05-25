//
//  LocationController.swift
//  Artmospherez
//
//  Created by Nathan Birkholz on 5/22/17.
//  Copyright © 2017 natebirkholz. All rights reserved.
//

import Foundation
import CoreLocation

/// Calls delegate when location has changed
protocol LocationControllerDelegate: class {
    func refreshLocations()
}

class LocationController: NSObject, CLLocationManagerDelegate {

    // MARK: - Properties

    var currentZipCode: String = ""
    var locationManager = CLLocationManager()

    weak var delegate: LocationControllerDelegate?

    // MARK: - Initialization

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        delegate = nil
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        default:
            break
        }
    }

    convenience init(locationControllerDelegate: LocationControllerDelegate) {
        self.init()
        delegate = locationControllerDelegate
    }

    // MARK: - CLLocationManagerDelegate

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(locations[0], completionHandler: {(places, error) -> Void in
            if error != nil { return }
            if let count = places?.count, count > 0 {
                if let place = places?[0], let code = place.postalCode {
                    self.currentZipCode = code
                }
            }
        })
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            delegate?.refreshLocations()
        default:
            break
        }
    }

    // MARK: - Utilities

    /// Updates the currentZipCode by explicit call instead of in locationManager: didUpdateLocations:
    ///
    /// - Parameter completionHandler: callback upon completion
    func updateLocation(completionHandler: @escaping ()->()) {
        if let  thisLocation = locationManager.location {
            CLGeocoder().reverseGeocodeLocation(thisLocation, completionHandler: {(places, error) -> Void in
                if error != nil {
                    print(error?.localizedDescription as Any)
                    completionHandler()
                    return
                }

                if let count = places?.count, count > 0 {
                    if let place = places?[0], let code = place.postalCode {
                        self.currentZipCode = code
                        completionHandler()
                    }
                } else {
                    completionHandler()
                }
            })
        }
    }
}
