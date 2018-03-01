//
//  IndexPath+Extension.swift
//  helpers
//
//  Created by Tommy Hinrichsen on 01/03/2018.
//  Copyright © 2018 EazyIT. All rights reserved.
//

import Foundation
import UIKit

extension IndexPath {
    
    public static let firstItem = IndexPath(item: 0, section: 0)
    public static let firstRow = IndexPath(row: 0, section: 0)
    
    public var nextItem: IndexPath { return IndexPath(item: self.item + 1, section: self.section) }
    
    public var nextRow: IndexPath { return IndexPath(row: self.row + 1, section: self.section) }
    
}
