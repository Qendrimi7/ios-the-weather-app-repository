//
//  Array.swift
//  The Weather App
//
//  Created by Qendrim Mjeku on 14.11.22.
//

import Foundation

extension Array where Element: Equatable {
  func uniqueElements() -> [Element] {
    var out = [Element]()

    for element in self {
      if !out.contains(element) {
        out.append(element)
      }
    }

    return out
  }
}
