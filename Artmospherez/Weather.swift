//
//  Weather.swift
//  Artmospherez
//
//  Created by Nathan Birkholz on 5/22/17.
//  Copyright © 2017 natebirkholz. All rights reserved.
//

import Foundation

struct Weather {
    var name : String
    var image: WeatherImage

    init (nameForWeather: String) {
        name = nameForWeather
        image = self.generateWeatherImageForWeatherForWeatherTypeName(nameForWeather)
    }

    func generateWeatherImageForWeatherForWeatherTypeName(_ typeName: String) -> WeatherImage {
        
    }
}
