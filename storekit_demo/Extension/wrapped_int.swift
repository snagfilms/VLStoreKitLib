//
//  wrapped_int.swift
//  storekit_demo
//
//  Created by NexG on 19/01/24.
//

import Foundation

public struct WrappedInt: Codable {
    
    public var value: Int?
    
    public static func getWrappedValue(intValue: Int?) -> WrappedInt? {
        guard let intValue = intValue else {
            return nil
        }
        
        var wrapped = WrappedInt()
        wrapped.value = intValue
        
        return wrapped
    }
    
}
