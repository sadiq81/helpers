//
//  Button.swift
//  helpers
//
//  Created by Tommy Hinrichsen on 01/03/2018.
//  Copyright © 2018 EazyIT. All rights reserved.
//

import Foundation
import UIKit

class Button: UIButton {
    
    var normalFont: UIFont? = nil
    var highlightedFont: UIFont? = nil
    var disabledFont: UIFont? = nil
    var selectedFont: UIFont? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    typealias DidTapButton = (Button) -> ()
    
    var didTouchUpInside: DidTapButton? {
        didSet {
            if didTouchUpInside != nil {
                addTarget(self, action: #selector(didTouchUpInside(sender:)), for: .touchUpInside)
            } else {
                removeTarget(self, action: #selector(didTouchUpInside(sender:)), for: .touchUpInside)
            }
        }
    }
    
    // MARK: - Actions
    
    @objc
    func didTouchUpInside(sender: UIButton) {
        if let handler = didTouchUpInside {
            handler(self)
        }
    }
    
    func setFont(_ font: UIFont?, for state: UIControlState) {
        switch state {
        case .normal:self.normalFont = font
        case .highlighted: self.highlightedFont = font
        case .disabled: self.disabledFont = font
        case .selected: self.selectedFont = font
        default:
            break
        }
    }
    
    override func layoutSubviews() {
        
        switch self.state {
        case .normal:self.titleLabel?.font = self.normalFont ?? self.titleLabel?.font
        case .highlighted: self.titleLabel?.font = self.highlightedFont ?? self.titleLabel?.font
        case .disabled: self.titleLabel?.font = self.disabledFont ?? self.titleLabel?.font
        case .selected: self.titleLabel?.font = self.selectedFont ?? self.titleLabel?.font
        default:
            break
        }
        
        super.layoutSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("\(#line) not implemented") }
}
