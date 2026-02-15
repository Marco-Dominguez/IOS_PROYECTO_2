//
//  vista_juego_gato.swift
//  PROYECTO_2
//
//  Created by Marco Dominguez on 15/02/26.
//

import SwiftUI

/// vista del juego
struct VistaJuegoGato: View {
    @StateObject var gestorDelJuego = GestorDelJuego()
    
    // variables de vista de inicio
    let nombreJugador1: String
    let nombreJugador2: String
    let esModoDosJugadores: Bool
    
    // control para navegacion
    @Binding var juegoActivo: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            
            // turno
            VStack {
                Text("Turno de:")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                Text(gestorDelJuego.turnoActual == .jugador1 ? nombreJugador1 : nombreJugador2)
                    .font(.title)
                    .bold()
                    .foregroundColor(gestorDelJuego.turnoActual == .jugador1 ? .blue : .red)
            }
            .padding(.top)
            
            Spacer()
            
            // tablero
            VStack(spacing: 15) {
                ForEach(0..<3) { fila in
                    HStack(spacing: 15) {
                        ForEach(0..<3) { columna in
                            let indice = fila * 3 + columna
                            BotonTicTac(
                                estado: gestorDelJuego.tablero[indice],
                                accion: {
                                    gestorDelJuego.procesarMovimiento(en: indice)
                                }
                            )
                        }
                    }
                }
            }
            
            Spacer()
        }
        .padding()
        .onAppear {
            gestorDelJuego.nombreJugador1 = nombreJugador1
            gestorDelJuego.nombreJugador2 = esModoDosJugadores ? nombreJugador2 : "CPU"
            gestorDelJuego.esModoDosJugadores = esModoDosJugadores
        }
        // ir a vista de resultados
        .navigationDestination(isPresented: $gestorDelJuego.juegoTerminado) {
            if let resultado = gestorDelJuego.resultadoFinal {
                VistaResultado(
                    resultado: resultado,
                    accionReiniciar: {
                        gestorDelJuego.reiniciarJuego()
                    },
                    accionMenu: {
                        juegoActivo = false
                    }
                )
            }
        }
        .navigationTitle("Tic Tac Toe")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        VistaJuegoGato(
            nombreJugador1: "Demo",
            nombreJugador2: "CPU",
            esModoDosJugadores: false,
            juegoActivo: .constant(true)
        )
    }
}
