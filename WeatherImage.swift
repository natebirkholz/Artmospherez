//
//  WeatherImage.swift
//  Artmospherez
//
//  Created by Nathan Birkholz on 5/22/17.
//  Copyright © 2017 natebirkholz. All rights reserved.
//

import UIKit

class WeatherImage {
    var image : UIImage!
    var imageId : Int!
    var typeName : String
    var artist : String!
    var title : String!
    var description : String!

    init (typeName: String) {
        self.typeName = typeName
        let imageIdForWeatherImage = self.getRandomIdForTypeName(typeName)
        self.imageId = imageIdForWeatherImage
        self.image = self.getImageFromId(imageIdForWeatherImage)
        self.artist = self.getArtistNameFromId(imageIdForWeatherImage)
        self.title = self.getTitleNameFromId(imageIdForWeatherImage)
        self.description = self.getDescriptionStringFromId(imageIdForWeatherImage)
    }

    init (idForImage: Int, imageForWeather: UIImage, typeName: String, artistName: String, titleName: String, descriptionString: String) {
        self.imageId = idForImage
        self.image = imageForWeather
        self.typeName = typeName
        self.artist = artistName
        self.title = titleName
        self.description = descriptionString
    }

    func assembleThis() {
        let imageIdForWeatherImage = self.getRandomIdForTypeName(typeName)
        self.imageId = imageIdForWeatherImage
        self.image = self.getImageFromId(imageIdForWeatherImage)
        self.artist = self.getArtistNameFromId(imageIdForWeatherImage)
        self.title = self.getTitleNameFromId(imageIdForWeatherImage)
        self.description = self.getDescriptionStringFromId(imageIdForWeatherImage)
    }

    func getRandomIdForTypeName(_ typeName: String) -> Int {
        // add randomizer here

        return 1
    }

    func getImageFromId(_ idFor: Int) -> UIImage {
        // get proper image

        return UIImage(named: "sunsetX3.PNG")!
    }

    func getArtistNameFromId(_ idFor: Int) -> String {
        // get proper name

        return "Bobby Jimbo"
    }

    func getTitleNameFromId(_ idFor: Int) -> String {
        // get proper title
        
        return "so pretty"
    }
    
    func getDescriptionStringFromId(_ idFor: Int) -> String {
        // get proper description
        
        return "Lorem ipsum yadda yadda ya"
    }
}
