//
//  ErrorLocationView.swift
//  Desafio16-Mapa
//
//  Created by Guilherme - ília on 14/01/22.
//

import SwiftUI

struct ErrorLocationView: View {
    var body: some View {
        ZStack(alignment: .top) {
            Color.red
                .ignoresSafeArea(.all  )
            VStack(alignment: .center, spacing: 20){
                Image(systemName: "location.slash.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.white)
                    .padding()
                VStack (spacing: 50){
                    Text("Permissão de localização")
                        .font(.title.bold())
                        .foregroundColor(.white)
                    Text("Para utilizar o app, é necessário permitir o uso da sua localização. Permita o uso nas configurações do seu aparelho para continuar com o uso do app.")
                        .font(.body)
                        .foregroundColor(.white)
                        .padding([.leading, .trailing])
                }
            }
        }
    }
}

struct ErrorLocationView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorLocationView()
    }
}
