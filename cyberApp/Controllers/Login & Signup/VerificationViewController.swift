//
//  VerificationViewController.swift
//  cyberApp
//
//  Created by Salomon Martinez on 06/10/22.
//

import UIKit

class VerificationViewController: UIViewController {

    var code2verify:Int = 0
    let sendEmail = "http://20.38.4.246:8080/enviarMail"
    let baseString = "http://20.38.4.246:8080/registrarUsApp"
    
    var email:String = " "
    
    var user:User = User(email: "", name: "", password: "12345", phone: "", school: "", rol: "")

    
    @IBOutlet weak var codeTextF: UITextField!
    
    struct answer: Codable {
        var msg: String
        var id: Int?
    }
    
    // Enviar correo con código --------------------------------------
    func enviarCorreo() async throws->answer{
        let insertURL = URL(string: sendEmail)!
        var request = URLRequest(url: insertURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(["email":email, "code":String(code2verify)])
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
    

    func insertUsuario(nuevousuario:User)async throws->answer{
        let insertURL = URL(string: baseString)!
        var request = URLRequest(url: insertURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(nuevousuario)
        request.httpBody = jsonData
        let s = String(data: jsonData!, encoding: .utf8)!
        print(s)
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { throw ReservaError.itemNotFound}
        
        let jsonDecoder = JSONDecoder()
        do{
            print(data)
            let reservas = try jsonDecoder.decode(answer.self, from: data)
            
            
            return reservas
            
        }catch let jsonError as NSError{
            
            print("JSON decode failed: \(jsonError)")
            throw ReservaError.decodeError
        }
    }
    
    
    // función que cierra el teclado al apretar "intro"
    @IBAction func textFieldDoneEditing(sender:UITextField){
        sender.resignFirstResponder()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func reenviarCodigo(_ sender: UIButton) {
        
        code2verify = Int.random(in: 100000..<999999)
        
        Task{
            do{
                let ans = try await enviarCorreo()
                
                if ans.msg == "Ended process"{
                    let alert = UIAlertController(title: "Correo enviado", message: "Verifique el código en su correo", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler:  nil))
                } else {
                    let alert = UIAlertController(title: "Intente de nuevo", message: "No fue posible enviar el correo", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler:  nil))
                }

                
            }catch{
                let alert = UIAlertController(title: "Intente de nuevo", message: "No se pudo crear el usuario", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler:  nil))
                
            }
        }
        
    }
    
    @IBAction func sendEmailButtonTapped(sender: AnyObject) {
        
        
        if String(code2verify) == codeTextF.text && codeTextF.text != ""{
            
            Task{
                do{
                    
                    
                    let response = try await insertUsuario(nuevousuario: user)
                    
                    appDelegate.user_id = response.id ?? -1
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "main")
                    vc.modalPresentationStyle = .overFullScreen
                    present(vc, animated: true)
                    
                }catch let jsonError as NSError{
                    print("JSON decode failed: \(jsonError)")
                    let alert = UIAlertController(title: "Error de conexión", message: "No fue posible obtener la lista de usuarios", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler:  nil))
                    
                    self.present(alert, animated: true, completion: nil)
                    
                }
            }
            

        } else {
            
            let alert = UIAlertController(title: "Verifique en su correo", message: "El código no corresponde", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler:  nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }

}
