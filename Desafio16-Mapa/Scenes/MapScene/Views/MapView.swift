//
//  MapView.swift
//  Desafio16-Mapa
//
//  Created by Guilherme - ília on 12/01/22.
//

import SwiftUI
import MapKit

struct MapView: View {
    @StateObject var manager: LocationManager
    @State private var traceRoute = false
    @State private var adress = PlaceDetails(name: "", region: "", country: "", locality: " ")
    @State private var pinSelected = false
    @StateObject var viewModel: MapViewModel
    
    var body: some View {
        ZStack(alignment: .bottom) {
            MapUIView(location: $manager.region, adress: $adress, pressed: $traceRoute, pinSelected: $pinSelected, viewModel: viewModel)
            //                    .ignoresSafeArea(.bottom)
            if viewModel.shouldChange {
                ButtonView(traceRoute: $traceRoute, shouldChange: $viewModel.shouldChange)
            }
        }
        .popover(isPresented: $pinSelected, arrowEdge: .top, content: {
            BottomSheet(adress: $adress)
        })
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(manager: LocationManager(), viewModel: MapViewModel())
    }
}

