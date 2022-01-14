//
//  LocationManager.swift
//  Desafio16-Mapa
//
//  Created by Guilherme - ília on 12/01/22.
//

import CoreLocation
import MapKit
import SwiftUI


class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    @Published var region = MKCoordinateRegion()
    private let manager = CLLocationManager()
    @Published var deniedAuthorization = true
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        
        if status == .denied {
            deniedAuthorization = true
        } else {
            deniedAuthorization = false
        }
        
        if !deniedAuthorization {
            
            guard let coordinate = manager.location?.coordinate else {return}
        
            region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        }
    }
}

