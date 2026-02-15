//
//  boton_tic_tac.swift
//  PROYECTO_2
//
//  Created by Marco Dominguez on 11/02/26.
//

import SwiftUI

struct BotonTicTac: View {
    @State private var opcion_a_mostrar = 0 // 0 = vacio, 1 = X (jugador 1), 2 = O (jugador 2)
    @Binding var turno_actual: Int // 0: jugador X | 1: jugador O
    let opciones = ["-", "X", "O"]
    
    
    var body: some View {
        Text(opciones[opcion_a_mostrar])
            .padding(10)
            .font(Font.largeTitle)
            .bold()
            .frame(width: 80, height: 80) // hacerlo cuadrado
            .background(Color.yellow)
            .cornerRadius(8)
            .onTapGesture {
                if opcion_a_mostrar == 0 { // no se ha clickeado el boton
                    if turno_actual == 0 {
                        opcion_a_mostrar = 1 // pone X
                        turno_actual = 1
                    }
                    else {
                        opcion_a_mostrar = 2 // pone O
                        turno_actual = 0
                    }
                }
            }
    }
}

