//
//  AppCoordinator.swift
//  The Weather App
//
//  Created by Qendrim Mjeku on 12.11.22.
//

import UIKit

class AppCoordinator {
    
    /**
    Returns the default singleton instance.
    */
    static let shared = AppCoordinator()
    
    private var window: UIWindow?

    func setupAppNavigation(window: UIWindow? = UIApplication.shared.windows.first { $0.isKeyWindow }) {
        self.window = window
        setUpNavigation()
    }
    
    func setUpNavigation() {
        presentSplashAnimationController()
    }
    
    func presentSplashAnimationController() {
        let splashAnimationController: SplashAnimationController = SplashAnimationController()
        let navigationController = UINavigationController(rootViewController: splashAnimationController)
        window?.rootViewController = splashAnimationController
        window?.makeKeyAndVisible()
    }
    
    func presentHome() {
        
    }
}
