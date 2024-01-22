//
//  SubscriptionHandler.swift
//  storekit_demo
//
//  Created by NexG on 19/01/24.
//

import Foundation
import VLStoreKit
import UIKit
import SVProgressHUD

// MARK: - SubscriptionHandlerDelegate

// Protocol for handling subscription-related processes
protocol SubscriptionHandlerDelegate: NSObject {
    func processPlans(vlPlan: [VLPlan], isSuccess: Bool)
}

// MARK: - SubscriptionHandler

// Handles subscription-related operations
final class SubscriptionHandler: NSObject {
    
    // MARK: - Properties

    static let shared = SubscriptionHandler()
    weak var delegate: SubscriptionHandlerDelegate?
    
    // MARK: - Initializer
    private override init() {
        super.init()
        self.storeKit.setAPIVersion = isStoreKitV2API ? VLStoreKit.APIVersion.V2 : VLStoreKit.APIVersion.V1
        self.storeKit.enableDebugLogs = true
        
        
        // Initialization logic for VLStoreKit
        self.configureVLStoreKitFramework()
    }
    

    let userId = "347ef245-50aa-4b55-9b3e-19d1689a9d9f"
    let lat = 19.0176147
    let long = 72.8561644
    var store_countryCode = "default"
    
    // StoreKit instance
    var storeKit: VLStoreKit {
           return VLStoreKit.sharedStoreKitManager
    }
    
    private let isStoreKitV2API:Bool = false
    private let apiSecretKey = "BkSBbok02k6RYUlCLRzI23wac0euoSfC3FP7uW2S"
    let deviceId = UUID().uuidString
    let site = "liv-golf"
    let deviceType = "ios_phone"
    
    
    private let authorizationToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzaXRlIjoibGl2LWdvbGYiLCJzaXRlSWQiOiI5ZWQ3ZGVlMC1jNzE5LTExZWMtYmMyNS1hMTk1YzJhMzQzNTciLCJpZCI6IjM0N2VmMjQ1LTUwYWEtNGI1NS05YjNlLTE5ZDE2ODlhOWQ5ZiIsInVzZXJJZCI6IjM0N2VmMjQ1LTUwYWEtNGI1NS05YjNlLTE5ZDE2ODlhOWQ5ZiIsImlwYWRkcmVzc2VzIjoiMTM4LjE5OS4zNS40NSwyMC4wLjEuMTAwIiwiY291bnRyeUNvZGUiOiJVUyIsInBvc3RhbGNvZGUiOiI5MDA2MCIsInByb3ZpZGVyIjoidmlld2xpZnQiLCJkZXZpY2VJZCI6ImJyb3dzZXItMGIyMjU1NjEtYWEyNy00YTQyLTYwZWMtNWY5NDEyZDc2NWNhIiwiZW1haWwiOiJyYWtlc2hpb3M3ODZAZ21haWwuY29tIiwiaWF0IjoxNzA1OTE0NTAzLCJleHAiOjE3MDU5MTU0MDN9.9xbSF6H48o064Sksvwwk6IBZ7JYtRAxEp5evE2_o5TE"
    
    // Initiates the payment process for the selected subscription plan
    func processPayment(selectedPlan: VLPlan) {
        
        storeKit.storeKitSubscriptionSyncDelegate = self
        
        self.deregisterStoreKitCallbacks()
        
        var planPrice: Int? = selectedPlan.planDetails?.recurringPaymentAmount?.toInt()
        var planDiscount: Int? = 0
        
        if let planDiscountedPrice = selectedPlan.planDetails?.strikeThroughPrice,
           let recurringPaymentTotal = selectedPlan.planDetails?.recurringPaymentAmount {
            planDiscount = WrappedInt.getWrappedValue(intValue: Int(planDiscountedPrice - recurringPaymentTotal))?.value
            planPrice = WrappedInt.getWrappedValue(intValue: Int(recurringPaymentTotal))?.value
        }
        
        let productExtraDetails = [
            "numberOfAllowedDevices" : String(selectedPlan.planDetails?.numberOfAllowedDevices ?? 0),
            "numberOfAllowedStreams" : String(selectedPlan.planDetails?.numberOfAllowedStreams ?? 0),
        ]
        
        let productDetails = VLProductDetails(productId: selectedPlan.identifier, productName: selectedPlan.name ?? "", productDesc: selectedPlan.description ?? "", planType: selectedPlan.renewalCycleType ?? "", promotionCode: selectedPlan.offers?.first?.offerId, purchaseType: "In App Purchase", discountAmount: planDiscount, userUniqueIdentifier: userId, currencyCode: selectedPlan.planDetails?.countryCode, orderTotalAmount: planPrice, orderSubTotalAmount: planPrice, orderValue: planPrice, additionalData: productExtraDetails)
        
        
        storeKit.initateTransaction(productDetails: productDetails,
                                    transactionType: .purchase,
                                    deviceId: SubscriptionHandler.shared.deviceId,
                                    makeInternalSubscriptionCall: true,
                                    planId: selectedPlan.id)
    }

    
    //Fetch VL Plans.
    func fetchPlans(){
        // Fetching VL plans from the backend using VLStoreKit
        storeKit.fetchPlans(serviceType: ServiceType.SVOD.value, storeCountryCode: store_countryCode, device: deviceType, location: nil)
        
    }
}

