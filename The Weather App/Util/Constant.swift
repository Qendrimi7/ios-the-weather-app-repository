//
//  Constant.swift
//  The Weather App
//
//  Created by Qendrim Mjeku on 14.11.22.
//

import Foundation

import Foundation

enum Constant {
    private static let bundleDictionary = Bundle.main.infoDictionary
    
    static let apiKeyForOpenWeatherMap: String? = bundleDictionary?["API_KEY_FOR_OPENWEATHERMAP"] as? String
}
