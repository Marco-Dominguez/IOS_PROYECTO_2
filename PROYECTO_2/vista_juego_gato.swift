//
//  vista_juego_gato.swift
//  PROYECTO_2
//
//  Created by Marco Dominguez on 11/02/26.
//

import SwiftUI

struct VistaJuegoGato: View {
    @State private var turno_actual = 0
    var body: some View {
        
        VStack(spacing: 20){
            Text("Turno Actual: \(turno_actual == 0 ? "X" : "O")")
                .font(.title)
                .bold()
            
            HStack(spacing: 20){
                BotonTicTac(turno_actual: $turno_actual)
                BotonTicTac(turno_actual: $turno_actual)
                BotonTicTac(turno_actual: $turno_actual)
            }
            
            HStack(spacing: 20){
                BotonTicTac(turno_actual: $turno_actual)
                BotonTicTac(turno_actual: $turno_actual)
                BotonTicTac(turno_actual: $turno_actual)
            }
            
            HStack(spacing: 20){
                BotonTicTac(turno_actual: $turno_actual)
                BotonTicTac(turno_actual: $turno_actual)
                BotonTicTac(turno_actual: $turno_actual)
            }
        }
    }
}

#Preview {
    VistaJuegoGato()
}
