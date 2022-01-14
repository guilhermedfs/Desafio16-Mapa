//
//  ButtonView.swift
//  Desafio16-Mapa
//
//  Created by Guilherme - ília on 14/01/22.
//

import SwiftUI

struct ButtonView: View {
    @Binding var traceRoute: Bool
    @Binding var shouldChange:Bool
    var body: some View {
        Button(action: {
            traceRoute.toggle()
        },
               label: {
            Image(systemName: "map.circle.fill")
                .resizable()
                .foregroundColor(.purple)
                .frame(width: 45, height: 45)
        })
            .padding(.bottom, 20)
    }
}
