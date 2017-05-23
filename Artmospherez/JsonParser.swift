//
//  JsonParser.swift
//  Artmospherez
//
//  Created by Nathan Birkholz on 5/22/17.
//  Copyright © 2017 natebirkholz. All rights reserved.
//

import Foundation

enum ParseError: Error {
    case unableToParse
}

class JsonParser {

    /// Parses JSON into an array of Forecast objects from the API JSON response
    ///
    /// - Parameter rawJSONData: the raw JSON data as Data
    /// - Returns: returns an array of Forecast obects
    /// - Throws: Throws a ParseError upon failure to parse
    func parseJSONIntoForecasts(_ rawJSONData: Data) throws -> [Forecast] {
        do {
            if let dictionaryFromJSON = try JSONSerialization.jsonObject(with: rawJSONData, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any] {
                var arrayOfForecasts = [Forecast]()

                if let arrayFromJSON = dictionaryFromJSON["list"] as? [Any] {
                    for JSONDictionary in arrayFromJSON {
                        // long `let` block, if first two succeed this should all succeed
                        if let forecastDictionary = JSONDictionary as? [String: Any],
                            let weatherArray = forecastDictionary["weather"] as? [Any],
                            let weatherDictionary = weatherArray.first as? [String: Any],
                            let tempDictionary = forecastDictionary["temp"] as? [String: Any],
                            let forecastDateCode = forecastDictionary["dt"] as? Double,
                            let forecastIDCode = weatherDictionary["id"] as? Int,
                            let forecastHumidity = forecastDictionary["humidity"] as? Int,
                            let forecastMax = tempDictionary["max"] as? Int,
                            let forecastMin = tempDictionary["min"] as? Int {
                            let forecastType = parseWeatherTypeIntoForecastType(forecastIDCode)
                            let day = parseDateCodeIntoDay(forecastDateCode)
                            let newForecast = Forecast(dayValue: day, weatherID: Weather(weatherKind: .sunny), humidityValue: forecastHumidity, maxTempValue: forecastMax, minTempValue: forecastMin)
                            arrayOfForecasts.append(newForecast)
                        } else {
                            throw ParseError.unableToParse
                        }
                    }

                    return arrayOfForecasts

                } else {
                    throw ParseError.unableToParse
                }
            } else {
                throw ParseError.unableToParse
            }
        } catch {
            throw ParseError.unableToParse
        }
    }

    func parseJSONIntoCurrentWeather(_ rawJSONData: Data) throws -> [Forecast] {
        do {
            if let dictionaryFromJSON = try JSONSerialization.jsonObject(with: rawJSONData, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any] {
                var arrayOfForecasts = [Forecast]()

                if let arrayFromJSON = dictionaryFromJSON["list"] as? [Any] {
                    for JSONDictionary in arrayFromJSON {
                        // long `let` block, if first two succeed this should all succeed
                        if let forecastDictionary = JSONDictionary as? [String: Any],
                            let weatherArray = forecastDictionary["weather"] as? [Any],
                            let weatherDictionary = weatherArray.first as? [String: Any],
                            let tempDictionary = forecastDictionary["temp"] as? [String: Any],
                            let forecastDateCode = forecastDictionary["dt"] as? Double,
                            let forecastIDCode = weatherDictionary["id"] as? Int,
                            let forecastHumidity = forecastDictionary["humidity"] as? Int,
                            let forecastMax = tempDictionary["max"] as? Int,
                            let forecastMin = tempDictionary["min"] as? Int {
                            let forecastType = parseWeatherTypeIntoForecastType(forecastIDCode)
                            let day = parseDateCodeIntoDay(forecastDateCode)
                            let newForecast = Forecast(dayValue: day, weatherID: Weather(weatherKind: .sunny), humidityValue: forecastHumidity, maxTempValue: forecastMax, minTempValue: forecastMin)
                            arrayOfForecasts.append(newForecast)
                        } else {
                            throw ParseError.unableToParse
                        }
                    }

                    return arrayOfForecasts

                } else {
                    throw ParseError.unableToParse
                }
            } else {
                throw ParseError.unableToParse
            }
        } catch {
            throw ParseError.unableToParse
        }
    }

    /// Takes a date code from the API JSON and converts it to a day of the week
    ///
    /// - Parameter dateCode: the date code from the api
    /// - Returns: The day of the week as a string
    func parseDateCodeIntoDay(_ dateCode: Double) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        let aDate = Date(timeIntervalSince1970: TimeInterval(dateCode))
        let dateForForecast = formatter.string(from: aDate)
        return dateForForecast
    }

    /// Determines the forecast from a weather code from the API JSON
    ///
    /// - Parameter forecastIDCode: 3 digit code from API denoting forecast
    /// - Returns: ForecastType associated wth the forecast
    func parseWeatherTypeIntoForecastType(_ forecastIDCode: Int) -> WeatherKind {
        switch forecastIDCode {
        case 200...299, 960, 961:
            return .thunderstorm
        case 300...599:
            return .rainy
        case 602, 622:
            return .blizzard
        case 600, 601, 603...621:
            return .snowy
        case 701, 741:
            return.foggy
        case 711, 762:
            return .apocalyptic
        case 781, 900:
            return .tornado
        case 800...801:
            return .sunny
        case 802...803:
            return .cloudy
        case 804:
            return .gray
        case 901, 902, 962:
            return .hurricane
        case 905, 956...959:
            return .windy
        default:
            return .sunny
        }
    }
    
}
