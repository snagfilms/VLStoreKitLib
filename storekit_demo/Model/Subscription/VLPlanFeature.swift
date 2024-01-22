//
//  VLPlanDetailsFeature.swift
//  AppCMS
//
//  Created by Faraz Habib on 23/12/22.
//  Copyright © 2022 Viewlift. All rights reserved.
//

import Foundation

public struct VLPlanFeature: Codable {
    
    public let valueType: String?
    public let value: String?
    public let textToDisplay: String?
    
    var imageName: String? {
        get {
            guard let value else {
                return nil
            }
            
            switch value.lowercased() {
            case "y":
                return "vl_tick"
            case "n":
                return "crossIcon"
            case "x":
                return "crossIcon"
            default:
                return nil
            }
        }
    }
    
}
