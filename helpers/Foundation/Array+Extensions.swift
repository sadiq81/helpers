//
//  Array+Extensions.swift
//  helpers
//
//  Created by Tommy Hinrichsen on 01/03/2018.
//  Copyright © 2018 EazyIT. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
    public mutating func rearrange(fromIndex: Int, toIndex: Int) {
        let element = self.remove(at: fromIndex)
        self.insert(element, at: toIndex)
    }
    
    public mutating func moveToFront(element: Element) {
        guard let index = self.index(where: { index -> Bool in return index == element }) else { return }
        self.rearrange(fromIndex: index, toIndex: 0)
    }
    
    public mutating func
        remove(element: Element) {
        guard let index = self.index(where: { index -> Bool in return index == element }) else { return }
        self.remove(at: index)
    }
    
    @discardableResult
    public mutating func remove(elements: [Element]) -> [Element] {
        for element in elements {
            guard let index = self.index(where: { index -> Bool in return index == element }) else { continue }
            self.remove(at: index)
        }
        return self
    }
}

extension Array {
    public func grouped<T>(by criteria: (Element) -> T) -> [T: [Element]] {
        var groups = [T: [Element]]()
        for element in self {
            let key = criteria(element)
            if groups.keys.contains(key) == false {
                groups[key] = [Element]()
            }
            groups[key]?.append(element)
        }
        return groups
    }
}
