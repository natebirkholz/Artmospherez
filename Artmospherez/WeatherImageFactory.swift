//
//  WeatherImageFactory.swift
//  Artmospherez
//
//  Created by Nathan Birkholz on 5/23/17.
//  Copyright © 2017 natebirkholz. All rights reserved.
//

import UIKit

class WeatherImageFactory {
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

        guard let image3 = UIImage(named: "sun3") else { return }
        let sunny3 = WeatherImage(id: "sun3", image: image3, artist: "William Merritt Chase", title: "At the Seaside")
        sunnyImages.append(sunny3)
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
        guard let image1 = UIImage(named: "wind1") else { return }
        let windy1 =  WeatherImage(id: "wind1", image: image1, artist: "Vinvent van Gogh", title: "Wheat Field Behind Saint-Paul")
        windyImages.append(windy1)

        guard let image2 = UIImage(named: "wind2") else { return }
        let windy2 = WeatherImage(id: "wind2", image: image2, artist: "David Cox the Elder", title: "Shepherding the Flock, Windy Day")
        windyImages.append(windy2)
    }

    private func createThunderstormImages() {
        guard let image1 = UIImage(named: "tstorm1") else { return }
        let storm1 =  WeatherImage(id: "tstorm1", image: image1, artist: "Albert Bierstadt", title: "A Storm in the Rocky Mountains, Mt. Rosalie")
        thunderstormImages.append(storm1)

        guard let image2 = UIImage(named: "tstorm2") else { return }
        let storm2 = WeatherImage(id: "tstorm2", image: image2, artist: "Francisque Millet", title: "Mountain Landscape with Lightning")
        thunderstormImages.append(storm2)
    }

    private func createTornadoImages() {
        guard let image1 = UIImage(named: "tornado1") else { return }
        let tornado1 = WeatherImage(id: "tornado1", image: image1, artist: "Julius Holm", title: "Tornado over St. Paul")
        tornadoImages.append(tornado1)
    }

    private func createCloudyImages() {
        guard let image1 = UIImage(named: "clouds1") else { return }
        let cloudy1 =  WeatherImage(id: "clouds1", image: image1, artist: "Albert Bierstadt", title: "Wind River Country")
        cloudyImages.append(cloudy1)

        guard let image2 = UIImage(named: "clouds2") else { return }
        let cloudy2 = WeatherImage(id: "clouds2", image: image2, artist: "John Constable", title: "Wivenhoe Park")
        cloudyImages.append(cloudy2)

        guard let image3 = UIImage(named: "clouds3") else { return }
        let cloudy3 = WeatherImage(id: "clouds3", image: image3, artist: "Philips Koninck", title: "An Extensive Wooded Landscape")
        cloudyImages.append(cloudy3)
    }

    private func createOvercastImages() {
        guard let image1 = UIImage(named: "gray1") else { return }
        let gray1 =  WeatherImage(id: "gray1", image: image1, artist: "Jacob Isaacksz. van Ruisdael", title: "View of Naarden")
        overcastImages.append(gray1)

        guard let image2 = UIImage(named: "gray2") else { return }
        let gray2 =  WeatherImage(id: "gray2", image: image2, artist: "El Greco", title: "View of Toledo")
        overcastImages.append(gray2)
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
        guard let image1 = UIImage(named: "snow1") else { return }
        let snowy1 =  WeatherImage(id: "snow1", image: image1, artist: "Paul Gauguin", title: "Winter Landscape, Effect of Snow")
        snowyImages.append(snowy1)

        guard let image2 = UIImage(named: "snow2") else { return }
        let snowy2 =  WeatherImage(id: "snow2", image: image2, artist: "Ando Hiroshige", title: "Evening Snow at Kanbara")
        snowyImages.append(snowy2)
    }

    private func createBlizzardImages() {
        // For future development
    }

    private func createHurricaneImages() {
        // For future development
    }

    /// Volcano, fire, smoke, etc. The API returns some crazy stuff.
    private func createApocalypticImages() {
        // For future development
    }
}
