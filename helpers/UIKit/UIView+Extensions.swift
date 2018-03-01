//
// Created by Tommy Hinrichsen on 17/01/2018.
// Copyright (c) 2018 Parkzone. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

//Hierarchy
extension UIView {

    public func addSubviews(_ views: UIView...) {
        views.forEach { view in self.addSubview(view) }
    }

    public var rootView: UIView {
        if let view = self.superview {
            return view.rootView
        } else {
            return self
        }
    }

/** This is the function to get subViews of a view of a particular type
*/
    public func subViews<T: UIView>(type: T.Type) -> [T] {
        var all = [T]()
        for view in self.subviews {
            if let aView = view as? T {
                all.append(aView)
            }
        }
        return all
    }


/** This is a function to get subViews of a particular type from view recursively. It would look recursively in all subviews and return back the subviews of the type T */
    public func allSubViewsOf<T: UIView>(type: T.Type) -> [T] {
        var all = [T]()

        func getSubview(view: UIView) {
            if let aView = view as? T {
                all.append(aView)
            }
            guard view.subviews.count > 0 else { return }
            view.subviews.forEach { getSubview(view: $0) }
        }

        getSubview(view: self)
        return all
    }
}

//Autolayout
extension UIView {

    public var safeArea: ConstraintBasicAttributesDSL {

#if swift(>=3.2)
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.snp
        }
        return self.snp
#else
        return self.snp
#endif
    }

}

//Animations
extension UIView {

    public func shake(completion: ((Bool) -> Void)? = nil) {
        self.transform = CGAffineTransform(translationX: 20, y: 0)
        UIView.animate(withDuration: 0.4,
                delay: 0,
                usingSpringWithDamping: 0.2,
                initialSpringVelocity: 1,
                options: .curveEaseInOut,
                animations: { self.transform = CGAffineTransform.identity },
                completion: completion)
    }

}

//Appearance
extension UIView {

    @discardableResult
    public func addBorder(edges: UIRectEdge, color: UIColor = UIColor.white, thickness: CGFloat = 1.0) -> [UIView] {

        var borders: [UIView] = []

        func border() -> UIView {
            let border = UIView(frame: CGRect.zero)
            //border.layer.zPosition = Int.max.cgfloat
            border.backgroundColor = color
            border.translatesAutoresizingMaskIntoConstraints = false
            borders.append(border)
            self.addSubview(border)
            return border
        }

        if edges.contains(.top) || edges.contains(.all) {
            let top = border()
            top.snp.makeConstraints { maker in
                maker.top.left.right.equalTo(self)
                maker.height.equalTo(thickness)
            }
        }

        if edges.contains(.left) || edges.contains(.all) {
            let left = border()
            left.snp.makeConstraints { maker in
                maker.top.left.bottom.equalTo(self)
                maker.width.equalTo(thickness)
            }
        }

        if edges.contains(.right) || edges.contains(.all) {
            let right = border()
            right.snp.makeConstraints { maker in
                maker.top.right.bottom.equalTo(self)
                maker.width.equalTo(thickness)
            }
        }

        if edges.contains(.bottom) || edges.contains(.all) {
            let bottom = border()
            bottom.snp.makeConstraints { maker in
                maker.left.right.bottom.equalTo(self)
                maker.height.equalTo(thickness)
            }
        }
        return borders
    }

    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }

}

//Tappeble closures
extension UIView {

    // In order to create computed properties for extensions, we need a key to
    // store and access the stored property
    fileprivate struct AssociatedObjectKeys {
        static var tapGestureRecognizer = "MediaViewerAssociatedObjectKey_mediaViewer"
    }

    fileprivate typealias Action = ((UIView) -> Void)?

    // Set our computed property type to a closure
    fileprivate var tapGestureRecognizerAction: Action? {
        set {
            if let newValue = newValue {
                // Computed properties get stored as associated objects
                objc_setAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
        get {
            let tapGestureRecognizerActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer) as? Action
            return tapGestureRecognizerActionInstance
        }
    }

    // This is the meat of the sauce, here we create the tap gesture recognizer and
    // store the closure the user passed to us in the associated object we declared above
    public func addTapGestureRecognizer(_ action: ((UIView) -> Void)?) {
        self.isUserInteractionEnabled = true
        self.tapGestureRecognizerAction = action
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        tapGestureRecognizer.cancelsTouchesInView = false
        self.addGestureRecognizer(tapGestureRecognizer)
    }

    // Every time the user taps on the UIImageView, this function gets called,
    // which triggers the closure we stored
    @objc fileprivate func handleTapGesture(sender: UITapGestureRecognizer) {
        if let action = self.tapGestureRecognizerAction {
            action?(self)
        } else {
            print("no action")
        }
    }

}
