//
//  Date+Extensions.swift
//  helpers
//
//  Created by Tommy Hinrichsen on 01/03/2018.
//  Copyright © 2018 EazyIT. All rights reserved.
//

import Foundation

let hoursMinutesFormat = "HH:mm"
let durationFormat = "dd/MM - HH:mm"
let receiptFormat = "dd/MM/yyyy - HH:mm"
let historyFormat = "dd.MMM.yyyy HH:mm"
let isoFormat1 = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
let isoFormat2 = "yyyy-MM-dd'T'HH:mm:ss'Z'"
let headerFormat = "E, dd MMM yyyy HH:mm:ss zzzz"

extension String {
    
    public func date(_ format: String, utc: Bool = true) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = utc ? NSTimeZone(name: "UTC") as TimeZone! : TimeZone.current
        return dateFormatter.date(from: self)
    }
}

extension Date {
    
   public  func format(_ format: String, utc: Bool = true) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = utc ? NSTimeZone(name: "UTC") as TimeZone! : TimeZone.current
        return dateFormatter.string(from: self)
    }
}

import Mapper

extension Date: Convertible {
    public static func fromMap(_ value: Any) throws -> Date {
        
        guard let string = value as? String else {
            throw MapperError.convertibleError(value: value, type: [String].self)
        }
        
        if let date = string.date(hoursMinutesFormat, utc: false) {
            return date
        }
        if let date = string.date(receiptFormat, utc: true) {
            return date
        }
        if let date = string.date(isoFormat1, utc: true) {
            return date
        }
        if let date = string.date(isoFormat2, utc: true) {
            return date
        }
        if let date = string.date(headerFormat, utc: true) {
            return date
        }
        
        throw MapperError.convertibleError(value: value, type: [Date].self)
    }
}
