//
//  VLPlanDetails.swift
//  AppCMS
//
//  Created by Faraz Habib on 22/12/22.
//  Copyright © 2022 Viewlift. All rights reserved.
//

import Foundation

public struct VLPlanDetails: Codable {
    
    public let isRentEnabled: Bool?
    public let recurringPaymentAmount: Double?
    public let visible: Bool?
    public let redirectUrl: String?
    public let displayStrikeThroughPrice: Bool?
    public let hidePlanPrice: Bool?
    public let scheduledFromDate: TimeInterval?
    public let description: String?
    public let numberOfAllowedDevices: Int?
    public let title: String?
    public let isPurchaseEnabled: Bool?
    public let numberOfAllowedStreams: Int?
    public let features: [VLPlanFeature]?
    public let isDefault: Bool?
    public let carrierBillingProviders: [String]?
    public let countryCode: String?
    public let allowedStreamCountries: [String]?
    public let recurringPaymentCurrencyCode: String?
    public let supportedDevices: [String]?
    public let tnCPoints: [String]?
    public let paypalId: String?
//    let featureDetails: [String]?
    public let scheduledToDate: TimeInterval?
    public let callToAction: String?
    public let strikeThroughPrice: Double?
    public let purchaseAmount: Double?
    public let rentAmount: Double?
    
}
