//
// Created by Tommy Hinrichsen on 22/12/2017.
// Copyright (c) 2017 Mustache ApS. All rights reserved.
//

import Foundation
import MapKit
import RxSwift

extension MKLocalSearch {
    public func mapItems() -> Observable<[MKMapItem]> {
        return Observable.create { observer in
            self.start(completionHandler: { (response, error) in
                if let error = error {
                    observer.onError(error)
                } else {
                    let items = response?.mapItems ?? []
                    observer.onNext(items)
                    observer.onCompleted()
                }
            })
            return Disposables.create {
                self.cancel()
            }
        }
    }
}
