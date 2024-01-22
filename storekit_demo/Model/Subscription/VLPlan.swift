//
//  VLPlan.swift
//  AppCMS
//
//  Created by Faraz Habib on 22/12/22.
//  Copyright © 2022 Viewlift. All rights reserved.
//

import Foundation
import UIKit
import VLStoreKit

public struct VLPlanMetadata: Codable {
    
    public let name: String?
    public let value: String?
    
}

public struct VLPlan: Codable {
    public let id: String
    public let metadata: [VLPlanMetadata]?
    public let identifier: String
    public let updateDate: String?
    public let addedDate: String?
    public let featureSetting: VLPlanFeatureSetting?
    public let scheduledFromDate: String?
    public let site: String?
    public let details: [VLPlanDetails]?
    public let objectKey: String?
    public let renewable: Bool?
    public let name: String?
    public let renewalCyclePeriodMultiplier: Int?
    public let siteOwner: String?
    public let offers: [VLPlanOffer]?
    public let displayOrder: Int?
    public let monetizationModel: String?
    public let renewalCycleType: String?
    public let purchaseIdentifier: String?
    public let description: String?
    
    enum CodingKeys: String, CodingKey {
        case id, identifier, updateDate, addedDate,
             featureSetting, scheduledFromDate, site, objectKey,
             renewable, name, renewalCyclePeriodMultiplier, siteOwner,
             monetizationModel, renewalCycleType, purchaseIdentifier, description, metadata
        case details = "planDetails"
        case offers = "planOffers"
        case displayOrder = "planDisplayOrder"
    }
    
    public var planDetails: VLPlanDetails? {
        get {
            guard let details = details, !details.isEmpty else {
                return nil
            }
            
            return details[0]
        }
    }
    
	private func getSymbolForCurrencyCode(countryCode: String) -> String? {
		let locale = NSLocale(localeIdentifier: countryCode)
		return locale.displayName(forKey: NSLocale.Key.currencySymbol, value: countryCode)
	}
	
    func getFreeTrialText() -> String {
        guard let details = details, !details.isEmpty else {
            return ""
        }
        
        guard let features = details[0].features, !features.isEmpty else {
            return ""
        }
        
        return features[0].textToDisplay ?? ""
    }
    
    func getFeatures() -> [VLPlanFeature]? {
        guard let details = details, !details.isEmpty else {
            return nil
        }
        
        guard let features = details[0].features else {
            return nil
        }
        
        return features
    }
    
    func getButtonText() -> String {
        guard let details = details, !details.isEmpty else {
            return "Continue"
        }
        
        guard let callToAction = details[0].callToAction, !callToAction.isEmpty else {
            return "Continue"
        }
        
        return callToAction
    }
    
    func getDiscountText() -> String {
        guard let metadata, !metadata.isEmpty else {
            return ""
        }
        
        guard let discountInfo = metadata.first(where: { $0.name == "planBoxOffer" }) else {
            return ""
        }
        
        return discountInfo.value ?? ""
    }
    
    func getDiscountInfoText() -> String {
        guard let metadata, !metadata.isEmpty else {
            return "Save 20%"
        }
        
        guard let discountInfo = metadata.first(where: { $0.name == "planInfoOffer" }) else {
            return "Save 20%"
        }
        
        return discountInfo.value ?? ""
    }
    
    func getDisclaimerText() -> String {
        guard let details = details, !details.isEmpty else {
            return ""
        }
        
        guard let features = details[0].features, features.count > 2 else {
            return ""
        }
        
        return features[2].textToDisplay ?? ""
    }
    
    func getDetailsRight1() -> (String, Bool) {
        guard let details = details, !details.isEmpty else {
            return ("",false)
        }
        
        guard let features = details[0].features, features.count > 3 else {
            return ("",false)
        }
        
        if ((features[3].textToDisplay?.hasPrefix("{DisplayRight}")) != nil)
        {
            let planDetail: String = (features[3].textToDisplay?.replacingOccurrences(of: "{DisplayRight}", with: ""))!
            if features[3].value == "Y" {
                return (planDetail, true)
            }
            else {
                return (planDetail, false)
            }
        }
        else
        {
            return ("", false)
        }
    }
    
    func getDetailsRight2() -> (String, Bool) {
        guard let details = details, !details.isEmpty else {
            return ("",false)
        }
        guard let features = details[0].features, features.count > 4 else {
            return ("",false)
        }
        
        if ((features[4].textToDisplay?.hasPrefix("{DisplayRight}")) != nil)
        {
            let planDetail: String = (features[4].textToDisplay?.replacingOccurrences(of: "{DisplayRight}", with: ""))!
            if features[4].value == "Y" {
                return (planDetail, true)
            }
            else {
                return (planDetail, false)
            }
        }
        else
        {
            return ("", false)
        }
        
    }
    
    func getDetailsRight3() -> (String, Bool) {
        guard let details = details, !details.isEmpty else {
            return ("",false)
        }
        guard let features = details[0].features, features.count > 5 else {
            return ("",false)
        }
        
        if ((features[5].textToDisplay?.hasPrefix("{DisplayRight}")) != nil)
        {
            let planDetail: String = (features[5].textToDisplay?.replacingOccurrences(of: "{DisplayRight}", with: ""))!
            if features[5].value == "Y" {
                return (planDetail, true)
            }
            else {
                return (planDetail, false)
            }
        }
        else
        {
            return ("", false)
        }
    }
    
    func getDetailsRight4() -> (String, Bool) {
        guard let details = details, !details.isEmpty else {
            return ("",false)
        }
        guard let features = details[0].features, features.count > 6 else {
            return ("",false)
        }
        
        if ((features[6].textToDisplay?.hasPrefix("{DisplayRight}")) != nil)
        {
            let planDetail: String = (features[6].textToDisplay?.replacingOccurrences(of: "{DisplayRight}", with: ""))!
            if features[6].value == "Y" {
                return (planDetail, true)
            }
            else {
                return (planDetail, false)
            }
        }
        else
        {
            return ("", false)
        }
        
    }
    
}

extension VLPlan {
    
    private func getSource() -> String {
        let device = UIDevice.current.userInterfaceIdiom
        switch(device) {
        case .pad:
            return "iPad"
        case .phone:
            return "iPhone"
        case .tv:
            return "Apple TV"
        default:
            return "Unspecified"
        }
    }
    
}
