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
        if let image1 = UIImage(named: "sun1") {
            let sunny1 = WeatherImage(id: "sun1", image: image1, artist: "Georges Pierre Seurat", title: "Bathers at Asnières")
            sunnyImages.append(sunny1)
        }

        if let image2 = UIImage(named: "sun2") {
            let sunny2 = WeatherImage(id: "sun2", image: image2, artist: "George Inness", title: "The Lackawanna Valley")
            sunnyImages.append(sunny2)
        }

        if let image3 = UIImage(named: "sun3") {
            let sunny3 = WeatherImage(id: "sun3", image: image3, artist: "William Merritt Chase", title: "At the Seaside")
            sunnyImages.append(sunny3)
        }

        if let image4 = UIImage(named: "sun4") {
            let sunny4 = WeatherImage(id: "sun4", image: image4, artist: "Alfred Sisley", title: "Sahurs Meadows in Morning Sun")
            sunnyImages.append(sunny4)
        }
    }

    private func createRainyImages() {
        if let image1 = UIImage(named: "rain1") {
            let rainy1 =  WeatherImage(id: "rain1", image: image1, artist: "Gustave Caillebotte", title: "Paris Street; Rainy Day")
            rainyImages.append(rainy1)
        }

        if let image3 = UIImage(named: "rain3") {
            let rainy3 = WeatherImage(id: "rain3", image: image3, artist: "Utagawa Hiroshige", title: "Sudden Shower over Shin-Ōhashi Bridge and Atake")
            rainyImages.append(rainy3)
        }

        if let image4 = UIImage(named: "rain4") {
            let rainy4 = WeatherImage(id: "rain4", image: image4, artist: "Anton Mauve", title: "Changing Pasture")
            rainyImages.append(rainy4)
        }

        if let image6 = UIImage(named: "rain6") {
            let rainy6 = WeatherImage(id: "rain6", image: image6, artist: "Alexander H. Wyant", title: "Tennessee")
            rainyImages.append(rainy6)
        }
    }

    private func createWindyImages() {
        if let image1 = UIImage(named: "wind1") {
            let windy1 =  WeatherImage(id: "wind1", image: image1, artist: "Vinvent van Gogh", title: "Wheat Field Behind Saint-Paul")
            windyImages.append(windy1)
        }

        if let image2 = UIImage(named: "wind2") {
            let windy2 = WeatherImage(id: "wind2", image: image2, artist: "David Cox the Elder", title: "Shepherding the Flock, Windy Day")
            windyImages.append(windy2)
        }
    }

    private func createThunderstormImages() {
        if let image1 = UIImage(named: "tstorm1") {
            let storm1 =  WeatherImage(id: "tstorm1", image: image1, artist: "Albert Bierstadt", title: "A Storm in the Rocky Mountains, Mt. Rosalie")
            thunderstormImages.append(storm1)
        }

        if let image2 = UIImage(named: "tstorm2") {
            let storm2 = WeatherImage(id: "tstorm2", image: image2, artist: "Francisque Millet", title: "Mountain Landscape with Lightning")
            thunderstormImages.append(storm2)
        }
    }

    private func createTornadoImages() {
        if let image1 = UIImage(named: "tornado1") {
            let tornado1 = WeatherImage(id: "tornado1", image: image1, artist: "Julius Holm", title: "Tornado over St. Paul")
            tornadoImages.append(tornado1)
        }
    }

    private func createCloudyImages() {
        if let image1 = UIImage(named: "clouds1") {
            let cloudy1 =  WeatherImage(id: "clouds1", image: image1, artist: "Albert Bierstadt", title: "Wind River Country")
            cloudyImages.append(cloudy1)
        }

        if let image2 = UIImage(named: "clouds2") {
            let cloudy2 = WeatherImage(id: "clouds2", image: image2, artist: "John Constable", title: "Wivenhoe Park")
            cloudyImages.append(cloudy2)
        }

        if let image3 = UIImage(named: "clouds3") {
            let cloudy3 = WeatherImage(id: "clouds3", image: image3, artist: "Philips Koninck", title: "An Extensive Wooded Landscape")
            cloudyImages.append(cloudy3)
        }

        if let image4 = UIImage(named: "clouds4") {
            let cloudy4 = WeatherImage(id: "clouds4", image: image4, artist: "Aelbert Cuyp", title: "Young Herdsmen with Cows")
            cloudyImages.append(cloudy4)
        }
    }

    private func createOvercastImages() {
        if let image1 = UIImage(named: "gray1") {
            let gray1 =  WeatherImage(id: "gray1", image: image1, artist: "Jacob Isaacksz. van Ruisdael", title: "View of Naarden")
            overcastImages.append(gray1)
        }

        if let image2 = UIImage(named: "gray2") {
            let gray2 =  WeatherImage(id: "gray2", image: image2, artist: "El Greco", title: "View of Toledo")
            overcastImages.append(gray2)
        }
        
        if let image3 = UIImage(named: "gray3") {
            let gray3 =  WeatherImage(id: "gray3", image: image3, artist: "Albert Bierstadt", title: "Buffalo Trail: The Impending Storm")
            overcastImages.append(gray3)
        }
    }

    private func createFoggyImages() {
        if let image1 = UIImage(named: "fog1") {
            let foggy1 =  WeatherImage(id: "fog1", image: image1, artist: "Claude Monet", title: "The Houses of Parliament (Effect of Fog)")
            foggyImages.append(foggy1)
        }

        if let image2 = UIImage(named: "fog2") {
            let foggy2 =  WeatherImage(id: "fog2", image: image2, artist: "Alfred Sisley", title: "Fog, Voisins")
            foggyImages.append(foggy2)
        }
    }

    private func createSnowyImages() {
        if let image1 = UIImage(named: "snow1") {
            let snowy1 =  WeatherImage(id: "snow1", image: image1, artist: "Paul Gauguin", title: "Winter Landscape, Effect of Snow")
            snowyImages.append(snowy1)
        }

        if let image2 = UIImage(named: "snow2") {
            let snowy2 =  WeatherImage(id: "snow2", image: image2, artist: "Ando Hiroshige", title: "Evening Snow at Kanbara")
            snowyImages.append(snowy2)
        }
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
