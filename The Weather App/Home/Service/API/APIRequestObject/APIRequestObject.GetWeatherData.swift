//
//  APIRequestObject.GetWeatherData.swift
//  The Weather App
//
//  Created by Qendrim Mjeku on 13.11.22.
//

import Foundation
import Alamofire

extension APIRequestObject {
    struct GetWeatherData: Codable {
        let lat: Double
        let lon: Double
        let appid: String
        var exclude: String? = nil /// - current, minutely, hourly, daily, alerts
        var units: String? = nil   /// - standard, metric, imperial
    }
}

extension APIRequestObject.GetWeatherData: AlamofireParametersConvertible {}
