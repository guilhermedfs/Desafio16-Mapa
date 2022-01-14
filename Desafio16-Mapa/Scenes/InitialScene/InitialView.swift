//
//  ContentView.swift
//  Desafio16-Mapa
//
//  Created by Guilherme - ília on 12/01/22.
//

import SwiftUI
import MapKit

struct InitialView: View {
    @StateObject var auth = LocationManager()
    @StateObject var model = MapViewModel()
    var body: some View {
        if !auth.deniedAuthorization {
            MapView(manager: auth, viewModel: model)
        } else {
            ErrorLocationView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        InitialView()
    }
}
