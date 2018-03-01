//
//  Response+Extensions.swift
//  helpers
//
//  Created by Tommy Hinrichsen on 01/03/2018.
//  Copyright © 2018 EazyIT. All rights reserved.
//

import Foundation
import Moya

extension Response {
    
    public static var empty: Response { return Response(statusCode: 204, data: Data()) }
    
}

