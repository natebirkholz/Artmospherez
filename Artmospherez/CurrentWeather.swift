//
//  CurrentWeather.swift
//  Artmospherez
//
//  Created by Nathan Birkholz on 5/23/17.
//  Copyright © 2017 natebirkholz. All rights reserved.
//

import Foundation


struct CurrentWeather {
    var kind: WeatherKind
    var humidity: Int
    var maxTemp: Int
    var minTemp: Int
    var currentTemp: Int
    var windSpeed: Int
    var windDirection: Int
    var cityName: String
    var weatherImage: WeatherImage?

    var windCompassDirection: String {
        switch windDirection {
        case 0...23:
            return "N"
        case 24...68:
            return "NE"
        case 69...113:
            return "E"
        case 114...158:
            return "SE"
        case 159...203:
            return "S"
        case 204...248:
            return "SW"
        case 249...293:
            return "W"
        case 294...338:
            return "NW"
        default:
            return "N"
        }
    }

    init(kind: WeatherKind, humidity: Int, maxTemp: Int, minTemp: Int, currentTemp: Int, windSpeed: Int, windDirection: Int, cityName: String) {
        self.kind = kind
        self.humidity = humidity
        self.maxTemp = maxTemp
        self.minTemp = minTemp
        self.currentTemp = currentTemp
        self.windSpeed = windSpeed
        self.windDirection = windDirection
        self.cityName = cityName
    }
}

extension CurrentWeather: CustomStringConvertible {
    var description: String {
        return "currentTemp: \(currentTemp), kind: \(kind.rawValue), humidity: \(humidity), max: \(maxTemp), min: \(minTemp), windSpeed: \(windSpeed), windDirection: \(windCompassDirection) (\(windDirection)), cityName: \(cityName)"
    }
}
