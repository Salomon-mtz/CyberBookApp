//
//  Historial.swift
//  PruebaTablasReto
//
//  Created by Usuario on 19/09/22.
//

import Foundation

struct Reservation{
    var titulo:String
    var fechaReserva:String
    var capacidad:Int
    var herramientas:String
}

extension Reservation {
    static func listaReservas()->[Reservation]{
        return([Reservation(titulo: "PacketTarcer", fechaReserva: "2022/10/01", capacidad: 15, herramientas: "💻"),
                Reservation(titulo: "Minitab", fechaReserva: "2022/11/13", capacidad: 10, herramientas: "🖥")])
        
        
    }
}
