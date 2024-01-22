//
//  double+conversionToInt.swift
//  storekit_demo
//
//  Created by NexG on 19/01/24.
//

import Foundation

extension Double {
    
    func toInt() -> Int? {
        if self > Double(Int.min) && self < Double(Int.max) {
            return Int(self)
        } else {
            return nil
        }
    }
}
