//
//  APIResponseObject.HomeContentResponse.swift
//  The Weather App
//
//  Created by Qendrim Mjeku on 13.11.22.
//

import Foundation

extension APIResponseObject {
    
    // MARK: - WeatherDataResponse
    struct WeatherDataResponse: Codable {
        let cod: String?
        let message, cnt: Int?
        let list: [List]?
        let city: City?
    }

    // MARK: - City
    struct City: Codable {
        let id: Int?
        let name: String?
        let coord: Coord?
        let country: String?
        let population, timezone, sunrise, sunset: Int?
    }

    // MARK: - Coord
    struct Coord: Codable {
        let lat, lon: Double?
    }

    // MARK: - List
    struct List: Codable, Equatable, Hashable {
        static func == (lhs: APIResponseObject.List, rhs: APIResponseObject.List) -> Bool {
            let lhsDate = Date(timeIntervalSince1970: lhs.dt)
            let rhsDate = Date(timeIntervalSince1970: rhs.dt)
            let sameDay = Calendar.current.isDate(lhsDate, equalTo: rhsDate, toGranularity: .day)
            return sameDay
        }
        
        let dt: TimeInterval
        let main: Main?
        let weather: [Weather]?
        let clouds: Clouds?
        let wind: Wind?
        let visibility: Int?
        let pop: Double?
        let rain: Rain?
        let sys: Sys?
        let dtTxt: String?

        enum CodingKeys: String, CodingKey {
            case dt, main, weather, clouds, wind, visibility, pop, rain, sys
            case dtTxt = "dt_txt"
        }
    }

    // MARK: - Clouds
    struct Clouds: Codable, Hashable {
        let all: Int?
    }

    // MARK: - Main
    struct Main: Codable, Hashable {
        let temp, feelsLike, tempMin, tempMax: Double?
        let pressure, seaLevel, grndLevel, humidity: Int?
        let tempKf: Double?

        enum CodingKeys: String, CodingKey {
            case temp
            case feelsLike = "feels_like"
            case tempMin = "temp_min"
            case tempMax = "temp_max"
            case pressure
            case seaLevel = "sea_level"
            case grndLevel = "grnd_level"
            case humidity
            case tempKf = "temp_kf"
        }
    }

    // MARK: - Rain
    struct Rain: Codable, Hashable {
        let the3H: Double?

        enum CodingKeys: String, CodingKey {
            case the3H = "3h"
        }
    }

    // MARK: - Sys
    struct Sys: Codable, Hashable {
        let pod: String?
    }

    // MARK: - Weather
    struct Weather: Codable, Hashable {
        let id: Int?
        let main, weatherDescription, icon: String?

        enum CodingKeys: String, CodingKey {
            case id, main
            case weatherDescription = "description"
            case icon
        }
    }

    // MARK: - Wind
    struct Wind: Codable, Hashable {
        let speed: Double?
        let deg: Int?
        let gust: Double?
    }
    
}
