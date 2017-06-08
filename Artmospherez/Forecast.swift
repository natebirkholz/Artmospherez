//
//  Forecast.swift
//  Artmospherez
//
//  Created by Nathan Birkholz on 5/22/17.
//  Copyright © 2017 natebirkholz. All rights reserved.
//

import Foundation

struct Forecast {
    var day : String
    var kind : WeatherKind
    var humidity : Int
    var maxTemp : Int
    var minTemp : Int
    var weatherImage: WeatherImage?

    init(dayValue: String, weatherID: WeatherKind, humidityValue: Double, maxTempValue: Double, minTempValue: Double) {
        day = dayValue
        kind = weatherID
        humidity = Int(humidityValue)
        maxTemp = Int(maxTempValue)
        minTemp = Int(minTempValue)
    }
}
