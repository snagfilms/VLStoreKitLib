//
//  SubscriptionEnum.swift
//  storekit_demo
//
//  Created by NexG on 21/01/24.
//

import Foundation

public enum AuthProvider {
    case AdobePass
    case Verimatrix
}

public enum ServiceType: Equatable {
    case SVOD
    case AVOD
    case TVOD
    case TVE(provider: AuthProvider?)
    

    /// Defining case sensitive equality operator.
    ///
    /// - Parameters:
    ///   - lhs: lhs value
    ///   - rhs: rhs value
    /// - Returns: bool suggesting the equality.
    public static func == (lhs: ServiceType, rhs: ServiceType) -> Bool {
        switch (lhs,rhs) {
        case (.SVOD, .SVOD):
            return true
        case (.AVOD, .AVOD):
            return true
        case (.TVOD, .TVOD):
            return true
        case (.TVE(let a), .TVE(let b)):
            if b == nil {
                return true
            }
            return a == b
        default:
            return false
        }
    }
    
    /// Defining the case insensitive equality operator.
    ///
    /// - Parameters:
    ///   - lhs: lhs value
    ///   - rhs: rhs value
    /// - Returns: bool suggesting the equality.
    public static func === (lhs: ServiceType, rhs: ServiceType) -> Bool {
        switch (lhs,rhs) {
        case (.TVE, .TVE):
            return true
        default:
            if lhs == rhs {
                return true
            }
            return false
        }
    }
    
    public var value: String {
        get {
            switch self {
            case .AVOD:
                return "AVOD"
            case .SVOD:
                return "SVOD"
            case .TVE:
                return "TVE"
            case .TVOD:
                return "TVOD"
            }
        }
    }
}
