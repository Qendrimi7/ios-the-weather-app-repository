//
//  HomeCoordinator.swift
//  The Weather App
//
//  Created by Qendrim Mjeku on 12.11.22.
//

import UIKit

class HomeCoordinator: HomeCoordinatorProtocol {
    
    // MARK: - Data
    private let presenter: UINavigationController
    
    // MARK: - Lifecycle
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    // MARK: - Helpers
    func goToWeatherDetailsController() {
       
    }
}
