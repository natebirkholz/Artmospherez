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
    var didRejectLocationAuthorization: Bool? { get set }
    func refreshLocations()
}

enum LocationError {
    case failed
}

class LocationController: NSObject, CLLocationManagerDelegate {

    // MARK: - Properties

    var currentZipCode: String? {
        didSet {
            delegate?.refreshLocations()
        }
    }
    var locationManager = CLLocationManager()
    var geocoder = CLGeocoder()
    var geocodeTimeoutTimer: Timer?

    weak var delegate: LocationControllerDelegate?

    // MARK: - Initialization

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        delegate = nil

        if let location = locationManager.location {
            geocoder.reverseGeocodeLocation(location) { [weak self] (maybePlaces, maybeError) in
                if let count = maybePlaces?.count, count > 0 {
                    if let place = maybePlaces?[0], let code = place.postalCode {
                        self?.currentZipCode = code
                    }
                }
            }
        }

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
        guard !geocoder.isGeocoding else { return }
        geocoder.reverseGeocodeLocation(locations[0], completionHandler: { [weak self] (places, error) -> Void in
            if error != nil { return }
            if let count = places?.count, count > 0 {
                if let place = places?[0], let code = place.postalCode, let oldCode = self?.currentZipCode, oldCode != code {
                    self?.currentZipCode = code
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
            delegate?.didRejectLocationAuthorization = false
            delegate?.refreshLocations()
        case .denied:
            delegate?.didRejectLocationAuthorization = true
        default:
            break
        }
    }

    // MARK: - Utilities

    /// Updates the currentZipCode by explicit call instead of in locationManager: didUpdateLocations:
    ///
    /// - Parameter completionHandler: callback upon completion
    func updateLocation(completionHandler: @escaping (LocationError?) -> ()) {
        if geocoder.isGeocoding { return }

        if let didReject = delegate?.didRejectLocationAuthorization, didReject {
            completionHandler(nil)
            return
        } else if CLLocationManager.authorizationStatus() == .denied {
            completionHandler(nil)
            return
        }

        if let thisLocation = locationManager.location {

            // Times the request out if it is taking too long.
            let timer = Timer.scheduledTimer(withTimeInterval: 15, repeats: false, block: { [weak self] (timerRef) in
                if let isTimer = self?.geocodeTimeoutTimer, isTimer.isValid {
                    completionHandler(.failed)
                    self?.geocoder.cancelGeocode()
                }
            })

            self.geocodeTimeoutTimer = timer

            geocoder.reverseGeocodeLocation(thisLocation, completionHandler: { [weak self] (maybePlaces, error) -> Void in
                if error != nil {
                    self?.geocoder.cancelGeocode()
                    self?.geocodeTimeoutTimer?.invalidate()
                    completionHandler(.failed)
                    return
                }

                if let count = maybePlaces?.count, count > 0 {
                    if let place = maybePlaces?[0], let code = place.postalCode {
                        self?.geocodeTimeoutTimer?.invalidate()
                        self?.currentZipCode = code
                        completionHandler(nil)
                    }
                } else {
                    self?.geocodeTimeoutTimer?.invalidate()
                    completionHandler(.failed)
                }
            })
        }
    }
}
