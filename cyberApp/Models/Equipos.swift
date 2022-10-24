//
//  Equipos.swift
//  cyberApp
//
//  Created by Salomon Martinez on 05/10/22.
//

import Foundation

struct Equipo: Codable{
    let id:Int
    var tipoEq:String
    var caracteristicas:String
    var disponibleEq:String


    init(id:Int, tipoEq:String, caracteristicas:String, disponibleEq:String){
        self.id = id
        self.tipoEq = tipoEq
        self.caracteristicas = caracteristicas
        self.disponibleEq = disponibleEq
    }
    init(tipoEq:String, caracteristicas:String, disponibleEq:String){
        self.id = 1343
        self.tipoEq = tipoEq
        self.caracteristicas = caracteristicas
        self.disponibleEq = disponibleEq
    }
}
typealias Equipos = [Equipo]

