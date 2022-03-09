//
//  MapViewController.swift
//  Example2
//
//  Created by Gevorg Hovhannisyan on 24.12.21.
//

import UIKit
import MapKit
import AVFAudio
import CoreLocation

class MapViewController: UIViewController {
    
    private let map: MKMapView = {
        
        let map = MKMapView()
        return map
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(map)
        
        locationManager.shared.getUserLocation { [weak self] location in
            DispatchQueue.main.async {
                guard let stronSelf = self else {
                    return
                }
                stronSelf.addMapPin(whith: location)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        map.frame = view.bounds
    }
    
    func addMapPin(whith location: CLLocation){
        let pin = MKPointAnnotation()
        pin.coordinate = location.coordinate
        map.setRegion(MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.7,
                             longitudeDelta: 0.7)),
                             animated: true)
        map.addAnnotation(pin)
        
        locationManager.shared.resolveLocationName(with: location) { [weak self] locationName in
            self?.title = locationName
        }
    }
}
