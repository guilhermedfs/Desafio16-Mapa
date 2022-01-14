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
    init() {
        let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.5)
            UINavigationBar.appearance().standardAppearance = appearance
    }
    var body: some View {
        if !auth.deniedAuthorization {
            NavigationView {
                MapView(manager: auth, viewModel: model)
                
                    .navigationTitle("Map Direction")
                    .navigationBarTitleDisplayMode(.inline)
            }
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
