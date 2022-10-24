//
//  LoginViewController.swift
//  cyberApp
//
//  Created by Salomon Martinez on 22/09/22.
//

import UIKit


class LoginViewController: UIViewController {
    var AgreeIconClick : Bool! = false
    @IBOutlet weak var correoTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    struct logUser:Codable{
        var correo:String
        var contra:String
    }
    
    struct answer: Codable {
        var msg: String
        var id: Int?
    }
    
    let userListURL = "http://20.38.4.246:8080/getUsuariosApp"
    let userLog = "http://20.38.4.246:8080/LoginApp"
    
    
    func getTodosUsuarios() async throws->answer{
        let insertURL = URL(string: userListURL)!
        var request = URLRequest(url: insertURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(["email":correoTextField.text])
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
    
    func sendLoginData() async throws->answer{
        let insertURL = URL(string: userLog)!
        var request = URLRequest(url: insertURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(logUser(correo: correoTextField.text ?? " ", contra: passTextField.text ?? " "))
        request.httpBody = jsonData
        let s = String(data: jsonData!, encoding: .utf8)!
        print(s)
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { throw ReservaError.itemNotFound}
        
        let jsonDecoder = JSONDecoder()
        do{
            
            let reservas = try jsonDecoder.decode(answer.self, from: data)
            print(reservas.id ?? -1)
            return reservas
            
        }catch let jsonError as NSError{
            
            print("JSON decode failed: \(jsonError)")
            throw ReservaError.decodeError
        }
        
    }
    
    // iniciar sesión
    func home() {
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "main") as! UITabBarController
        
        nextViewController.modalPresentationStyle = .fullScreen
        // self es la vista 1, sobre ella presenta "siguienteVista"
        
        self.present(nextViewController, animated:true, completion:nil)
        
    }
    
    // función que cierra el teclado al apretar "intro"
    @IBAction func textFieldDoneEditing(sender:UITextField){
        sender.resignFirstResponder()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.bool(forKey: "isLogin") == true{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "main")
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: true)
        }
        else{
            let alert = UIAlertController(title: "Sesión terminada", message: "Favor de iniciar sesión", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler:  nil))
            
            self.present(alert, animated: true, completion: nil)
        }
        
    
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func makeLogin(_ sender: UIButton){
        
        sender.isUserInteractionEnabled = false
        
        if correoTextField.text == "" || passTextField.text == "" {
            
            let alert = UIAlertController(title: "Campos vacíos", message: "Favor de llenar todos los campos", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler:  nil))
            
            self.present(alert, animated: true, completion: nil)
            
            
        } else {
            
            Task{
                do{
                    let is_registered = try await getTodosUsuarios()
                    
                    print(is_registered.msg)
                    
                    if is_registered.msg == "registrado"{
                        Task{
                            do{
                                let is_logIn = try await sendLoginData()
                                
                                if is_logIn.msg == "Accesado"{
                                    
                                    appDelegate.user_id = is_logIn.id ?? -1
                                    print(is_logIn.id)
                                    UserDefaults.standard.set(true, forKey: "isLogin")
                                    
                                    home()
                                    
                                } else {
                                    let alert = UIAlertController(title: "Verifique sus datos", message: "Credenciales inválidas", preferredStyle: .alert)
                                    
                                    alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler:  nil))
                                    
                                    self.present(alert, animated: true, completion: nil)
                                }
                                
                            }catch let jsonError as NSError{
                                print("JSON decode failed: \(jsonError)")
                                let alert = UIAlertController(title: "Error de conexión", message: "No fue posible obtener la lista de usuarios", preferredStyle: .alert)
                                
                                alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler:  nil))
                                
                                self.present(alert, animated: true, completion: nil)            }
                        }
                        
                    } else {
                        let alert = UIAlertController(title: "Usuario no registrado", message: "Favor de registrarse", preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler:  nil))
                        
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                }catch let jsonError as NSError{
                    print("JSON decode failed: \(jsonError)")
                    let alert = UIAlertController(title: "Error de conexión", message: "No fue posible obtener la lista de usuarios", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler:  nil))
                    
                    self.present(alert, animated: true, completion: nil)            }
                
                sender.isUserInteractionEnabled = true
                
            }
        }
        
    }
}
