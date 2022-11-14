//
//  HomeCoordinatorProtocol.swift
//  The Weather App
//
//  Created by Qendrim Mjeku on 12.11.22.
//

import UIKit

protocol HomeCoordinatorProtocol {
    func presentModalController(model: APIResponseObject.WeatherDataResponse)
}
