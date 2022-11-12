//
//  UITableView.swift
//  The Weather App
//
//  Created by Qendrim Mjeku on 12.11.22.
//

import UIKit

extension UITableView {
    
    func setEmptyView(_ emptyView: UIView?) {
        emptyView?.frame = safeAreaLayoutGuide.layoutFrame
        backgroundView = emptyView
    }
    
}
