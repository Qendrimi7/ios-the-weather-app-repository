//
//  UIViewController.swift
//  The Weather App
//
//  Created by Qendrim Mjeku on 12.11.22.
//

import UIKit

extension UIViewController {
    
    func setupBackButton() {
        let customBackButton = UIBarButtonItem(
            title: " ",
            style: .plain,
            target: nil,
            action: nil
        )
        customBackButton.tintColor = .white
        navigationItem.backBarButtonItem = customBackButton
    }
    
    func showAlertWithMessage(
        title: String,
        message: String
    ) {
        let dialogMessage = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            
         })
        
        dialogMessage.addAction(ok)

        self.present(dialogMessage, animated: true, completion: nil)
    }
    
}
