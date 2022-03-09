//
//  ManagerLocation.swift
//  Example2
//
//  Created by Gevorg Hovhannisyan on 24.12.21.
//

import Foundation
import CoreLocation

class locationManager: NSObject, CLLocationManagerDelegate {
    
    static let shared = Example2.locationManager()
    
    let manager = CLLocationManager()
    
    var complation: ((CLLocation) -> Void)?
    
    public func getUserLocation(complation: @escaping ((CLLocation) -> Void)) {
        self.complation = complation
        manager.startUpdatingLocation()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
    }
    
    public func resolveLocationName(with location: CLLocation, complation: @escaping ((String?) -> Void)){
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location, preferredLocale: .current) { placemarks, error in
            guard let place = placemarks?.first, error == nil else {
                complation(nil)
                return
            }
            
            print(place)
            var name = ""
            
            if let locality = place.locality {
                name += locality
            }
            if let adminRegion = place.administrativeArea {
                name += "\(adminRegion)"
            }
            complation(name)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        complation?(location)
        manager.startUpdatingLocation()
    }
}
