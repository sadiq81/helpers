//
// Created by Tommy Hinrichsen on 01/02/2018.
// Copyright (c) 2018 Parkzone. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {

    // create a 1x1 image with this color
    public class func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }

    public func tinted(color: UIColor) -> UIImage? {
        let image = self.withRenderingMode(.alwaysTemplate)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.set()
        image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let tinted = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return tinted
    }

    public func imageRotatedByDegrees(deg degrees: CGFloat) -> UIImage {
        let maxSize = max(self.size.width, self.size.height)
        let size = CGSize(width: maxSize, height: maxSize)

        UIGraphicsBeginImageContext(size)

        let bitmap: CGContext = UIGraphicsGetCurrentContext()!
        //Move the origin to the middle of the image so we will rotate and scale around the center.
        bitmap.translateBy(x: size.width / 2, y: size.height / 2)
        //Rotate the image context
        bitmap.rotate(by: (degrees * CGFloat(Double.pi / 180)))
        //Now, draw the rotated/scaled image into the context
        bitmap.scaleBy(x: 1.0, y: -1.0)

        let origin = CGPoint(x: -size.width / 2, y: -size.width / 2)

        bitmap.draw(self.cgImage!, in: CGRect(origin: origin, size: size))

        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }

    public class func getScreenShot() -> UIImage {
        let view: UIView = UIApplication.shared.keyWindow!
        let snappedView = view.snapshotView(afterScreenUpdates: true)
        UIGraphicsBeginImageContextWithOptions(view.frame.size, false, UIScreen.main.scale)
        snappedView?.drawHierarchy(in: view.frame, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
