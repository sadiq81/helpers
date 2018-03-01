//
//  UIApplication+Rx.swift
//  helpers
//
//  Created by Tommy Hinrichsen on 01/03/2018.
//  Copyright © 2018 EazyIT. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

extension PrimitiveSequence where Trait == SingleTrait {
    
    public func withStatusIndicator() -> PrimitiveSequence {
        
        return self.do(
            onSubscribed: {
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
        },
            onDispose: {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                })
        })
    }
}
