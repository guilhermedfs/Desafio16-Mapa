//
//  MapSwiftUIView.swift
//  Desafio16-Mapa
//
//  Created by Guilherme - ília on 13/01/22.
//

import SwiftUI
import MapKit

struct MapSwiftUIView: View {
    @State var mapRect = MKMapRect(x: 0, y: 0, width: 200, height: 200)
    var body: some View {
        Map(mapRect: $mapRect, showsUserLocation: true)
            .gesture(
            LongPressGesture(minimumDuration: 1)
            )
    }
}

struct MapSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        MapSwiftUIView()
    }
}
