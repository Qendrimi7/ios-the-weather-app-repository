//
//  SplashAnimationCoordinator.swift
//  The Weather App
//
//  Created by Qëndrim Mjeku on 12.11.22.
//

import UIKit

class SplashAnimationCoordinator: SplashAnimationCoordinatorProtocol {
   
    // MARK: - Data
    private let presenter: UINavigationController
    
    // MARK: - Lifecycle
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    // MARK: - Helpers
    func goToHomeController() {
        AppCoordinator.shared.presentHome()
    }
    
}
