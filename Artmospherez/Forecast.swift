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

    init (day: String, weatherID: Weather, humidity: Int, maxTemp: Int, minTemp: Int) {
        day = day
        kind = weatherID
        humidity = humidity
        maxTemp = maxTemp
        minTemp = minTemp
    }
}
