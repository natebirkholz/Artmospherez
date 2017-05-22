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
    var kind : Weather
    var humidity : Int
    var maxTemp : Int
    var minTemp : Int

    init (dayValue: String, weatherID: Weather, humidityValue: Int, maxTempValue: Int, minTempValue: Int) {
        day = dayValue
        kind = weatherID
        humidity = humidityValue
        maxTemp = maxTempValue
        minTemp = minTempValue
    }
}
