//
//  Environment.swift
//  The Weather App
//
//  Created by Qendrim Mjeku on 12.11.22.
//

import Foundation

enum Environment {
    case debug
    case release
    
    static let dictionary: [Environment : [EnvironmentURLKey : URL]] = [
        Environment.debug: [
            EnvironmentURLKey.API_BASE_URL:            URL(string: "https://openweathermap.org/api")!,
        ],
        Environment.release: [
            EnvironmentURLKey.API_BASE_URL:            URL(string: "https://openweathermap.org/api")!,
        ]
    ]
}

extension Environment {
    #if DEBUG
    static let current: Environment = .debug
    #elseif RELEASE
    static let current: Environment = .release
    #endif
    
    static subscript(_ key: EnvironmentURLKey) -> URL {
        return dictionary[Environment.current]![key]!
    }
}

