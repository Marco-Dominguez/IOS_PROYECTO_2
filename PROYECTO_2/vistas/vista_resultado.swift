//
//  vista_resultado.swift
//  PROYECTO_2
//
//  Created by Marco Dominguez on 15/02/26.
//

import SwiftUI

/// vista de resultados
struct VistaResultado: View {
    let resultado: ResultadoJuego
    var accionReiniciar: () -> Void
    var accionMenu: () -> Void
    
    var body: some View {
        VStack(spacing: 30) {
            Text("🎮")
                .font(.system(size: 80))
            
            Text(resultado.mensaje)
                .font(.largeTitle)
                .bold()
                .multilineTextAlignment(.center)
                .padding()
            
            // boton para volver a jugar
            Button(action: accionReiniciar) {
                Label("Volver a Jugar", systemImage: "arrow.clockwise")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 40)
            
            // boton para voler al inicio
            Button(action: accionMenu) {
                Label("Ir al Inicio", systemImage: "house.fill")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .foregroundColor(.primary)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 40)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    VistaResultado(
        resultado: ResultadoJuego(mensaje: "Ganó Jugador 1", ganador: .jugador1),
        accionReiniciar: {},
        accionMenu: {}
    )
}
