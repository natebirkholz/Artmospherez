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
    var image: UIImage? {
        return UIImage(named: id)
    }
    var artist: String
    var title: String
    var detail: String?

    init(id: String, artist: String, title: String) {
        self.id = id
        self.artist = artist
        self.title = title
        self.detail = getDescriptionStringFromId(id)
    }


    /// Loads the long descriptions from the file system
    ///
    /// - Parameter id: the filename for the text file associated with the artwork
    /// - Returns: The string describing the artwork
    func getDescriptionStringFromId(_ id: String) -> String {
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
        return detail ?? "(No Description)"
    }
}
