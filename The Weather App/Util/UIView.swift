//
//  UIView.swift
//  The Weather App
//
//  Created by Qendrim Mjeku on 12.11.22.
//

import UIKit

extension UIView {
    func addOverlayView(
        color: UIColor = .black,
        alpha : CGFloat = 0.6
    ) {
        let overlayView = UIView()
        overlayView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        overlayView.frame = bounds
        overlayView.backgroundColor = color
        overlayView.alpha = alpha
        addSubview(overlayView)
    }
}
