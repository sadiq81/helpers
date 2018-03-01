//
//  RxUtil.swift
//  StampCardiOS
//
//  Created by Privat on 03/01/2017.
//  Copyright © 2017 Eazyit. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

func castOrThrow<T>(_ resultType: T.Type, _ object: Any) throws -> T {
    guard let returnValue = object as? T else {
        throw RxCocoaError.castingError(object: object as AnyObject, targetType: resultType)
    }

    return returnValue
}

func castOptionalOrThrow<T>(_ resultType: T.Type, _ object: Any) throws -> T? {
    if NSNull().isEqual(object) {
        return nil
    }

    guard let returnValue = object as? T else {
        throw RxCocoaError.castingError(object: object as AnyObject, targetType: resultType)
    }

    return returnValue
}

infix operator <->

func <-><T:Comparable>(property: ControlProperty<T>, variable: Variable<T>) -> Disposable {
    let variableToProperty = variable.asObservable()
            .distinctUntilChanged()
            .bind(to: property)

    let propertyToVariable = property
            .distinctUntilChanged()
            .bind(to: variable)

    return Disposables.create(variableToProperty, propertyToVariable)
}

func <-><T:Comparable>(left: Variable<T>, right: Variable<T>) -> Disposable {
    let leftToRight = left.asObservable()
            .distinctUntilChanged()
            .bind(to: right)

    let rightToLeft = right.asObservable()
            .distinctUntilChanged()
            .bind(to: left)

    return Disposables.create(leftToRight, rightToLeft)
}