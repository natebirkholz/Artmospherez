//
//  WeatherImageController.swift
//  Artmospherez
//
//  Created by Nathan Birkholz on 5/23/17.
//  Copyright © 2017 natebirkholz. All rights reserved.
//

import UIKit

class WeatherImageController {
    var sunnyImages = [WeatherImage]()
    var rainyImages = [WeatherImage]()
    var windyImages = [WeatherImage]()
    var thunderstormImages = [WeatherImage]()
    var tornadoImages = [WeatherImage]()
    var cloudyImages = [WeatherImage]()
    var overcastImages = [WeatherImage]()
    var foggyImages = [WeatherImage]()
    var snowyImages = [WeatherImage]()
    var blizzardImages = [WeatherImage]()
    var hurricaneImages = [WeatherImage]()
    var apocalypticImages = [WeatherImage]()

    init() {
        createFoggyImages()
        createRainyImages()
        createSnowyImages()
        createSunnyImages()
        createWindyImages()
        createCloudyImages()
        createTornadoImages()
        createBlizzardImages()
        createOvercastImages()
        createHurricaneImages()
        createApocalypticImages()
        createThunderstormImages()
    }

    private func createSunnyImages() {
        guard let image1 = UIImage(named: "sun1") else { return }
        let sunny1 = WeatherImage(id: "sun1", image: image1, artist: "Georges Pierre Seurat", title: "Bathers at Asnières")
        sunnyImages.append(sunny1)
    }

    private func createRainyImages() {
        guard let image1 = UIImage(named: "rain1") else { return }
        let rainy1 =  WeatherImage(id: "rain1", image: image1, artist: "Gustave Caillebotte", title: "Paris Street; Rainy Day")
        rainyImages.append(rainy1)

        guard let image2 = UIImage(named: "rain2") else { return }
        let rainy2 = WeatherImage(id: "rain2", image: image2, artist: "Vincent Van Gogh", title: "Rain or Enclosed Wheat Field in the Rain")
        rainyImages.append(rainy2)
    }

    private func createWindyImages() {

    }

    private func createThunderstormImages() {

    }

    private func createTornadoImages() {

    }

    private func createCloudyImages() {

    }

    private func createOvercastImages() {

    }

    private func createFoggyImages() {

    }

    private func createSnowyImages() {

    }

    private func createBlizzardImages() {

    }

    private func createHurricaneImages() {

    }

    private func createApocalypticImages() {

    }
}

/*
case sunny = "Sunny"
case rainy = "Rainy"
case windy = "Windy"
case thunderstorm = "Thunderstorm"
case tornado = "Tornado"
case cloudy = "Cloudy"
case overcast = "Overcast"
case foggy = "Foggy"
case snowy = "Snowy"
case blizzard = "Blizzard"
case hurricane = "Hurricane"
case apocalyptic = "Apocalyptic!"
 */
