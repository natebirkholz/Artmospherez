//
//  City.swift
//  Artmospherez
//
//  Created by Nathan Birkholz on 5/22/17.
//  Copyright © 2017 natebirkholz. All rights reserved.
//

import Foundation
struct City {
    var name : String
    var zip : String
    var today : Forecast
    var forecasts : [Forecast]

    init (nameForCity : String, zipForCity: String, forecastsForCity: [Forecast]) {
        name = nameForCity
        zip = zipForCity
        today = forecastsForCity.first as Forecast!
        forecasts = forecastsForCity
    }
}
