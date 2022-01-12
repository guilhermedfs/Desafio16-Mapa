//
//  MapLocation.swift
//  Desafio16-Mapa
//
//  Created by Guilherme - ília on 12/01/22.
//

import UIKit
import CoreLocation

struct MapLocation: Identifiable {
    let id = UUID()
    let name: String
    let latitude: Double
    let longitude: Double
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
