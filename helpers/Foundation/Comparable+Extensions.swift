//
//  Comparable+Extensions.swift
//  helpers
//
//  Created by Tommy Hinrichsen on 01/03/2018.
//  Copyright © 2018 EazyIT. All rights reserved.
//

import Foundation

public func <<T: Comparable>(left: T?, right: T) -> Bool {
    if let left = left {
        return left < right
    }
    return false
}
