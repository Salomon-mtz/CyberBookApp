//
//  Historial.swift
//  PruebaTablasReto
//
//  Created by Usuario on 19/09/22.
//

import Foundation
import UIKit

let appDelegate = UIApplication.shared.delegate as! AppDelegate
struct Reserva: Codable{
    let id:Int
    var user_id:Int
    var fecha: String
    var tipoRes:String
    var estatus:String
    var tiempoRes:String
    var codigo:String
    var idServicio:String
    var hora:String

    init(fecha:String, tipoRes:String, estatus:String, tiempoRes:String, codigo:String, idServicio:String, hora:String){
        self.id = 1234
        self.user_id = appDelegate.user_id
        self.fecha = fecha
        self.tipoRes = tipoRes
        self.estatus = estatus
        self.tiempoRes = tiempoRes
        self.codigo = codigo
        self.idServicio = idServicio
        self.hora = hora
    }
}
typealias Reservas = [Reserva]



/*
extension Classrooms {
    static func listaSalones()->[Classrooms]{
        return([Classrooms(titulo: "Salon 1301", fechaReserva: "", horario: "Hh:Mm", estatus: "disponible", capacidad: "15"),
                Classrooms(titulo: "Lab 1105", fechaReserva: "", horario: "Hh:Mm", estatus: "disponible", capacidad: "10"),
                Classrooms(titulo: "Sala 1202", fechaReserva: "", horario: "Hh:Mm", estatus: "disponible", capacidad: "20"),])
        
        
    }*/

