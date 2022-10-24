//
//  User.swift
//  cyberApp
//
//  Created by Salomon Martinez on 30/09/22.
//

import Foundation
struct User: Codable{
    let id:Int
    var email:String
    var name:String
    var password:String
    var phone:String
    var school:String
    var rol:String
    init(id:Int, email:String, name: String, password:String, phone:String, school:String, rol:String){
        self.id = id
        self.email = email
        self.name = name
        self.password = password
        self.phone = phone
        self.school = school
        self.rol = rol
    }
    init(email:String, name: String, password:String, phone:String, school:String, rol:String){
        self.id = 2222
        self.email = email
        self.name = name
        self.password = password
        self.phone = phone
        self.school = school
        self.rol = rol
    }
}
typealias Users = [User]
