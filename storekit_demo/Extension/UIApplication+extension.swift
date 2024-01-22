//
//  UIApplication+extension.swift
//  storekit_demo
//
//  Created by NexG on 21/01/24.
//

import Foundation
import UIKit

extension UIApplication {
    func getWindowFromSceneDelegate() -> UIWindow? {
        var window: UIWindow?

        if #available(iOS 13.0, *) {
            if let scene = self.connectedScenes.first as? UIWindowScene {
                window = scene.windows.first
            }
        } else {
            window = self.keyWindow
        }

        return window
    }
}
