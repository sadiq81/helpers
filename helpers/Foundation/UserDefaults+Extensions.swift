//
//  UserDefaults+Extensions.swift
//  helpers
//
//  Created by Tommy Hinrichsen on 01/03/2018.
//  Copyright © 2018 EazyIT. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    public func archive<T: NSCoding>(object: T?, forKey key: String) {
        if let object = object {
            let archive = NSKeyedArchiver.archivedData(withRootObject: object) as NSData
            UserDefaults.standard.set(archive, forKey: key)
        } else {
            UserDefaults.standard.removeObject(forKey: key)
        }
    }
    
    public func unarchive<T: NSCoding>(forKey key: String) -> T? {
        if let unarchivedObject = UserDefaults.standard.data(forKey: key) {
            return NSKeyedUnarchiver.unarchiveObject(with: unarchivedObject) as? T
        } else {
            return nil
        }
    }
    
    public func archive<T: NSCoding>(object: [T], forKey key: String) {
        let archive = NSKeyedArchiver.archivedData(withRootObject: object as NSArray) as NSData
        UserDefaults.standard.set(archive, forKey: key)
    }
    
    public func unarchive<T: NSCoding>(forKey key: String) -> [T] {
        if let unarchivedObject = UserDefaults.standard.data(forKey: key) {
            return NSKeyedUnarchiver.unarchiveObject(with: unarchivedObject) as? [T] ?? []
        } else {
            return []
        }
    }
    
    public func hasValue(forKey key: String) -> Bool {
        return nil != object(forKey: key)
    }
}
