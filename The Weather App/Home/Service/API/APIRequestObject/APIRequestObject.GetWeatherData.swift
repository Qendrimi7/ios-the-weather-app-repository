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
        var mode: String? = nil    /// - Response format. JSON format is used by default. To get data in XML format use mode=xml.
        var cnt: Int? = nil        /// - A number of timestamps, which will be returned in the API response.
        var units: String? = nil   /// - standard, metric, imperial
        var lang: String? = nil
    }
}

extension APIRequestObject.GetWeatherData: AlamofireParametersConvertible {}
