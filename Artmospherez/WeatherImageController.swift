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

        guard let image2 = UIImage(named: "sun2") else { return }
        let sunny2 = WeatherImage(id: "sun2", image: image2, artist: "George Inness", title: "The Lackawanna Valley")
        sunnyImages.append(sunny2)
    }

    private func createRainyImages() {
        guard let image1 = UIImage(named: "rain1") else { return }
        let rainy1 =  WeatherImage(id: "rain1", image: image1, artist: "Gustave Caillebotte", title: "Paris Street; Rainy Day")
        rainyImages.append(rainy1)

        guard let image3 = UIImage(named: "rain3") else { return }
        let rainy3 = WeatherImage(id: "rain3", image: image3, artist: "Utagawa Hiroshige", title: "Sudden Shower over Shin-Ōhashi Bridge and Atake")
        rainyImages.append(rainy3)

        guard let image4 = UIImage(named: "rain4") else { return }
        let rainy4 = WeatherImage(id: "rain4", image: image4, artist: "Anton Mauve", title: "Changing Pasture")
        rainyImages.append(rainy4)
    }

    private func createWindyImages() {

    }

    private func createThunderstormImages() {

    }

    private func createTornadoImages() {

    }

    private func createCloudyImages() {
        guard let image1 = UIImage(named: "clouds1") else { return }
        let cloudy1 =  WeatherImage(id: "clouds1", image: image1, artist: "Albert Bierstadt", title: "Wind River Country")
        cloudyImages.append(cloudy1)

        guard let image2 = UIImage(named: "clouds2") else { return }
        let cloudy2 = WeatherImage(id: "clouds2", image: image2, artist: "John Constable", title: "Wivenhoe Park")
        cloudyImages.append(cloudy2)
    }

    private func createOvercastImages() {

    }

    private func createFoggyImages() {
        guard let image1 = UIImage(named: "fog1") else { return }
        let foggy1 =  WeatherImage(id: "fog1", image: image1, artist: "Claude Monet", title: "The Houses of Parliament (Effect of Fog)")
        foggyImages.append(foggy1)

        guard let image2 = UIImage(named: "fog2") else { return }
        let foggy2 =  WeatherImage(id: "fog2", image: image2, artist: "Alfred Sisley", title: "Fog, Voisins")
        foggyImages.append(foggy2)
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
