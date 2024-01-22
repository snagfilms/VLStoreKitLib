//
//  VLPaymentDetails.swift
//  AppCMS
//
//  Created by Rajni Pathak on 17/04/23.
//  Copyright © 2023 Viewlift. All rights reserved.
//

import Foundation

struct VLContentPlanDetails: Codable {
    let id: String
    let identifier: String
    let updateDate: String?
    let addedDate: String?
    var featureSetting: VLPlanFeatureSetting?
    let scheduledFromDate: String?
    let site: String?
    let details: [VLPlanDetails]?
    let objectKey: String?
    let renewable: Bool?
    let name: String?
    let renewalCyclePeriodMultiplier: Int?
    let siteOwner: String?
    let offers: [VLPlanOffer]?
    let displayOrder: Int?
    let monetizationModel: String?
    let renewalCycleType: String?
    let purchaseIdentifier: String?
    let description: String?
    
}