// MARK: - VLStoreKitAppStoreSubscriptionDelegate

// Methods for handling App Store subscription-related events
extension SubscriptionHandler: VLStoreKitAppStoreSubscriptionDelegate {
    func transactionFromAppStoreFound(showOverlay: Bool) {
        
    }
    
    func transactionDoneFromAppStoreCompleted(storeKitModel: VLStoreKitModel) {
        
    }
    
    private func configureVLStoreKitFramework() {
        VLStoreKit.setupConfig(apiKey: apiSecretKey, authorizationToken: authorizationToken)
        
        self.registerStoreKitCallbacks()
        
        self.storeKit.storeKitDelegate = self
        self.storeKit.storeKitAppStoreSubscriptionDelegate = self
    }
    
    func registerStoreKitCallbacks() {
        self.storeKit.listenForStoreKitCallbacks()
    }
    
    func deregisterStoreKitCallbacks(shouldDeRegisterCallback:Bool = false) {
        if (shouldDeRegisterCallback || isStoreKitV2API)  {
            self.storeKit.deRegisterStoreKitCallbacks()
        }
    }
}

// MARK: - VLStoreKitDelegate

// Methods for handling VLStoreKit events
extension SubscriptionHandler: VLStoreKitDelegate {
    func processFetchedPlans(planData: Data?, isSuccess: Bool) {
        guard let responseData = planData else {
            self.delegate?.processPlans(vlPlan: [], isSuccess: isSuccess)
            return
        }
        
        if let decodablePlanList = try? JSONDecoder().decode([VLPlan].self, from: responseData) {
            self.delegate?.processPlans(vlPlan: decodablePlanList, isSuccess: isSuccess)
        } else {
            self.delegate?.processPlans(vlPlan: [], isSuccess: isSuccess)
        }
        
    }
    
    func transactionFinished(storeKitModel: VLStoreKitModel, isSubscriptionSyncInProcess: Bool) {
        guard let transactionReceipt = storeKitModel.transactionReceipt else {
            CommonMethods.shared.hideActivityIndicator()
            return
        }
        
        let data = Data(referencing: transactionReceipt)
        self.storeKit.storeKitSubscriptionSyncDelegate = self
        print("TRANSACTION PURCHASED transactionFinished 2")
        self.storeKit.syncSubscriptionStatusToVLSystem(planId: storeKitModel.productId,
                                                       transactionId: storeKitModel.transactionId,
                                                       originalTransactionId: storeKitModel.originalTransactionId,
                                                       productId: storeKitModel.productId,
                                                       transactionReceipt: data,
                                                       transactionType: .purchase)
    }
    
    func transactionFailed(error: TransactionError) {
        DispatchQueue.main.async {
            if error == .deviceNotSupported {
                self.displayErrorAlert(errorMessage: Constants.shared.purchaseAreDisabled)
            }
            else {
                switch error {
                case .productNotAvailable, .productIdNotFound:
                    self.displayErrorAlert(errorMessage: Constants.shared.noProductAvailableOnItunes, alertTitle: Constants.shared.noProductAvailable)
                case .noProductAvailableForRent:
                    self.displayErrorAlert(errorMessage: Constants.shared.noProductsForRentItunes, alertTitle: Constants.shared.noProductAvailable)
                case .noProductAvailableForPurchase:
                    self.displayErrorAlert(errorMessage: Constants.shared.noProductsForPurchaseItunes, alertTitle: Constants.shared.noProductAvailable)
                default:
                    self.displayErrorAlert(errorMessage: Constants.shared.kTransactionFailedCancelled, alertTitle: Constants.shared.kError)
                    break
                }
            }
        }
    }
    
