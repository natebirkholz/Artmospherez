//
//  WeatherImage.swift
//  Artmospherez
//
//  Created by Nathan Birkholz on 5/22/17.
//  Copyright © 2017 natebirkholz. All rights reserved.
//

import UIKit

class WeatherImage {
    let id: String
    var image: UIImage
    var artist: String
    var title: String
    var detail: String!

    init(id: String, image: UIImage, artist: String, title: String) {
        self.id = id
        self.image = image
        self.artist = artist
        self.title = title
        self.detail = getDescriptionStringFromId(id)
    }


    func getDescriptionStringFromId(_ id: String) -> String {
        // get proper description
        do {
            let file = Bundle.main.url(forResource: id, withExtension: "txt")
            guard let fileURL = file else { return "(No Description)" }
            let textFromFile = try String(contentsOf: fileURL)
            return textFromFile
        } catch let error {
            print(error.localizedDescription)
            return "(No Description)"
        }
    }
}

extension WeatherImage: CustomStringConvertible {
    var description: String {
        return detail
    }
}
