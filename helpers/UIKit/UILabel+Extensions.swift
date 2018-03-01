//
// Created by Tommy Sadiq Hinrichsen on 18/01/2018.
// Copyright (c) 2018 Parkzone. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {

    public var safeText: String {
        return self.text ?? ""
    }

    public func animate(font: UIFont, duration: TimeInterval) {

        if self.font.fontName == font.fontName && self.font.pointSize == font.pointSize { return }
        // let oldFrame = frame
        let labelScale = self.font.pointSize / font.pointSize
        self.font = font
        let oldTransform = transform
        transform = transform.scaledBy(x: labelScale, y: labelScale)
        // let newOrigin = frame.origin
        // frame.origin = oldFrame.origin // only for left aligned text
        // frame.origin = CGPoint(x: oldFrame.origin.x + oldFrame.width - frame.width, y: oldFrame.origin.y) // only for right aligned text
        setNeedsUpdateConstraints()
        UIView.animate(withDuration: duration) {
            //L self.frame.origin = newOrigin
            self.transform = oldTransform
            self.layoutIfNeeded()
        }
    }
}
