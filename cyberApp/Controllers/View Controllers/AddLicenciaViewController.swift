//
//  AddLicenciaViewController.swift
//  cyberApp
//
//  Created by Salomon Martinez on 07/10/22.
//

import UIKit

class AddLicenciaViewController: UIViewController {

    var reservaControlador = ReservaController()
    var licenciaControlador = LicenseController()
        

        @IBOutlet weak var licenciaText: UITextField!
        @IBOutlet weak var textFecha: UITextField!
        @IBOutlet weak var tiempoTextFiel: UITextField!
        @IBOutlet weak var horaText: UITextField!
        

        var licencia = [License]()
        let duraciones = ["1 días", "2 días", "3 días", "4 días", "5 días", "6 días", "7 días"]
        let horas = ["00:00", "01:00", "02:00", "03:00", "04:00", "05:00","06:00", "07:00", "08:00", "09:00", "10:00", "11:00","12:00", "13:00", "14:00", "15:00", "16:00","17:00", "18:00", "19:00", "20:00", "21:00", "22:00", "23:00", "24:00"]
        

        var licenciaPickerView = UIPickerView()
        
        let fechaPicker = UIDatePicker()
        let timePicker = UIPickerView()
        let horaPicker = UIPickerView()
        

        var fecha = ""
        var tiempo = ""
        var estatus = "En Progreso"
        var nombre = ""
        let code:Int = Int.random(in: 100000..<999999)
        var idServicio = "3"
        var hora = ""
        var id = 0
        var tipoSoft = ""
        var caracteristicas = ""
        var disponibleSoft = ""
        

        @IBAction func didTapButton() {
            

            let reservaNueva = Reserva(fecha: fecha, tipoRes: nombre, estatus: estatus, tiempoRes: tiempo, codigo: String(code), idServicio: idServicio, hora: hora)
            let licenciaUpdate = License(id: id, tipoSoft: tipoSoft, caracteristicas: caracteristicas, disponibleSoft: "Ocupado")
            
            
            Task{
                do{
                    try await reservaControlador.insertReserva(nuevareserva: reservaNueva)
                    try await licenciaControlador.updateReserva(updateReserva: licenciaUpdate)
                    showAlert()
                    
                }catch{
                    displayError(ReservaError.itemNotFound, title: "No se puede insertar la reserva")
                }
            }
        }
        

        func showAlert() {
            let alert = UIAlertController(title: "Reservación registrada", message: "Se guardo la información de tu reservación", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel))
            
            
            present(alert, animated: true)
            home()
        }
    
        func occupied() {
            let alert = UIAlertController(title: "Servicio ocupado", message: "No se puede reservar porque se encuentra ocupado", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel))
            
            present(alert, animated: true)
            
        }
        func home() {
                let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "main") as! UITabBarController
                
                nextViewController.modalPresentationStyle = .fullScreen
                // self es la vista 1, sobre ella presenta "siguienteVista"
                self.present(nextViewController, animated:true, completion:nil)
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            

            createDatepicker()
            
            licenciaText.inputView = licenciaPickerView
            tiempoTextFiel.inputView = timePicker
            horaText.inputView = horaPicker
            tiempoTextFiel.inputAccessoryView = createToolBarPicker()
            licenciaText.inputAccessoryView = createToolBarPicker()
            horaText.inputAccessoryView = createToolBarPicker()
            
            licenciaPickerView.delegate = self
            licenciaPickerView.dataSource = self
            timePicker.delegate = self
            timePicker.dataSource = self
            horaPicker.delegate = self
            horaPicker.dataSource = self
            
            
            let url = URL(string: "http://20.38.4.246:8080/api/softwares/")
            
            URLSession.shared.dataTask(with: url!) { (data, response, error) in
                  if error == nil {
                do {
                    self.licencia = try JSONDecoder().decode([License].self, from: data!)
                } catch {
                    print("Parse error")
                }
            }
            }.resume()
            
            
            licenciaPickerView.tag = 1
            timePicker.tag = 2
            horaPicker.tag = 3
        }

        func createToolbar() -> UIToolbar {

            let toolbar = UIToolbar()
            toolbar.sizeToFit()
            
            let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
            toolbar.setItems([doneBtn], animated: true)
            
            return toolbar
        }
        
        func createDatepicker() {
            
            fechaPicker.preferredDatePickerStyle = .inline
            textFecha.inputView = fechaPicker
            textFecha.inputAccessoryView = createToolbar()
            
        }
        
        @objc func donePressed(){
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
            
            fecha = dateFormatter.string(from: fechaPicker.date)
            
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            
            self.textFecha.text = dateFormatter.string(from: fechaPicker.date)
            self.view.endEditing(true)
        }
    
        func createToolBarPicker() -> UIToolbar{
            let toolbar = UIToolbar()
            toolbar.sizeToFit()
            
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressedPicker))
            toolbar.setItems([doneButton], animated: true)
            
            return toolbar
        }
        
        @objc func donePressedPicker(){
                
                self.view.endEditing(true)
        }

    }


extension AddLicenciaViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    // Número de componentes
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Número de renglones
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView.tag == 1 {
            return licencia.count
        }
        else if pickerView.tag == 2{
            return duraciones.count
        }
        else{
            return horas.count
        }
        
    }
    
    // Obtener las opciones para el pickView
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView.tag == 1 {
            return licencia[row].tipoSoft
        } else if pickerView.tag == 2 {
            return duraciones[row]
        } else{
            return horas[row]
        }
    }
    
    // Que hacer con la opción selecionada
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView.tag == 1 {
            licenciaText.text = licencia[row].tipoSoft
            nombre = licencia[row].tipoSoft
            id = licencia[row].id
            tipoSoft = licencia[row].tipoSoft
            caracteristicas = licencia[row].caracteristicas
            disponibleSoft = licencia[row].disponibleSoft
            if disponibleSoft == "Ocupado"{
                occupied()
            }
            
        }  else if pickerView.tag == 2{
            tiempoTextFiel.text = duraciones[row]
            tiempo = duraciones[row]
        } else{
            horaText.text = horas[row]
            hora = horas[row]
        }
        
        

        
        
    }
    
    // Alerta de error
    func displayError(_ error: Error, title: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
