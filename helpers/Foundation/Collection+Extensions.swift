//
//  Collection+Extensions.swift
//  helpers
//
//  Created by Tommy Hinrichsen on 01/03/2018.
//  Copyright © 2018 EazyIT. All rights reserved.
//

import Foundation

extension Collection {
    
    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
   public subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