    func transactionInProcess() {
        CommonMethods.shared.showProgressIndicator()
    }
    
    func connectionToAppStoreFailed(errorMessage: String) {
        self.displayErrorAlert(errorMessage: Constants.shared.kiTunesConnectErrorMessage)
    }
    
    func displayErrorAlert(errorMessage:String, alertTitle:String = "") {
        CommonMethods.shared.hideActivityIndicator()
        
        DispatchQueue.main.async {
            guard let window = UIApplication.shared.getWindowFromSceneDelegate(), let rootViewController = window.rootViewController else { return }
            
            let okAction = UIAlertAction(title: Constants.shared.kStrOk, style: .default)
            
            let iTunesConnectErrorAlert = UIAlertController(title: alertTitle,
                                                            message: errorMessage,
                                                            preferredStyle: .alert)
            
            iTunesConnectErrorAlert.addAction(okAction)
            
            rootViewController.present(iTunesConnectErrorAlert, animated: true)
        }
    }
    
}

// MARK: - VLStoreKitSubscriptionSyncDelegate

// Methods for handling subscription synchronization events
extension SubscriptionHandler: VLStoreKitSubscriptionSyncDelegate {
    func subscriptionSyncCompleted(subscriptionSyncResponse: SubscriptionSyncResponse) {
        CommonMethods.shared.hideActivityIndicator()
        
        if let errorCode = subscriptionSyncResponse.errorCode {
            print("TRANSACTION PURCHASED subscriptionSyncCompleted errorCode")
        }
        else {
            print("TRANSACTION PURCHASED subscriptionSyncCompleted success")
            
            self.showSuccessScreen(subscriptionSyncResponse: subscriptionSyncResponse)
        }
    }
    
    func subscriptionSyncFailed(errorCode: SubscriptionSyncStatus) {
        print("TRANSACTION PURCHASED subscriptionSyncFailed")
        self.storeKit.storeKitSubscriptionSyncDelegate = nil
        
        CommonMethods.shared.hideActivityIndicator()
        
        self.displayErrorAlert(errorMessage: errorCode.rawValue)
    }
    
    func transactionPurchaseSync(isSyncCompleted: Bool, errorCode: SubscriptionSyncStatus) {
        
    }
    
    func showSuccessScreen(subscriptionSyncResponse: SubscriptionSyncResponse){
        let vc = SuccessViewController()
        vc.subscriptionSyncResponse = subscriptionSyncResponse
        let rootNavigation = UINavigationController(rootViewController: vc)
        UIApplication.shared.getWindowFromSceneDelegate()?.rootViewController = rootNavigation
    }
    
}

// MARK: - Restoration of Purchase

// Initiates the restoration of purchase process
extension SubscriptionHandler {
    func restorePurchase() {
//        Restoration of purchase logic using VLStoreKit
        CommonMethods.shared.showProgressIndicator()
        self.storeKit.initateRestorePurchase { storeKitModel, error in
            self.proceedFurtherAfterRestorePurchase(storeKitModel: storeKitModel, error: error)
        }
    }
    
    private func proceedFurtherAfterRestorePurchase(storeKitModel:VLStoreKitModel?, error:TransactionError?) {
        DispatchQueue.main.async {
            if error == nil && storeKitModel != nil {
                CommonMethods.shared.showProgressIndicator()
                
                
                guard let storeKitModel else  {
                    CommonMethods.shared.hideActivityIndicator()
                    return
                }
                
                guard let transactionReceipt = storeKitModel.transactionReceipt else {
                    CommonMethods.shared.hideActivityIndicator()
                    return
                }
                
                let data = Data(referencing: transactionReceipt)
                self.storeKit.storeKitSubscriptionSyncDelegate = self
                self.storeKit.syncSubscriptionStatusToVLSystem(planId: storeKitModel.productId,
                                                               transactionId: storeKitModel.transactionId,
                                                               originalTransactionId: storeKitModel.originalTransactionId,
                                                               productId: storeKitModel.productId,
                                                               transactionReceipt: data,
                                                               transactionType: .purchase)
            }
            else {
                CommonMethods.shared.hideActivityIndicator()
                
                self.displayErrorAlert(errorMessage: error?.rawValue ?? "")
            }
        }
    }

}
