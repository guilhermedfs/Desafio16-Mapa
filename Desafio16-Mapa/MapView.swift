//
//  MapView.swift
//  Desafio16-Mapa
//
//  Created by Guilherme - ília on 12/01/22.
//

import SwiftUI
import MapKit

struct MapView: View {
    @StateObject var manager = LocationManager()
    @State var tracking: MapUserTrackingMode = .follow
    let MapLocations = [
            MapLocation(name: "St Francis Memorial Hospital", latitude: 37.789467, longitude: -122.416772),
            MapLocation(name: "The Ritz-Carlton, San Francisco", latitude: 37.791965, longitude: -122.406903),
            MapLocation(name: "Honey Honey Cafe & Crepery", latitude: 37.787891, longitude: -122.411223)
            ]
    
    var body: some View {
        Map(coordinateRegion: $manager.region, showsUserLocation: true, userTrackingMode: $tracking, annotationItems: MapLocations) { location in
            MapAnnotation(coordinate: location.coordinate) {
                Image(systemName: "pin.circle.fill")
                    .foregroundColor(.red)
                    .onTapGesture {
                        
                    }
            }
        }
        .onTapGesture {
            
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
