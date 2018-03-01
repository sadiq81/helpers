//
//  CharacterSet+Extensions.swift
//  helpers
//
//  Created by Tommy Hinrichsen on 01/03/2018.
//  Copyright © 2018 EazyIT. All rights reserved.
//

import Foundation

extension CharacterSet {
    
    public func contains(_ character: Character) -> Bool {
        let string = String(character)
        return string.rangeOfCharacter(from: self, options: [], range: string.startIndex..<string.endIndex) != nil
    }
}
