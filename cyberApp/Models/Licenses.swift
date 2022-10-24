//
//  Licenses.swift
//  cyberApp
//
//  Created by Salomon Martinez on 29/09/22.
//

import Foundation

struct License: Codable{
    let id:Int
    var tipoSoft:String
    var caracteristicas:String
    var disponibleSoft:String
    
    init(id:Int, tipoSoft: String, caracteristicas:String, disponibleSoft: String){
        self.id = id
        self.tipoSoft = tipoSoft
        self.caracteristicas = caracteristicas
        self.disponibleSoft = disponibleSoft
    }
    init(tipoSoft: String, caracteristicas:String, disponibleSoft: String){
        self.id = 1403
        self.tipoSoft = tipoSoft
        self.caracteristicas = caracteristicas
        self.disponibleSoft = disponibleSoft
    }
}
typealias Licenses = [License]
