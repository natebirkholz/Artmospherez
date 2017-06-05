//
//  DateController.swift
//  Artmospherez
//
//  Created by Nathan Birkholz on 5/31/17.
//  Copyright © 2017 natebirkholz. All rights reserved.
//

import Foundation

enum TimeOfDay {
    case day
    case night
}

class DateController {
    let dayFormatter: DateFormatter
    let hourFormatter: DateFormatter

    static let shared = DateController()

    init() {
        let day = DateFormatter()
        day.dateFormat = "D"

        let hour = DateFormatter()
        hour.dateFormat = "HH"

        dayFormatter = day
        hourFormatter = hour
    }


    /// Get the day of the year (day n of 365/366).
    ///
    /// - Returns: Int value of the day of the year
    func getDay() -> Int {
        let date = Date()
        let string = dayFormatter.string(from: date)
        let intFor = Int(string) ?? 1

        return intFor
    }

    func getTimeOfDay() -> TimeOfDay {
        let date = Date()
        let hourString = hourFormatter.string(from: date)
        let maybeHour = Int(hourString)

        if let hour = maybeHour {
            if hour >= 7 && hour < 18 {
                return .day
            } else {
                return .night
            }
        } else {
            return .day
        }
    }
}
