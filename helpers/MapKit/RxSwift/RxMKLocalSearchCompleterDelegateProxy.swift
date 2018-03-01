//
//  RxCLLocationManagerDelegateProxy.swift
//  RxCocoa
//
//  Created by Carlos García on 8/7/15.
//  Copyright © 2015 Krunoslav Zaher. All rights reserved.
//

import CoreLocation
import MapKit

#if !RX_NO_MODULE

import RxSwift
import RxCocoa

#endif

extension MKLocalSearchCompleter: HasDelegate {
    public typealias Delegate = MKLocalSearchCompleterDelegate
}

class RxMKLocalSearchCompleterDelegateProxy: DelegateProxy<MKLocalSearchCompleter, MKLocalSearchCompleterDelegate>, DelegateProxyType, MKLocalSearchCompleterDelegate {

    /// Typed parent object.
    public weak fileprivate(set) var localSearchCompleter: MKLocalSearchCompleter?

    /// - parameter scrollView: Parent object for delegate proxy.
    public init(localSearchCompleter: ParentObject) {
        self.localSearchCompleter = localSearchCompleter
        super.init(parentObject: localSearchCompleter, delegateProxy: RxMKLocalSearchCompleterDelegateProxy.self)
    }

    // Register known implementations
    public static func registerKnownImplementations() {
        self.register { RxMKLocalSearchCompleterDelegateProxy(localSearchCompleter: $0) }
    }

    public static func currentDelegate(for object: MKLocalSearchCompleter) -> MKLocalSearchCompleterDelegate? {
        return object.delegate
    }

    public static func setCurrentDelegate(_ delegate: MKLocalSearchCompleterDelegate?, to object: MKLocalSearchCompleter) {
        object.delegate = delegate
    }

}
