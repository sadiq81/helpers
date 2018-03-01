//
//  RxCLLocationManagerDelegateProxy.swift
//  RxCocoa
//
//  Created by Carlos García on 8/7/15.
//  Copyright © 2015 Krunoslav Zaher. All rights reserved.
//

import CoreLocation

#if !RX_NO_MODULE

import RxSwift
import RxCocoa

#endif

extension CLLocationManager: HasDelegate {
    public typealias Delegate = CLLocationManagerDelegate
}

class RxCLLocationManagerDelegateProxy: DelegateProxy<CLLocationManager, CLLocationManagerDelegate>, DelegateProxyType, CLLocationManagerDelegate {

    /// Typed parent object.
    public weak fileprivate(set) var clLocationManager: CLLocationManager?

    /// - parameter scrollView: Parent object for delegate proxy.
    public init(clLocationManager: ParentObject) {
        self.clLocationManager = clLocationManager
        super.init(parentObject: clLocationManager, delegateProxy: RxCLLocationManagerDelegateProxy.self)
    }

    // Register known implementations
    public static func registerKnownImplementations() {
        self.register { RxCLLocationManagerDelegateProxy(clLocationManager: $0) }
    }

    public static func currentDelegate(for object: CLLocationManager) -> CLLocationManagerDelegate? {
        return object.delegate
    }

    public static func setCurrentDelegate(_ delegate: CLLocationManagerDelegate?, to object: CLLocationManager) {
        object.delegate = delegate
    }

}
