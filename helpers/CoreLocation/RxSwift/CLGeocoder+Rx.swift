//
//  CLGeocoder+Rx.swift
//
//  Created by Daniel Tartaglia on 5/7/16.
//  Copyright © 2017 Daniel Tartaglia. MIT License.
//

import RxSwift
import CoreLocation

extension CLLocation {
    convenience init(coordinate: CLLocationCoordinate2D) {
        self.init(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }
}

public extension Reactive where Base: CLGeocoder {

    public func reverseGeocodeLocation(location: CLLocation) -> Observable<[CLPlacemark]> {
        return Observable<[CLPlacemark]>.create { observer in
            geocodeHandler(observer: observer, geocode: curry2(self.base.reverseGeocodeLocation, location))
            return Disposables.create { self.base.cancelGeocode() }
        }
    }

    public func reverseGeocodeLocation(coordinate: CLLocationCoordinate2D) -> Observable<[CLPlacemark]> {
        return Observable<[CLPlacemark]>.create { observer in
            let location = CLLocation(coordinate: coordinate)
            geocodeHandler(observer: observer, geocode: curry2(self.base.reverseGeocodeLocation, location))
            return Disposables.create { self.base.cancelGeocode() }
        }
    }

    public func geocodeAddressDictionary(addressDictionary: [NSObject: AnyObject]) -> Observable<[CLPlacemark]> {
        return Observable<[CLPlacemark]>.create { observer in
            geocodeHandler(observer: observer, geocode: curry2(self.base.geocodeAddressDictionary, addressDictionary))
            return Disposables.create { self.base.cancelGeocode() }
        }
    }

   public func geocodeAddressString(addressString: String) -> Observable<[CLPlacemark]> {
        return Observable<[CLPlacemark]>.create { observer in
            geocodeHandler(observer: observer, geocode: curry2(self.base.geocodeAddressString, addressString))
            return Disposables.create { self.base.cancelGeocode() }
        }
    }

    public func geocodeAddressString(addressString: String, inRegion region: CLRegion?) -> Observable<[CLPlacemark]> {
        return Observable<[CLPlacemark]>.create { observer in
            geocodeHandler(observer: observer, geocode: curry3(self.base.geocodeAddressString, addressString, region))
            return Disposables.create { self.base.cancelGeocode() }
        }
    }
}

private func curry2<A, B, C>(_ f: @escaping (A, B) -> C, _ a: A) -> (B) -> C {
    return { b in f(a, b) }
}

private func curry3<A, B, C, D>(_ f: @escaping (A, B, C) -> D, _ a: A, _ b: B) -> (C) -> D {
    return { c in f(a, b, c) }
}

private func geocodeHandler(observer: AnyObserver<[CLPlacemark]>, geocode: @escaping (@escaping CLGeocodeCompletionHandler) -> Void) {
    let semaphore = DispatchSemaphore(value: 0)
    waitForCompletionQueue.async {
        geocode { placemarks, error in
            semaphore.signal()
            if let placemarks = placemarks {
                observer.onNext(placemarks)
                observer.onCompleted()
            } else if let error = error {
                observer.onError(error)
            } else {
                observer.onError(RxError.unknown)
            }
        }
        _ = semaphore.wait(timeout: .now() + 30)
    }
}

private let waitForCompletionQueue = DispatchQueue(label: "WaitForGeocodeCompletionQueue")