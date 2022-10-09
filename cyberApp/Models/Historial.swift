//
//  Historial.swift
//  PruebaTablasReto
//
//  Created by Usuario on 19/09/22.
//

import Foundation

struct Historial{
    var titulo:String
    var fechaReserva:String
    var estatus:String
    var codigo:String
}

extension Historial {
    static func listaReservas()->[Historial]{
        return([Historial(titulo: "PacketTarcer", fechaReserva: "2022/10/01", estatus: "Finalizado", codigo: "ABDT"),
               Historial(titulo: "Minitab", fechaReserva: "2022/11/13", estatus: "EnProceso", codigo: "DFRE")])
        
        
    }
}
