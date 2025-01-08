//
//  LocationManager.swift
//  UVGTour
//
//  Created by Guillermo Santos Barrios on 8/31/24.
//

import Foundation
import CoreLocation
import Combine

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    @Published var degrees: Double = 0
    
    override init() {
        super.init()
        manager.delegate = self
        manager.startUpdatingHeading()
        manager.requestWhenInUseAuthorization()
    }
    
    // MARK: Conforming to protocol
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        degrees = newHeading.trueHeading
    }
    
}
