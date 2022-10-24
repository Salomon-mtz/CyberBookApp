//
//  HomeViewController.swift
//  cyberApp
//
//  Created by Salomon Martinez on 08/10/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()

  
        // Do any additional setup after loading the view.
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
    
    @IBAction func logoutFunc(_ sender: Any) {
        Task{
            do{
                let is_logIn = try await logout()
                
                let storyboard = UIStoryboard(name:"Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "start") as UIViewController
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated:true, completion:nil)
                
            }catch let jsonError as NSError{
                print("JSON decode failed: \(jsonError)")
                let alert = UIAlertController(title: "Error de conexión", message: "No fue posible obtener la lista de usuarios", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler:  nil))
                
                self.present(alert, animated: true, completion: nil)            }
        }
    }
}
