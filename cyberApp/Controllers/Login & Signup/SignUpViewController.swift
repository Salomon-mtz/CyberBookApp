//
//  SignUpViewController.swift
//  cyberApp
//
//  Created by Salomon Martinez on 22/09/22.
//

import UIKit

class SignUpViewController: UIViewController {

    let baseString = "http://20.38.4.246:8080/registrarUsApp"
        let userListURL = "http://20.38.4.246:8080/getUsuariosApp"
        let sendEmail = "http://20.38.4.246:8080/enviarMail"
        
        let code:Int = Int.random(in: 100000..<999999)
        
        struct answer: Codable {
            var msg: String
        }
        
        // Outlet del ScrollView
        
        @IBOutlet weak var nombre_U: UITextField!
        @IBOutlet weak var correo_U: UITextField!
        @IBOutlet weak var password_U2: UITextField!
        @IBOutlet weak var password_U: UITextField!
        @IBOutlet weak var phone: UITextField!
        @IBOutlet weak var school: UITextField!
        @IBOutlet weak var rol: UITextField!
        @IBOutlet weak var aceptaPoliticas: UISwitch!
        
        var is_validPass:Bool = false
        var is_passMatch:Bool = false
        var is_validTel:Bool = false
        var is_regEmail:Bool = false
        
        struct emailCheck: Codable {
            var msg: String
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()

            // Do any additional setup after loading the view.
            
        }
        
        func emailPattern()->Bool{
            let pat = "^[a-zA-Z0-9]+(?:[.][a-zA-Z0-9]+)*@[a-zA-Z0-9]+(?:[.][a-zA-Z0-9]+)*$"
            
            if (correo_U.text?.range(of: pat, options: .regularExpression) == nil){
                
                return false
                
            } else {
                
                return true
            }
            
        }
        
        func enviarCorreo() async throws->answer{
            let insertURL = URL(string: sendEmail)!
            var request = URLRequest(url: insertURL)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let jsonEncoder = JSONEncoder()
            let jsonData = try? jsonEncoder.encode(["email":correo_U.text, "code":String(code)])
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
        
        
        func getTodosUsuarios() async throws->emailCheck{
            let insertURL = URL(string: userListURL)!
            var request = URLRequest(url: insertURL)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let jsonEncoder = JSONEncoder()
            let jsonData = try? jsonEncoder.encode(["email":correo_U.text])
            request.httpBody = jsonData
            let (data, response) = try await URLSession.shared.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { throw ReservaError.itemNotFound}
            
            let jsonDecoder = JSONDecoder()
            do{
            
                let reservas = try jsonDecoder.decode(emailCheck.self, from: data)
                
                return reservas
                
            }catch let jsonError as NSError{
                
                print("JSON decode failed: \(jsonError)")
                throw ReservaError.decodeError
            }
            
        }
        

        
        
        func verifyEmail() {
            
            Task{
                do{
                    let is_registered = try await getTodosUsuarios()
                    
                    if is_registered.msg == "registrado"{
                        is_regEmail = true
                    } else {
                        is_regEmail = false
                    }
                    
                }catch let jsonError as NSError{
                    print("JSON decode failed: \(jsonError)")
                    let alert = UIAlertController(title: "Error de conexión", message: "No fue posible obtener la lista de usuarios", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler:  nil))
                    
                    self.present(alert, animated: true, completion: nil)            }
            }
            
        }
        
         func verificaPassword() {
             
            let validPass = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?¿!¡@$ %^&*-_]).{10,}$"
            
            if(password_U.text?.range(of: validPass, options: .regularExpression) == nil){
        
                is_validPass = false
                
            } else {
                is_validPass = true
            }
            
            
        }
        
        func checkMatchingPass(){
            
            if(password_U.text != password_U2.text){
                let alert = UIAlertController(title: "Verifique las contraseñas", message: "Las contraseñas no coiniciden", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler:  nil))
                
                self.present(alert, animated: true, completion: nil)
                    is_passMatch = false

            } else {
                is_passMatch = true
            }
        }
        
        
        @IBAction func checkEmailTextField(_ sender: UITextField) {
            verifyEmail()
        }
        
        // Verificación de campos
        
        @IBAction func verificarYmandar(_ sender: UIButton) {
            
            verifyEmail()
            verificaPassword()
            checkMatchingPass()
            
            if(nombre_U.text == "" ||
               correo_U.text == "" ||
               password_U.text == "" ||
               password_U2.text == "" ||
               phone.text == "" ||
               school.text == "" ||
               rol.text == "" ){
                
                let alert = UIAlertController(title: "Campos vacíos", message: "Es necesario llenar todos los campos", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler:  nil))
                
                self.present(alert, animated: true, completion: nil)
                
                
            }  else if (!is_passMatch){
                let alert = UIAlertController(title: "Verifique las contraseñas", message: "Las contraseñas no coiniciden", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler:  nil))
                
                self.present(alert, animated: true, completion: nil)
            }  else if (!is_validPass){
                let alert = UIAlertController(title: "Verifique su contraseña", message: "Debe tener por lo menos 10 caracteres de longitud, incluir 1 mayúscula, 1 minúscula, 1 número y un caracter especial (#?¿!¡@$ %^&*-_)", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler:  nil))
                
                self.present(alert, animated: true, completion: nil)
                
            } else if is_regEmail{
                let alert = UIAlertController(title: "Correo ya registrado", message: "Favor de iniciar sesión", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler:  nil))
                
                self.present(alert, animated: true, completion: nil)
            } else if !emailPattern(){
                let alert = UIAlertController(title: "Correo inválido", message: "Revise la dirección de correo", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler:  nil))
                
                self.present(alert, animated: true, completion: nil)
            }else if (!aceptaPoliticas.isOn){
                let alert = UIAlertController(title: "Términos y condiciones", message: "Favor de aceptar los términos y condiciones", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler:  nil))
                
                self.present(alert, animated: true, completion: nil)
            } else {
                // registrar usuario
                let newUser = User(email: correo_U.text ?? "no@no.com", name: nombre_U.text ?? "no",password: password_U.text ?? "12345", phone: phone.text ?? "4325332352", school: school.text ?? "tec", rol: rol.text ?? "Estudiante")
                

                Task{
                    do{
                        let ans = try await enviarCorreo()
                        
                        if ans.msg == "Ended process"{
                            let storyboard = UIStoryboard(name:"Main", bundle: nil)
                            let vc = storyboard.instantiateViewController(withIdentifier: "verificaCorreo") as UIViewController
                            
                            let siguientePantalla = vc as! VerificationViewController
                            
                            siguientePantalla.user = newUser
                            siguientePantalla.code2verify = code
                            siguientePantalla.email = correo_U.text ?? " "
                            
                            self.navigationController?.pushViewController(vc, animated: true)
                        } else {
                            let alert = UIAlertController(title: "Intente de nuevo", message: "No se pudo crear el usuario", preferredStyle: .alert)
                            
                            alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler:  nil))
                        }

                        
                    }catch{
                        let alert = UIAlertController(title: "Intente de nuevo", message: "No se pudo crear el usuario", preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler:  nil))
                        
                    }
                }
                
            }
        }
        
        
    @IBAction func textFieldDoneEditing(sender:UITextField){
            sender.resignFirstResponder()
        }
    
    
    @IBAction func terms(_ sender: Any) {
        if let url = NSURL(string: "http://20.38.4.246:8080/terminos/"){
            UIApplication.shared.openURL(url as URL)
        }
    }
    

    
}
