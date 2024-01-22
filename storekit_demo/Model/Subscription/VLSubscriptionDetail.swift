//
//  VLSubscriptionDetail.swift
//  AppCMS
//
//  Created by Rajni Pathak on 16/06/23.
//  Copyright © 2022 Viewlift. All rights reserved.
//

import Foundation
//import VLAnalyticsLib

//struct VLSubscriptionDetail: Decodable {
//    private(set) var planId: String?
//    private(set) var subscriptionStatus: String?
//    private(set) var paymentHandler: String?
//    private(set) var platformName: String?
//    private(set) var nextPaymentDate: String?
//    private(set) var lastPaymentDate: String?
//    private(set) var planName: String?
//    private(set) var cardLastDigits: String?
//    private(set) var brandName: String?
//    
//	init() {
//		
//	}
//    init(with subscriptionInfo: [String: Any], and subscriptionPlanInfo:[String: Any]) {
//        if let id = subscriptionInfo["planId"] as? String {
//            self.planId = id
//        }
//        
//        if let subscriptionStatus = subscriptionInfo["subscriptionStatus"] as? String {
//            self.subscriptionStatus = subscriptionStatus
//            if (self.subscriptionStatus?.lowercased() == "completed".lowercased() || self.subscriptionStatus?.lowercased() == "DEFERRED_CANCELLATION".lowercased()) {//}&& paymentHandler != "TVE"{
//                Constants.shared.kSTANDARDUSERDEFAULTS.set(true, forKey: Constants.shared.kIsSubscribedKey)
//                Constants.shared.kSTANDARDUSERDEFAULTS.synchronize()
//            }
//            else {
//                if self.subscriptionStatus?.lowercased() == "cancelled" || self.subscriptionStatus?.lowercased() == "suspended" {
//                    Constants.shared.kSTANDARDUSERDEFAULTS.set(false, forKey: Constants.shared.kIsSubscribedKey)
//                    Constants.shared.kSTANDARDUSERDEFAULTS.synchronize()
//                }
//            }
//        }
//        
//        if let paymentHandler = subscriptionInfo["paymentHandler"] as? String {
//            self.paymentHandler = paymentHandler
//        }
//        
//        if let platformName = subscriptionInfo["platform"] as? String {
//            self.platformName = platformName
//        }
//        
//        if let brand = subscriptionInfo["brand"] as? String {
//            self.brandName = brand
//        }
//        
//        if let cardLastDigits = subscriptionInfo["last4"] as? String {
//            self.cardLastDigits = cardLastDigits
//        }
//        
//        if let nextPaymentDate = subscriptionInfo["subscriptionEndDate"] as? String {
//            self.nextPaymentDate = nextPaymentDate
//        }
//        
//        if let lastPaymentDate = subscriptionInfo["updateDate"] as? String {
//            self.lastPaymentDate = lastPaymentDate
//        }
//        
//        if let planName = subscriptionPlanInfo["name"] as? String {
//            self.planName = planName
//        }
//    }
//}
//
//struct VLBillingHistoryDetail: Decodable {
//    private(set) var purchaseDate: String?
//    private(set) var startDate: String?
//    private(set) var endDate: String?
//    
//    private(set) var totalAmount: String?
//    private(set) var planName: String?
//    private(set) var brandName: String?
//	private(set) var currencyCode: String?
//	private(set) var countryCode: String?
//    
//    init(with billingInfo: [String: Any]) {
//        
//        if let purchaseDate = billingInfo["completedAt"] as? String {
//            self.purchaseDate = purchaseDate
//        }
//        
//        if let subscriptionStartDate = billingInfo["subscriptionStartDate"] as? String {
//            self.startDate = subscriptionStartDate
//        }
//        
//        if let subscriptionEndDate = billingInfo["subscriptionEndDate"] as? String {
//            self.endDate = subscriptionEndDate
//        }
//        
//        if let brand = billingInfo["brand"] as? String {
//            self.brandName = brand
//        }
//
//		if let planName = billingInfo["planName"] as? String ?? billingInfo["identifier"] as? String {
//            self.planName = planName
//        }
//
//		if let currencyCode = billingInfo["currencyCode"] as? String {
//			self.currencyCode = currencyCode
//		}
//		
//		if let countryCode = billingInfo["countryCode"] as? String {
//			self.currencyCode = countryCode
//		}
//        
//        if let totalAmount = billingInfo["totalAmount"] as? NSNumber {
//            self.totalAmount = "\(totalAmount.floatValue)"
//        }
//    }
//}
