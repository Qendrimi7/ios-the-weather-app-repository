//
//  UIView+Constraint.swift
//  The Weather App
//
//  Created by Qendrim Mjeku on 12.11.22.
//

import UIKit.UIView

extension UIView {
    @discardableResult
    func heightAnchor(constant: CGFloat) -> Self {
        heightAnchor.constraint(equalToConstant: constant).isActive = true
        return self
    }
    
    @discardableResult
    func widthAnchor(constant: CGFloat) -> Self {
        widthAnchor.constraint(equalToConstant: constant).isActive = true
        return self
    }
    
    @discardableResult
    func topAnchor(equalTo anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = .zero) -> Self {
        topAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }
    
    @discardableResult
    func bottomAnchor(equalTo anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = .zero) -> Self {
        bottomAnchor.constraint(equalTo: anchor, constant: -constant).isActive = true
        return self
    }
    
    @discardableResult
    func leadingAnchor(equalTo anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = .zero) -> Self {
        leadingAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }
    
    @discardableResult
    func trailingAnchor(equalTo anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = .zero) -> Self {
        trailingAnchor.constraint(equalTo: anchor, constant: -constant).isActive = true
        return self
    }
    
    @discardableResult
    func centerHorizontal(equalTo anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = .zero) -> Self {
        centerXAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }
    
    @discardableResult
    func centerVertical(equalTo anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = .zero) -> Self {
        centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }
}
