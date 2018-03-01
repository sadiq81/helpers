//
//  MKMapView+Extensions.swift
//  helpers
//
//  Created by Tommy Hinrichsen on 01/03/2018.
//  Copyright © 2018 EazyIT. All rights reserved.
//

import Foundation
import MapKit

extension MKMapView {
    
    public var widthOfMapViewInMeters: Int {
        let eastMapPoint = MKMapPointMake(MKMapRectGetMinX(self.visibleMapRect), MKMapRectGetMidY(self.visibleMapRect))
        let westMapPoint = MKMapPointMake(MKMapRectGetMaxX(self.visibleMapRect), MKMapRectGetMidY(self.visibleMapRect))
        let currentDistWideInMeters = MKMetersBetweenMapPoints(eastMapPoint, westMapPoint)
        return currentDistWideInMeters.int
    }
    
    public var heightOfMapViewInMeters: Int {
        let northMapPoint = MKMapPointMake(MKMapRectGetMidX(self.visibleMapRect), MKMapRectGetMinY(self.visibleMapRect))
        let southMapPoint = MKMapPointMake(MKMapRectGetMidX(self.visibleMapRect), MKMapRectGetMaxY(self.visibleMapRect))
        let currentDistHeightInMeters = MKMetersBetweenMapPoints(northMapPoint, southMapPoint)
        return currentDistHeightInMeters.int
    }
    
    public func set10KmRegion(coordinate: CLLocationCoordinate2D, animated: Bool) {
        let maximumSide = max(self.frame.height, self.frame.width)
        let minimumSide = min(self.frame.height, self.frame.width)
        
        var formFactor = minimumSide / maximumSide
        if formFactor.isNaN {
            formFactor = 1
        }
        
        let maxDistance = 10000 /*10 km*/ * formFactor.double
        
        let region = MKCoordinateRegionMakeWithDistance(coordinate, maxDistance, maxDistance)
        self.setRegion(region, animated: animated)
    }
    
}
