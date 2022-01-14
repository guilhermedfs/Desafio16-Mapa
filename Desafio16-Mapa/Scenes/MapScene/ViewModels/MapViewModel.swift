//
//  MapViewModel.swift
//  Desafio16-Mapa
//
//  Created by Guilherme - ília on 14/01/22.
//

import Foundation
import CoreLocation

class MapViewModel: ObservableObject {
    @Published var shouldChange: Bool = false
    var destinationCoordinate = CLLocationCoordinate2D()
    var originCoordinate = CLLocationCoordinate2D()
}
