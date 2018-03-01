//
//  Numbers+Extensions.swift
//  helpers
//
//  Created by Tommy Hinrichsen on 01/03/2018.
//  Copyright © 2018 EazyIT. All rights reserved.
//

import Foundation

extension Double {
    public var int: Int { return Int(self) }
    public var cgfloat: CGFloat { return CGFloat(self) }
    public var float: Float { return Float(self) }
    
    public func format(format: String) -> String {
        return String(format: "%\(format)f", self)
    }
}

extension Int {
    public var double: Double { return Double(self) }
    public var cgfloat: CGFloat { return CGFloat(self) }
    public var float: Float { return Float(self) }
    public var uint: UInt { return UInt(self) }
    
    public func format(format: String) -> String {
        return String(format: "%\(format)d", self)
    }
    
    public var string: String { return "\(self)" }
}

extension UInt {
    public var int: Int { return Int(self) }
    public var float: Float { return Float(self) }
}

extension Float {
    public var double: Double { return Double(self) }
    public var cgfloat: CGFloat { return CGFloat(self) }
    public var uint: UInt { return UInt(self) }
}

infix operator &=

public func &=(lhs: inout Bool, rhs: Bool) {
    lhs = lhs && rhs
}
