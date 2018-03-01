//
// Created by Tommy Sadiq Hinrichsen on 28/02/2018.
// Copyright (c) 2018 Parkzone. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {

    public var isModal: Bool {
        if self.presentingViewController != nil {
            return true
        } else if self.navigationController?.presentingViewController?.presentedViewController == self.navigationController {
            return true
        } else if self.tabBarController?.presentingViewController is UITabBarController {
            return true
        }
        return false
    }
}
