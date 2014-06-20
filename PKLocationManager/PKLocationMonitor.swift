//
//  PKLocationMonitor.swift
//  PKLocationManager
//
//  Created by Philip Kluz on 6/20/14.
//  Copyright (c) 2014 NSExceptional. All rights reserved.
//

import Foundation
import CoreLocation

@final class PKLocationMonitor {
    
    var monitoringObject: AnyObject
    var queue: dispatch_queue_t
    var handler: ((CLLocation) -> ())?
    var desiredAccuracy: CLLocationAccuracy
    
    init(monitoringObject object: AnyObject, queue: dispatch_queue_t = dispatch_get_main_queue(), desiredAccuracy: CLLocationAccuracy = kCLLocationAccuracyHundredMeters, handler: ((CLLocation) -> ())?) {
        self.monitoringObject = object
        self.queue = queue
        self.desiredAccuracy = desiredAccuracy
        self.handler = handler
    }
}
