//
//  PerfilViewController.swift
//  cyberApp
//
//  Created by Salomon Martinez on 13/10/22.
//

import UIKit

class PerfilViewController: UIViewController {

    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var numero: UILabel!
    @IBOutlet weak var escuela: UILabel!
    @IBOutlet weak var rol: UILabel!
    @IBOutlet weak var espacios: UILabel!
    @IBOutlet weak var equipos: UILabel!
    @IBOutlet weak var licencias: UILabel!
    
    // Sacar el id del usuario como appDelegate.user_id
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // Estructura para guardar el nombre del usuario
    struct UserData:Codable {
        var name: String
        var email: String
        var phone: String
        var school: String
        var rol: String
    }
    
     // Obtener el usuario
     func fetchUsuario() async throws->UserData{
         
         let urlString = "http://20.38.4.246:8080/getData?id=\(await appDelegate.user_id)"
         print(urlString)
         let baseURL = URL(string: urlString)!
         
         let (data, response) = try await URLSession.shared.data(from: baseURL)

         guard let httpResponse = response as? HTTPURLResponse,
               httpResponse.statusCode == 200 else {
         
             throw ReservaError.itemNotFound
         }
         let jsonDecoder = JSONDecoder()
         do{
         
             let usuarioData = try jsonDecoder.decode(UserData.self, from: data)
             print(usuarioData)
             return usuarioData
         }catch let jsonError as NSError{
             print("JSON decode failed: \(jsonError)")
             throw ReservaError.decodeError
         }
         
     }
    
    struct UserStats:Codable {
        var espacios: Int
        var equipos: Int
        var licencias: Int
    }
    
     // Obtener el usuario
     func fetchStats() async throws->UserStats{
         
         let urlString = "http://20.38.4.246:8080/getStats?user_id=\(await appDelegate.user_id)"
         print(urlString)
         let baseURL = URL(string: urlString)!
         
         let (data, response) = try await URLSession.shared.data(from: baseURL)

         guard let httpResponse = response as? HTTPURLResponse,
               httpResponse.statusCode == 200 else {
         
             throw ReservaError.itemNotFound
         }
         let jsonDecoder = JSONDecoder()
         do{
         
             let usuarioStats = try jsonDecoder.decode(UserStats.self, from: data)
             print(usuarioStats)
             return usuarioStats
         }catch let jsonError as NSError{
             print("JSON decode failed: \(jsonError)")
             throw ReservaError.decodeError
         }
         
     }

let userLog = "http://20.38.4.246:8080/logoutApp"

struct answer: Codable {
    var msg: String
    var id: Int?
}

func logout() async throws->answer{
    let insertURL = URL(string: userLog)!
    var request = URLRequest(url: insertURL)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    let jsonEncoder = JSONEncoder()
    let jsonData = try? jsonEncoder.encode(["id": appDelegate.user_id])
    request.httpBody = jsonData
    let s = String(data: jsonData!, encoding: .utf8)!
    print("json")
    print(s)
    let (data, response) = try await URLSession.shared.data(for: request)

    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { throw ReservaError.itemNotFound}
    
    let jsonDecoder = JSONDecoder()
    do{
    
        let reservas = try jsonDecoder.decode(answer.self, from: data)
        
        return reservas
        
    }catch let jsonError as NSError{
        
        print("JSON decode failed: \(jsonError)")
        throw ReservaError.decodeError
    }
    
}

override func viewDidLoad() {
    
    Task {
        do {
            let usuario = try await fetchUsuario()
            
            userName.text = usuario.name
            email.text = usuario.email
            numero.text = usuario.phone
            escuela.text = usuario.school
            rol.text = usuario.rol
            
            let stats = try await fetchStats()
            
            espacios.text = String(stats.espacios)
            equipos.text = String(stats.equipos)
            licencias.text = String(stats.licencias)
            
            
        } catch {
            print(error)
        }
    }
    
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    

}


@IBAction func logoutFunc(_ sender: Any) {
    Task{
        do{
            let is_logIn = try await logout()
            UserDefaults.standard.set(false, forKey: "isLogin")
            
            
            let storyboard = UIStoryboard(name:"Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "start") as UIViewController
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated:true, completion:nil)
            
            
        }catch let jsonError as NSError{
            print("JSON decode failed: \(jsonError)")
            let alert = UIAlertController(title: "Error de conexión", message: "No se pudo cerrar sesión", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler:  nil))
            
            self.present(alert, animated: true, completion: nil)            }
    }
}


/*
// MARK: - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destination.
    // Pass the selected object to the new view controller.
}
*/

}
