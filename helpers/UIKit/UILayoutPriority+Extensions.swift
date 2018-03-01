//
// Created by Tommy Hinrichsen on 31/01/2018.
// Copyright (c) 2018 Parkzone. All rights reserved.
//

import Foundation
import UIKit

extension UILayoutPriority {
    public static func +(lhs: UILayoutPriority, rhs: Float) -> UILayoutPriority {
        return UILayoutPriority(lhs.rawValue + rhs)
    }

    public static func -(lhs: UILayoutPriority, rhs: Float) -> UILayoutPriority {
        return UILayoutPriority(lhs.rawValue - rhs)
    }
}
