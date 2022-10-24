//
//  Historial.swift
//  PruebaTablasReto
//
//  Created by Usuario on 19/09/22.
//

import Foundation
import UIKit

let appDelegate2 = UIApplication.shared.delegate as! AppDelegate
struct Classroom: Codable{
    let id:Int
    var nombreEspacio:String
    var caracteristicas:String
    var disponibleEsp:String
    var capacidad:String
    
    init(id:Int, nombreEspacio:String, caracteristicas: String, disponibleEsp:String, capacidad: String){
        self.id = id
        self.nombreEspacio = nombreEspacio
        self.caracteristicas = caracteristicas
        self.disponibleEsp = disponibleEsp
        self.capacidad = capacidad
    }
    init(nombreEspacio:String, caracteristicas: String, disponibleEsp:String, capacidad: String){
        self.id = 1403
        self.nombreEspacio = nombreEspacio
        self.caracteristicas = caracteristicas
        self.disponibleEsp = disponibleEsp
        self.capacidad = capacidad
    }
}
typealias Classrooms = [Classroom]



/*
extension Classrooms {
    static func listaSalones()->[Classrooms]{
        return([Classrooms(titulo: "Salon 1301", fechaReserva: "", horario: "Hh:Mm", estatus: "disponible", capacidad: "15"),
                Classrooms(titulo: "Lab 1105", fechaReserva: "", horario: "Hh:Mm", estatus: "disponible", capacidad: "10"),
                Classrooms(titulo: "Sala 1202", fechaReserva: "", horario: "Hh:Mm", estatus: "disponible", capacidad: "20"),])
        
        
    }*/

