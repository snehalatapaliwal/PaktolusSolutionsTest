//
//  LocationManager.swift
//  PaktolusSolutionsTest
//
//  Created by apple on 15/05/20.
//  Copyright © 2020 snehalata. All rights reserved.
//

import UIKit
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    static let SharedManager = LocationManager()
    
    private var locationManager = CLLocationManager()
    
    var currentLocation : CLLocation?
    var distance : Double?

    private override init () {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = kCLLocationAccuracyHundredMeters
        locationManager.requestAlwaysAuthorization()
    }
    
    func startLocationUpdate() {
        self.locationManager.startUpdatingLocation()
    }
    
    func stopLocationUpdate() {
        self.locationManager.stopUpdatingLocation()
    }

    // MARK: - CLLocationManagerDelegate
    
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        distance = oldLocation.distance(from: newLocation)
        currentLocation = newLocation
        self.stopLocationUpdate()
    }
    
}
