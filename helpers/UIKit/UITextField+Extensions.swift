//
// Created by Tommy Hinrichsen on 02/02/2018.
// Copyright (c) 2018 Parkzone. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {

    public var safeText: String {
        return self.text ?? ""
    }

    public var toolbarLoading: Bool {
        set {
            if newValue { self.toolbarStartLoading() } else { self.toolbarStopLoading() }; self.nextSibling?.toolbarLoading = newValue
        }
        get { return self.loadingIndicator?.isAnimating ?? false }
    }

    public var isDoneHidden: Bool {
        set {
            self.doneButton!.isEnabled = !newValue
            self.doneButton!.tintColor = newValue ? .clear : nil
            self.doneButton!.width = newValue ? 0.01 : 0
            self.nextSibling?.isDoneHidden = newValue
        }
        get { return self.doneButton!.isEnabled }
    }

    fileprivate func toolbarStartLoading() {
        if let toolbar = (self.inputAccessoryView as? UIToolbar),
           var items = toolbar.items,
           let loading = self.loadingButton,
           let loadingView = (loading.customView as? UIActivityIndicatorView) {
            items.remove(at: 4)
            items.insert(loading, at: 4)
            loadingView.startAnimating()
            toolbar.items = items
        }
    }

    fileprivate func toolbarStopLoading() {
        if let toolbar = (self.inputAccessoryView as? UIToolbar),
           var items = toolbar.items,
           let loading = self.loadingButton,
           let loadingView = (loading.customView as? UIActivityIndicatorView),
           let done = self.doneButton {
            loadingView.stopAnimating()
            items.remove(at: 4)
            items.insert(done, at: 4)
            toolbar.items = items
        }
    }

    fileprivate var previousButton: UIBarButtonItem? { return (self.inputAccessoryView as? UIToolbar)?.items?[safe: 0] }
    fileprivate var nextButton: UIBarButtonItem? { return (self.inputAccessoryView as? UIToolbar)?.items?[safe: 2] }

    fileprivate var loadingIndicator: UIActivityIndicatorView? { return self.loadingButton?.customView as? UIActivityIndicatorView }
    fileprivate var dismissButton: UIBarButtonItem? { return (self.inputAccessoryView as? UIToolbar)?.items?.last }

    @discardableResult
    public func addAccessoryView(doneText: String, dismissText: String, previousImage: UIImage, nextImage: UIImage) -> UIToolbar {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 44))

        let previousButton = UIBarButtonItem(image: previousImage, style: .plain, target: self, action: #selector(handlePrevious))
        previousButton.isEnabled = false

        let spacer1 = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spacer1.width = 19

        let nextButton = UIBarButtonItem(image: nextImage, style: .plain, target: self, action: #selector(handleNext))
        nextButton.isEnabled = false

        let spacer2 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        self.doneButton = UIBarButtonItem(title: NSLocalizedString(doneText, comment: ""), style: .done, target: self, action: #selector(handleDone))

        let loadingIndicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
        self.loadingButton = UIBarButtonItem(customView: loadingIndicator)

        let dismiss = UIBarButtonItem(title: NSLocalizedString(dismissText, comment: ""), style: .done, target: self, action: #selector(handleDismiss))
        toolBar.items = [previousButton, spacer1, nextButton, spacer2, self.doneButton!, dismiss]
        toolBar.tintColor = .white
        toolBar.barTintColor = UIColor.white

        self.inputAccessoryView = toolBar
        
        return toolBar
    }

    fileprivate struct AssociatedObjectKeys {
        static var previousSibling = "UITextField.previous"
        static var nextSibling = "UITextField.next"

        static var doneButton = "UITextField.done.button"
        static var loadingButton = "UITextField.loading.button"

        static var doneAction = "UITextField.done.action"
        static var dismissAction = "UITextField.dismiss.action"
    }

    // ------------------------- Next/Previous responder ------------------------- //

    public var previousSibling: UITextField? {
        set {
            self.previousButton?.isEnabled = newValue != nil
            if let newValue = newValue {

                // Computed properties get stored as associated objects
                objc_setAssociatedObject(self, &AssociatedObjectKeys.previousSibling, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
        get {
            let previousSiblingInstance = objc_getAssociatedObject(self, &AssociatedObjectKeys.previousSibling) as? UITextField
            return previousSiblingInstance
        }
    }

    @objc
    fileprivate func handlePrevious() {
        self.previousSibling?.becomeFirstResponder()
    }

    public var nextSibling: UITextField? {
        set {
            self.nextButton?.isEnabled = newValue != nil
            if let newValue = newValue {
                // Computed properties get stored as associated objects
                objc_setAssociatedObject(self, &AssociatedObjectKeys.nextSibling, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
        get {
            let nextSiblingInstance = objc_getAssociatedObject(self, &AssociatedObjectKeys.nextSibling) as? UITextField
            return nextSiblingInstance
        }
    }

    @objc
    fileprivate func handleNext() {
        self.nextSibling?.becomeFirstResponder()
    }

    // ------------------------- Buttons ------------------------- //

    public var doneButton: UIBarButtonItem? {
        set {
            if let newValue = newValue {
                // Computed properties get stored as associated objects
                objc_setAssociatedObject(self, &AssociatedObjectKeys.doneButton, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
        get {
            let doneButtonInstance = objc_getAssociatedObject(self, &AssociatedObjectKeys.doneButton) as? UIBarButtonItem
            return doneButtonInstance
        }
    }

    @objc
    fileprivate func handleDone() {
        self.doneAction?()
    }

    public var loadingButton: UIBarButtonItem? {
        set {
            if let newValue = newValue {
                // Computed properties get stored as associated objects
                objc_setAssociatedObject(self, &AssociatedObjectKeys.loadingButton, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
        get {
            let doneButtonInstance = objc_getAssociatedObject(self, &AssociatedObjectKeys.loadingButton) as? UIBarButtonItem
            return doneButtonInstance
        }
    }

    // ------------------------- Actions ------------------------- //

    public typealias Action = (() -> Void)

    public var doneAction: Action? {
        set {
            if let newValue = newValue {
                self.doneButton?.isEnabled = true
                self.doneButton?.tintColor = nil
                // Computed properties get stored as associated objects
                objc_setAssociatedObject(self, &AssociatedObjectKeys.doneAction, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            } else {
                self.doneButton?.isEnabled = false
                self.doneButton?.tintColor = .clear
            }
        }
        get {
            let doneActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKeys.doneAction) as? Action
            return doneActionInstance
        }
    }

    public var dismissAction: Action? {
        set {
            if let newValue = newValue {
                // Computed properties get stored as associated objects
                objc_setAssociatedObject(self, &AssociatedObjectKeys.dismissAction, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
        get {
            let dismissActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKeys.dismissAction) as? Action
            return dismissActionInstance
        }
    }

    @objc
    fileprivate func handleDismiss() {
        if let dismiss = self.dismissAction {
            dismiss()
        } else {
            UIApplication.shared.keyWindow?.endEditing(true)
        }
    }

}
