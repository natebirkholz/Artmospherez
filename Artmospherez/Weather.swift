//
//  Weather.swift
//  Artmospherez
//
//  Created by Nathan Birkholz on 5/22/17.
//  Copyright © 2017 natebirkholz. All rights reserved.
//

import Foundation

enum WeatherKind: String {
    case sunny = "sunny"
    case rainy = "rainy"
    case windy = "windy"
    case thunderstorm = "thunderstorm"
    case tornado = "tornado"
    case cloudy = "cloudy"
    case gray = "gray"
    case foggy = "foggy"
    case snowy = "snowy"
    case blizzard = "blizzard"
    case hurricane = "hurricane"
    case apocalyptic = "apocalyptic"
}

struct Weather {
    var kind: WeatherKind
    var image: WeatherImage? = nil

    init (weatherKind: WeatherKind) {
        kind = weatherKind
//        image = self.generateWeatherImageForWeatherForWeatherTypeName(weatherKind)
    }

//    func generateWeatherImageForWeatherForWeatherTypeName(_ weatherKind: WeatherKind) -> WeatherImage {
//        
//    }
}
