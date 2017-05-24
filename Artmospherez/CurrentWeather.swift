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
