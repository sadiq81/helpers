//
//  TextField.swift
//  helpers
//
//  Created by Tommy Hinrichsen on 01/03/2018.
//  Copyright © 2018 EazyIT. All rights reserved.
//

import Foundation
import UIKit

class TextField: UITextField {
    
    let allowedCharactersChar: String = "*"
    public var formattingPattern: String? //Use * instead of allowed characters, fx ****-****-****-****
    public var allowedCharacters: CharacterSet? // fx CharacterSet.decimalDigits
    public var regexPatterns: [String] = [] // fx VISA ^4[0-9]{12}(?:[0-9]{3})?$
    
    public init(placeholder: String = "",
         placeHolderColor: UIColor = .gray,
         placeHolderFont: UIFont? = nil,
         font: UIFont? = nil,
         alignment: NSTextAlignment = .left,
         color: UIColor = .black) {
        
        super.init(frame: .zero)
        
        var attributes : [NSAttributedStringKey: Any] = [NSAttributedStringKey.foregroundColor: placeHolderColor]
        if let placeHolderFont = placeHolderFont {
            attributes[NSAttributedStringKey.font] = placeHolderFont
        }
        self.attributedPlaceholder = NSAttributedString(string: NSLocalizedString(placeholder, comment: ""), attributes: attributes)
        self.font = font
        self.textAlignment = alignment
        self.textColor = color
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.registerForNotifications()
    }
    
    fileprivate func registerForNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: NSNotification.Name.UITextFieldTextDidChange, object: self)
    }
    
    @objc
    func textDidChange() {
        
        guard let text = self.text, let formattingPattern = self.formattingPattern else { return }
        
        if text.count > 0 && formattingPattern.count > 0 {
            
            let maskCharacters: String = formattingPattern.replacingOccurrences(of: allowedCharactersChar, with: "") //---
            let maskedCharacterSet: CharacterSet = CharacterSet(charactersIn: maskCharacters) // -
            let tempString: String = text.components(separatedBy: maskedCharacterSet).joined() //4571123456781234
            
            var finalText = ""
            
            var tempIndex = tempString.startIndex
            var formatterIndex = formattingPattern.startIndex
            
            repeat {
                
                let tempChar: Character = tempString[tempIndex]
                let formatChar: Character = formattingPattern[formatterIndex]
                
                if maskedCharacterSet.contains(formatChar) {
                    finalText += String(formatChar)
                    formatterIndex = formattingPattern.index(formatterIndex, offsetBy: 1)
                } else {
                    finalText += String(tempChar)
                    
                    tempIndex = tempString.index(tempIndex, offsetBy: 1)
                    formatterIndex = formattingPattern.index(formatterIndex, offsetBy: 1)
                }
                
            } while formatterIndex < formattingPattern.endIndex && tempIndex < tempString.endIndex
            
            self.text = finalText
        }
    }
    
    public var containsIllegalCharacters: Bool {
        var containsIllegalCharacters = false
        if let illegalCharacters = self.allowedCharacters?.inverted {
            containsIllegalCharacters = self.safeText.rangeOfCharacter(from: illegalCharacters) != nil
        }
        return containsIllegalCharacters
    }
    
    public var regExMatch: Bool {
        if self.regexPatterns.count == 0 { return true }
        for pattern in self.regexPatterns {
            if let regex = try? NSRegularExpression(pattern: pattern) {
                let results = regex.matches(in: self.safeText, range: NSRange(self.safeText.startIndex..., in: self.safeText))
                if results.count > 0 { return true }
            }
        }
        return false
    }
    
    public var isValid: Bool {
        return !self.containsIllegalCharacters && self.regExMatch
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
}
