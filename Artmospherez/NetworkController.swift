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
}

class NetworkController {

    /// Dynamically returns the url for the API call by addin the current zip code.
    /// Only works in USA
    var apiURLForecasts: String {
        let location = locationController.currentZipCode
        return "http://api.openweathermap.org/data/2.5/forecast/daily?zip=\(location),us&units=imperial&cnt=7&APPID=\(APIKey)"
    }

    var apiURLWeather: String {
        let location = locationController.currentZipCode
        return "http://api.openweathermap.org/data/2.5/weather?zip=\(location),us&units=imperial&APPID=\(APIKey)"
    }

    /// Used to determine the device's current location for the API call
    let locationController = LocationController()

    /// Fetches the JSON from the API using rhe apiURL property
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

    /// Creates the newtork call to the API to fetch the JSON as data
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
        let fetchSession = URLSession.shared
        var request = URLRequest(url: fetchURL)
        request.httpMethod = "GET"

        fetchSession.dataTask(with: request, completionHandler: { (maybeData, response, error) -> Void in
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

