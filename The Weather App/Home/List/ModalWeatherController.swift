//
//  ModalWeatherController.swift
//  The Weather App
//
//  Created by Qendrim Mjeku on 13.11.22.
//

import UIKit

class ModalWeatherController:
    UIViewController,
    UIViewControllerTransitioningDelegate {
    
    private let model: APIResponseObject.WeatherDataResponse
    
    // MARK: - Lifecycle
    init(_ model: APIResponseObject.WeatherDataResponse) {
      self.model = model
      super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder _: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemCyan
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }
    
    func presentationController(
        forPresented presented: UIViewController,
        presenting: UIViewController?,
        source: UIViewController
    ) -> UIPresentationController? {
        
        let controller: UISheetPresentationController = .init(presentedViewController: presented, presenting: presenting)
        let modalViewDente: UISheetPresentationController.Detent = ._detent(withIdentifier: "ModalViewDente", constant: 300.0)
        
        controller.detents = [modalViewDente]
        controller.prefersGrabberVisible = true
        
        return controller
    }
}
