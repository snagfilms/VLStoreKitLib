//
//  CommonMethods.swift
//  storekit_demo
//
//  Created by NexG on 22/01/24.
//

import Foundation
import SVProgressHUD

final class CommonMethods: NSObject {
    static let shared: CommonMethods = CommonMethods.init()
    
    private override init() {
        super.init()
    }
    
    func showProgressIndicator(){
        DispatchQueue.main.async {
            SVProgressHUD.show()
        }
    }
    
    func hideActivityIndicator(){
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
        }
    }
}
