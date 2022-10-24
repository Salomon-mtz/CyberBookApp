//
//  ClassroomController.swift
//  cyberApp
//
//  Created by Salomon Martinez on 04/10/22.
//

import Foundation
import UIKit

enum ReservaError: Error, LocalizedError{
    case itemNotFound
    case decodeError
}
class ReservaController{
    
    let baseString = "http://20.38.4.246:8080/api/reservaUser/"
    
    /*
    func fetchReservas() async throws->Reservas{
        let reservasURL = URL(string: baseString + "?format=json")!
        let (data, response) = try await URLSession.shared.data(from: reservasURL)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw ClassroomError.itemNotFound
        }
        let jsonDecoder = JSONDecoder()
        let reservas = try? jsonDecoder.decode(Reservas.self, from: data)
        return reservas!
        
    }*/
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // Obtener todas las reservas
    func fetchReservas() async throws->Reservas{
        let id = String(await appDelegate.user_id)
        print(id)
        let urlString = "http://20.38.4.246:8080/resvSp?user_id=\(id)"
        print(urlString)
        
        let baseURL = URL(string: urlString)!
        
        let (data, response) = try await URLSession.shared.data(from: baseURL)

        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
        
            throw ReservaError.itemNotFound
        }
        let jsonDecoder = JSONDecoder()
        do{
            print(data)
            let reservas = try jsonDecoder.decode(Reservas.self, from: data)
            
            return reservas
        }catch let jsonError as NSError{
            print("JSON decode failed: \(jsonError)")
            throw ReservaError.decodeError
        }
        
    }
    
    
    func deleteReserva(registroID:Int) async throws -> Void{
        let deleteString = baseString + String(registroID) + "/"
        let deleteURL = URL(string: deleteString)!
        var request = URLRequest(url: deleteURL)
        request.httpMethod = "DELETE"
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 204 else { throw ReservaError.itemNotFound}
    }
   
    func insertReserva(nuevareserva:Reserva)async throws->Void{
        let insertURL = URL(string: baseString)!
        var request = URLRequest(url: insertURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(nuevareserva)
        
        print(nuevareserva)
        request.httpBody = jsonData
        // Imprimir el cuerpo del JSON
        let s = String(data: jsonData!, encoding: .utf8)!
        print(s)
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 else { throw ReservaError.itemNotFound}
    }
    
    func updateReserva(updateReserva:Reserva) async throws{
        let id = String(await appDelegate.user_id)
        let updateString = "http://20.38.4.246:8080/resvSp?user_id=\(id)"
        let updateURL = URL(string: updateString)!
        var request = URLRequest(url: updateURL)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(updateReserva)
        request.httpBody = jsonData
        let s = String(data: jsonData!, encoding: .utf8)!
        print("json")
        print(s)
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { throw ReservaError.itemNotFound}
    }
    
    
}
