//
//  BottomSheet.swift
//  Desafio16-Mapa
//
//  Created by Guilherme - ília on 13/01/22.
//

import SwiftUI

struct BottomSheet: View {
    @Binding var adress: PlaceDetails
    
    var body: some View {
        ZStack {
            Color.purple
                .ignoresSafeArea(.all)
            VStack(spacing: 30) {
                VStack(alignment: .center) {
                    Text("Dados do endereço")
                        .font(.largeTitle.bold())
                        .padding(.top, 25)
                        .foregroundColor(.white)
                }
                VStack (alignment: .leading, spacing: 10) {
                    Group {
                        Text("Endereço: ")
                            .bold()
                        + Text(adress.name)
                        Text("Cidade: ")
                            .bold()
                        + Text(adress.locality)
                        Text("Estado: ")
                            .bold()
                        + Text(adress.region)
                        Text("País: ")
                            .bold()
                        + Text(adress.country)
                    }
                    .lineLimit(2)
                    .foregroundColor(.white)
                    .font(.body)
                }
                .padding()
                Spacer()
            }
        }
    }
}

//struct BottomSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        BottomSheet(adress: "")
//    }
//}
