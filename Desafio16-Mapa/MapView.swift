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
    
    var body: some View {
        Map(coordinateRegion: $manager.region, showsUserLocation: true, userTrackingMode: $tracking)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
