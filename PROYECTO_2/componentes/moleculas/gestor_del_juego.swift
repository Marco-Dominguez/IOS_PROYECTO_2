//
//  gestor_del_juego.swift
//  PROYECTO_2
//
//  Created by Marco Dominguez on 15/02/26.
//

import SwiftUI
import Combine

/// gestor de la logica del juego, turnos, estado del tablero.
class GestorDelJuego: ObservableObject {
    @Published var tablero: [EstadosBoton] = Array(repeating: .vacio, count: 9)
    @Published var turnoActual: Jugador = .jugador1
    @Published var juegoTerminado: Bool = false
    @Published var resultadoFinal: ResultadoJuego?
    
    // configuraciones
    var nombreJugador1: String = "Jugador 1"
    var nombreJugador2: String = "CPU"
    var esModoDosJugadores: Bool = false
    
    // MARK: - Lógica del Juego
    
    /// cuando se toca una celda, recibe un indice que es la posicion del boton en el arreglo del tablero
    func procesarMovimiento(en indice: Int) {
        // validar que no este usado
        guard tablero[indice] == .vacio, !juegoTerminado else { return }
        
        // asignar estado X o O
        tablero[indice] = (turnoActual == .jugador1) ? .equis : .circulo
        
        // validar si el movimiento gana
        if verificarEstadoJuego() {
            return
        }
        
        // cambiar turno
        turnoActual = (turnoActual == .jugador1) ? .jugador2 : .jugador1
        
        // movimiento automtico en modo 1 jugador
        if !esModoDosJugadores && turnoActual == .jugador2 {
            realizarMovimientoCPU()
        }
    }
    
    /// se selecciona una casilla al azar
    private func realizarMovimientoCPU() {
        // retraso para que no sea instantaneo
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            guard let self = self, !self.juegoTerminado else { return }
            
            // obtener botones sin usar
            let indicesVacios = self.tablero.indices.filter { self.tablero[$0] == .vacio }
            
            if let indiceAleatorio = indicesVacios.randomElement() {
                self.procesarMovimiento(en: indiceAleatorio)
            }
        }
    }
    
    /// valida si alguien gano o si el tablero esta lleno.
    private func verificarEstadoJuego() -> Bool {
        // combinaciones ganadoras
        let patrones = [
            [0, 1, 2], [3, 4, 5], [6, 7, 8], // filas
            [0, 3, 6], [1, 4, 7], [2, 5, 8], // columnas
            [0, 4, 8], [2, 4, 6]             // diagonales
        ]
        
        // valida si algun patron coincide
        for patron in patrones {
            let (a, b, c) = (patron[0], patron[1], patron[2])
            let celdaA = tablero[a]
            
            if celdaA != .vacio && celdaA == tablero[b] && celdaA == tablero[c] {
                finalizarJuego(ganador: celdaA == .equis ? .jugador1 : .jugador2)
                return true
            }
        }
        
        // valida si hay empate
        if !tablero.contains(.vacio) {
            finalizarJuego(ganador: nil)
            return true
        }
        
        return false
    }
    
    /// termina el juego
    private func finalizarJuego(ganador: Jugador?) {
        let nombreGanador: String
        
        if let ganador = ganador {
            nombreGanador = (ganador == .jugador1) ? nombreJugador1 : nombreJugador2
            resultadoFinal = ResultadoJuego(mensaje: "¡Ganó \(nombreGanador)!", ganador: ganador)
        } else {
            resultadoFinal = ResultadoJuego(mensaje: "¡Juego Terminado! Empate.", ganador: nil)
        }
        
        juegoTerminado = true
    }
    
    /// reinicia el tablero
    func reiniciarJuego() {
        tablero = Array(repeating: .vacio, count: 9)
        turnoActual = .jugador1
        juegoTerminado = false
        resultadoFinal = nil
    }
}
