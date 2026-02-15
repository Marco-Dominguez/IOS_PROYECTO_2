//
//  vista_inicio.swift
//  PROYECTO_2
//
//  Created by Marco Dominguez on 15/02/26.
//

import SwiftUI

/// vista de inicio
struct VistaInicio: View {
    @State private var nombreJ1: String = ""
    @State private var nombreJ2: String = ""
    @State private var esModoDosJugadores: Bool = false
    @State private var irAlJuego: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                
                // titulo
                Text("Tic Tac Toe")
                    .font(.system(size: 40, weight: .heavy, design: .rounded))
                    .foregroundColor(.yellow)
                    .shadow(radius: 2)
                
                VStack(alignment: .leading, spacing: 15) {
                    
                    Text("Configuración")
                        .font(.headline)
                    
                    // nombre del jugador 1
                    TextField("Nombre Jugador 1", text: $nombreJ1)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.blue, lineWidth: 1)
                        )
                    
                    // nombre del jugador 2
                    if esModoDosJugadores {
                        TextField("Nombre Jugador 2", text: $nombreJ2)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.red, lineWidth: 1)
                            )
                            .transition(.opacity.combined(with: .move(edge: .top)))
                    }
                    
                    // switch del modo de juego
                    Toggle(isOn: $esModoDosJugadores) {
                        Text("Modo 2 Jugadores")
                            .bold()
                    }
                    .padding()
                    .background(Color.gray.opacity(0.05))
                    .cornerRadius(8)
                }
                .padding()
                .animation(.easeInOut, value: esModoDosJugadores)
                
                Spacer()
                
                // comenzar el juego
                Button(action: {
                    // validaciones por si se dejan vacios los nombres
                    if nombreJ1.isEmpty { nombreJ1 = "Jugador 1" }
                    if !esModoDosJugadores && nombreJ2.isEmpty { nombreJ2 = "CPU" }
                    if esModoDosJugadores && nombreJ2.isEmpty { nombreJ2 = "Jugador 2" }
                    irAlJuego = true
                }) {
                    Text("Comenzar Juego")
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.horizontal)
                .navigationDestination(isPresented: $irAlJuego) {
                    VistaJuegoGato(
                        nombreJugador1: nombreJ1,
                        nombreJugador2: nombreJ2,
                        esModoDosJugadores: esModoDosJugadores,
                        juegoActivo: $irAlJuego
                    )
                }
            }
            .padding()
        }
    }
}

#Preview {
    VistaInicio()
}
