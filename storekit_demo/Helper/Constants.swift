//
//  constants.swift
//  storekit_demo
//
//  Created by NexG on 21/01/24.
//

import Foundation
class Constants: NSObject
{
    static let shared:Constants = Constants.init()
    
    private override init() {
        super.init()
    }
    
    
    let noProductAvailableOnItunes: String = "There are no products available for subscription on iTunes."
    
    let noProductAvailable: String = "No Products Available!"
    let purchaseAreDisabled: String = "Purchases are disabled in your device"
    
    let noProductsForRentItunes: String = "This products is not available for rent on iTunes."
    
    let noProductsForPurchaseItunes: String = "This products is not available for purchase on iTunes."
    
    let kStrOk: String = "Ok"
    let kError: String = "Error"
    let kTransactionFailedCancelled: String = "Transaction Failed or Cancelled"
    
    let kiTunesConnectErrorMessage: String = "Unable to connect to iTunes Store"
}
