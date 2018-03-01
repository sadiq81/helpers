//
// Created by Privat on 05/09/2016.
// Copyright (c) 2016 Eazy IT. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import RxSwift
import RxCocoa

class GeoLocationService {

    public static let sharedInstance = GeoLocationService()

    fileprivate (set) var authorized: Observable<Bool>
    fileprivate (set) lazy var location: Observable<CLLocation> = {
        return locationManager.rx.didUpdateLocations
                .filter({ (locations: [CLLocation]) -> Bool in
                    return locations.count > 0
                })
                .map({ (locations: [CLLocation]) -> CLLocation in
                    return locations.first!
                })
                .share(replay: 1)
                .do(onSubscribe: { [weak self] in
                    guard let weakSelf = self else { return }
                    weakSelf.changeObserverCount(1)
                }, onDispose: { [weak self] in
                    guard let weakSelf = self else { return }
                    weakSelf.changeObserverCount(-1)
                })
    }()

    fileprivate let locationManager = CLLocationManager()
    fileprivate let disposeBag = DisposeBag()

    fileprivate init() {

        self.locationManager.distanceFilter = kCLDistanceFilterNone
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation

        authorized = locationManager.rx.didChangeAuthorizationStatus.map({ (status: CLAuthorizationStatus) -> Bool in
            switch status {
                case .authorizedWhenInUse, .authorizedAlways:
                    return true
                default:
                    return false
            }
        })
        self.locationManager.requestWhenInUseAuthorization()

    }

    fileprivate var observers: Int = 0

    fileprivate func changeObserverCount(_ value: Int) {
        self.observers += value
        if self.observers < 0 {
            fatalError()
        } else if self.observers == 0 {
            self.locationManager.stopUpdatingLocation()
        } else {
            self.locationManager.startUpdatingLocation()
        }
    }
}
