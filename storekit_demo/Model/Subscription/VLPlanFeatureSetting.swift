//
//  VLPlanFeatureSetting.swift
//  AppCMS
//
//  Created by Faraz Habib on 22/12/22.
//  Copyright © 2022 Viewlift. All rights reserved.
//

import Foundation

public struct VLPlanFeatureSetting: Codable {
    public let numberOfAllowedStreams: Int?
    public let contentConsumption: [String]?
    public let includingAds: Bool?
    public let isHdStreaming: Bool?
    public let isBeamingAllowed: Bool?
    public var isLoginRequired: Bool?
    public let isEmailRequired: Bool?
    public let isDownloadAllowed: Bool?
    public let numberOfAllowedDevices: Int?
}
