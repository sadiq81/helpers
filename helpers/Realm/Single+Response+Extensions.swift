//
//  Single+Response+Extensions.swift
//  helpers
//
//  Created by Tommy Hinrichsen on 01/03/2018.
//  Copyright © 2018 EazyIT. All rights reserved.
//

import Foundation
import Moya
import RxSwift

extension Single where Element: Response {
    
    public static var emptyResponse: Single<Response> { return Single.just(Response.empty) }
    
}
