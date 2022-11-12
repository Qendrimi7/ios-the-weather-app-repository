//
//  AppCoordinator.swift
//  The Weather App
//
//  Created by Qendrim Mjeku on 12.11.22.
//

import UIKit

class AppCoordinator {
    
    private var window: UIWindow?

    func setupAppNavigation(window: UIWindow? = UIApplication.shared.windows.first { $0.isKeyWindow }) {
        self.window = window
        setUpNavigation()
    }
    
    func setUpNavigation() {
        presentAnimation()
    }
    
    func presentAnimation() {
        
    }
    
    func presentHome() {
        
    }
}
