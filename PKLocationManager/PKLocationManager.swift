//
//  PKLocationManager.swift
//  PKLocationManager
//
//  Created by Philip Kluz on 6/20/14.
//  Copyright (c) 2014 NSExceptional. All rights reserved.
//

import Foundation
import CoreLocation

class PKLocationManager: NSObject, CLLocationManagerDelegate {
    
    /// Shared PKLocationManager instance.
    class var sharedManager: PKLocationManager {
        return Constants.sharedManager
    }
    
    init() {
        super.init()
        
        sharedLocationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        sharedLocationManager.delegate = self
        
        requiresLocationMonitoringWhenInUse = true
    }
    
    /// Adds an object to a list of objects interested in aquiring location updates. Note that the updates might be deferred.
    func register(locationMonitor monitoringObject:AnyObject!, desiredAccuracy: CLLocationAccuracy, queue: dispatch_queue_t, handler:(location: CLLocation) -> ()) -> (success: Bool, error: NSError?) {
        if !isLocationMonitoringAvailable {
            return (false, NSError.errorWithDomain("com.NSExceptional.PKLocationManager", code: 0, userInfo: [NSLocalizedDescriptionKey : "Location monitoring unavailable." ]))
        }
        
        var presentMonitor = self.locationMonitorFor(monitoringObject)
        
        if presentMonitor {
            return (false, NSError.errorWithDomain("com.NSExceptional.PKLocationManager", code: 1, userInfo: [NSLocalizedDescriptionKey : "Object is already registered as a location monitor." ]))
        }
        
        var monitor = PKLocationMonitor(monitoringObject: monitoringObject, queue: queue, desiredAccuracy: desiredAccuracy, handler: handler)
        
        monitors.append(monitor)
        sharedLocationManager.desiredAccuracy = accuracy
        
        if monitors.count > 0 {
            sharedLocationManager.startUpdatingLocation()
        }
        
        return (true, nil)
    }
    
    /// Removes an object from the list of objects registered for location updates.
    func deregister(locationMonitor:AnyObject!) {
        monitors = monitors.filter { element in
            return element.monitoringObject !== locationMonitor;
        }
        
        sharedLocationManager.desiredAccuracy = accuracy
        
        if monitors.count == 0 {
            sharedLocationManager.stopUpdatingLocation()
        }
    }
    
    /// Determines whether location monitoring is currently active.
    var isLocationMonitoringActive: Bool {
        return monitors.count > 0
    }
    
    /// Determines whether location monitoring is available.
    var isLocationMonitoringAvailable: Bool {
        return CLLocationManager.locationServicesEnabled()
    }
    
    var _requiresLocationMonitoringWhenInUse: Bool = false
    
    /// If set to 'true' the user will be prompted by the system and asked to grant location access permissions while the application is in use (foreground). Please note that you will need to provide a value for the 'NSLocationWhenInUseUsageDescription' key in your application's 'Info.plist' file.
    var requiresLocationMonitoringWhenInUse: Bool {
        get {
            return _requiresLocationMonitoringWhenInUse
        }
        set (newValue) {
            if newValue {
                sharedLocationManager.requestWhenInUseAuthorization()
            }
        }
    }
    
    var _requiresLocationMonitoringAlways: Bool = false
    /// If set to 'true' the user will be prompted by the system and asked to grant location access permissions, which will also work if the application were to be in the background. Please note that you will need to provide a value for the 'NSLocationAlwaysUsageDescription' key in you application's 'Info.plist' file.
    var requiresLocationMonitoringAlways: Bool {
        get {
            return _requiresLocationMonitoringAlways
        }
        set (newValue) {
            if newValue {
                sharedLocationManager.requestAlwaysAuthorization()
            }
        }
    }
    
    /// Returns 'true' if the user denied location access permissions, 'false' otherwise.
    var isLocationMonitoringPermissionDenied: Bool {
        return CLLocationManager.authorizationStatus() == CLAuthorizationStatus.Denied
    }
    
    /// Returns 'true' if the user granted location access permissions while the application is in use (foreground), 'false' otherwise.
    var isLocationMonitoringPermittedWhenInUse: Bool {
        return CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse
    }
    
    /// Returns 'true' if the user granted location access permissions, independent of the application's state (foreground + background), 'false' otherwise.
    var isLocationMonitoringAlwaysPermitted: Bool {
        return CLLocationManager.authorizationStatus() == CLAuthorizationStatus.Authorized
    }
    
    /// Computes the accuracy for the location manager, which is equal to the most precise accuracy requested by one of the monitoring objects.
    var accuracy: CLLocationAccuracy {
        return monitors.reduce(kCLLocationAccuracyThreeKilometers) { current, next in
            return next.desiredAccuracy <= current ? next.desiredAccuracy : current
        }
    }
    
    /// Returns the monitor wrapper object for a given existing monitoring object.
    func locationMonitorFor(monitoringObject: AnyObject!) -> PKLocationMonitor? {
        for monitor in monitors {
            if monitor.monitoringObject === monitoringObject {
                return monitor
            }
        }
        
        return nil
    }
    
    // #MARK: CLLocationManagerDelegate
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: AnyObject[]!) {
        for location in locations as Array<CLLocation> {
            for monitor in monitors {
                monitor.handler?(location)
            }
        }
    }
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        var permissionGiven = status == CLAuthorizationStatus.Authorized || status == CLAuthorizationStatus.AuthorizedWhenInUse
        if permissionGiven && monitors.count > 0 {
            sharedLocationManager.startUpdatingLocation()
        }
    }

    // #MARK: Private

    struct Constants {
        static let sharedManager = PKLocationManager()
    }
    
    let sharedLocationManager = CLLocationManager()
    var monitors = PKLocationMonitor[]()
}
