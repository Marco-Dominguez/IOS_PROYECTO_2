//
//  boton_tic_tac.swift
//  PROYECTO_2
//
//  Created by Marco Dominguez on 15/02/26.
//

import SwiftUI

/// boton X O -
struct BotonTicTac: View {
    let estado: EstadosBoton
    let accion: () -> Void
    
    var body: some View {
        Button(action: accion) {
            Text(estado.rawValue)
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(obtenerColor())
                .frame(width: 80, height: 80)
                .background(Color.yellow.opacity(0.3))
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.yellow, lineWidth: 2)
                )
        }
        .disabled(estado != .vacio) // deshabilitar si ya esta usado
    }
    
    /// retorna "X" azul, "O" rojo o "-" gris
    private func obtenerColor() -> Color {
        switch estado {
        case .vacio: return .gray
        case .equis: return .blue
        case .circulo: return .red
        }
    }
}

#Preview {
    HStack {
        BotonTicTac(estado: .equis, accion: {})
        BotonTicTac(estado: .circulo, accion: {})
        BotonTicTac(estado: .vacio, accion: {})
    }
}
