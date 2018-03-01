//
//  Results+Extensions.swift
//  helpers
//
//  Created by Tommy Hinrichsen on 01/03/2018.
//  Copyright © 2018 EazyIT. All rights reserved.
//

import Foundation
import RealmSwift

extension Results {
    
    public func toArray<T>() -> [T] {
        var array = [T]()
        for result in self {
            guard let casted = result as? T else { continue }
            array.append(casted)
        }
        return array
    }
}
