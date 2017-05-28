//
//  NetworkController.swift
//  Artmospherez
//
//  Created by Nathan Birkholz on 5/22/17.
//  Copyright © 2017 natebirkholz. All rights reserved.
//

import Foundation
import CoreLocation

enum NetworkControllerError {
    case badURL
    case noData
    case noResponse
    case failedResponse
    case unknownError
    case parseError
    case failedLocation
}

protocol NetworkControllerDelegate: class {
    func showStillWorking()
}

class NetworkController {

    var loadingTimer: Timer?

    // MARK: - Properties

    /// Dynamically returns the url for the forecasts API call by adding the current zip code.
    /// Only works in USA
    var apiURLForecasts: String {
        let location: String
        if locationControllerDelegate?.didRejectLocationAuthorization == false {
            location = locationController.currentZipCode ?? "92102"
        } else {
            location = "92102"
        }
        return "http://api.openweathermap.org/data/2.5/forecast/daily?zip=\(location),us&units=imperial&cnt=7&APPID=\(APIKey)"
    }

    /// Dynamically returns the url for the current weather API call by adding the current zip code.
    /// Only works in USA
    var apiURLWeather: String {
        let location: String
        if locationControllerDelegate?.didRejectLocationAuthorization == false {
            location = locationController.currentZipCode ?? "92102"
        } else {
            location = "92102"
        }
        return "http://api.openweathermap.org/data/2.5/weather?zip=\(location),us&units=imperial&APPID=\(APIKey)"
    }

    /// Used to determine the device's current location for the API call
    let locationController = LocationController()

    weak var locationControllerDelegate: LocationControllerDelegate? {
        didSet {
            locationController.delegate = locationControllerDelegate
        }
    }

    weak var delegate: NetworkControllerDelegate?

    // MARK: - Methods

    /// Fetches forecasts JSON from the API using rhe apiURLForecasts property
    ///
    /// - Parameter completionHandler: returns an optional array of forecasts of successful, a optional NetworkControllerError error if unsuccessful
    func getJSONForForecasts(_ completionHandler: @escaping (_ forecasts: [Forecast]?, _ error: NetworkControllerError?) -> ()) {
        fetchJSONFromURL(apiURLForecasts, completionHandler: { (maybeDataFromURL, maybeError) -> () in
            DispatchQueue.main.async {
                guard let dataResult = maybeDataFromURL else {
                    completionHandler(nil, maybeError ?? .unknownError)
                    return
                }

                do {
                    let parser = JsonParser()
                    let forecasts = try parser.parseJSONIntoForecasts(dataResult)
                    completionHandler(forecasts, nil)
                } catch {
                    completionHandler(nil, .parseError)
                }
            }

        })
    }

    /// Fetches current weather JSON from the apiURLWeather property
    ///
    /// - Parameter completionHandler: callback when complete, pass current weather or error
    func getCurrentWeather(_ completionHandler: @escaping (_ currentWeather: CurrentWeather?, _ error: NetworkControllerError?) -> ()) {
        fetchJSONFromURL(apiURLWeather) { (maybeData, maybeError) in
            DispatchQueue.main.async {
                guard let dataResult = maybeData else {
                    completionHandler(nil, maybeError ?? .unknownError)
                    return
                }

                do{
                    let parser = JsonParser()
                    let currentWeather = try parser.parseJSONIntoCurrentWeather(dataResult)
                    completionHandler(currentWeather, nil)
                } catch {
                    completionHandler(nil, .parseError)
                }
            }
        }
    }

    /// Creates a network call to the API to fetch JSON as data
    ///
    /// - Parameters:
    ///   - aURL: the url for the api call
    ///   - completionHandler: returns optional data if successful, an optional NetworkControllerError if unsuccessful
    func fetchJSONFromURL(_ aURL: String, completionHandler: @escaping (_ dataFromURL: Data?, _ error: NetworkControllerError?) -> ()) {
        guard let fetchURL = URL(string: aURL) else {
            assertionFailure("Failed to initialize URL from string \(aURL)")
            completionHandler(nil, .badURL)
            return
        }

        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 16
        config.timeoutIntervalForResource = 16
        let fetchSession = URLSession(configuration: config)

        var request = URLRequest(url: fetchURL)
        request.httpMethod = "GET"

        // Shows amessage on the home screen if the network call is taking a while (8 seconds).
        let timer = Timer.scheduledTimer(withTimeInterval: 8.0, repeats: false) { [weak self] (timerRef) in
            if let isTimer = self?.loadingTimer, isTimer.isValid {
                isTimer.invalidate()
                DispatchQueue.main.async {
                    self?.delegate?.showStillWorking()
                }
            }

            timerRef.invalidate()
        }

        loadingTimer = timer

        fetchSession.dataTask(with: request, completionHandler: { [weak self] (maybeData, response, error) -> Void in
            self?.loadingTimer?.invalidate()
            guard let dataFromRequest = maybeData else {
                completionHandler(nil, .noData)
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200:
                    completionHandler(dataFromRequest, nil)
                default:
                    completionHandler(dataFromRequest, .failedResponse)
                }
            } else {
                completionHandler(nil, .noResponse)
            }
        }).resume()
    }
}

