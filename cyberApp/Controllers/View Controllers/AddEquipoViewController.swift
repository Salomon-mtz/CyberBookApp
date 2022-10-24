//
//  AddEquipoViewController.swift
//  cyberApp
//
//  Created by Salomon Martinez on 07/10/22.
//

import UIKit

class AddEquipoViewController: UIViewController{

    var reservaControlador = ReservaController()
    var equipoControlador = EquipoController()
        

        @IBOutlet weak var equipoText: UITextField!
        @IBOutlet weak var textFecha: UITextField!
        @IBOutlet weak var tiempoTextFiel: UITextField!
        @IBOutlet weak var horaText: UITextField!
        

        var equipo = [Equipo]()
        let duraciones = ["1 días", "2 días", "3 días", "4 días", "5 días", "6 días", "7 días"]
        let horas = ["00:00", "01:00", "02:00", "03:00", "04:00", "05:00","06:00", "07:00", "08:00", "09:00", "10:00", "11:00","12:00", "13:00", "14:00", "15:00", "16:00","17:00", "18:00", "19:00", "20:00", "21:00", "22:00", "23:00", "24:00"]
        

        var equipoPickerView = UIPickerView()
        
        let fechaPicker = UIDatePicker()
        let timePicker = UIPickerView()
        let horaPicker = UIPickerView()
        

        var fecha = ""
        var tiempo = ""
        var estatus = "En Progreso"
        var nombre = ""
        var code:Int = Int.random(in: 100000..<999999)
        var idServicio = "2"
        var hora = ""
        var id = 0
        var tipoEq = ""
        var caracteristicas =  ""
        var disponibleEq = ""
    
    
        @IBAction func didTapButton() {
            

            let reservaNueva = Reserva(fecha: fecha, tipoRes: nombre, estatus: estatus, tiempoRes: tiempo, codigo: String(code), idServicio: idServicio, hora: hora)
            let equipoUpdate = Equipo(id:id, tipoEq: tipoEq, caracteristicas: caracteristicas, disponibleEq: "Ocupado")
            
            Task{
                do{
                    try await reservaControlador.insertReserva(nuevareserva: reservaNueva)
                    try await equipoControlador.updateReserva(updateReserva: equipoUpdate)
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
            
            equipoText.inputView = equipoPickerView
            tiempoTextFiel.inputView = timePicker
            horaText.inputView = horaPicker
            tiempoTextFiel.inputAccessoryView = createToolBarPicker()
            equipoText.inputAccessoryView = createToolBarPicker()
            horaText.inputAccessoryView = createToolBarPicker()
            
            equipoPickerView.delegate = self
            equipoPickerView.dataSource = self
            timePicker.delegate = self
            timePicker.dataSource = self
            horaPicker.delegate = self
            horaPicker.dataSource = self
            
            let url = URL(string: "http://20.38.4.246:8080/api/equipos/")
            
            URLSession.shared.dataTask(with: url!) { (data, response, error) in
                  if error == nil {
                do {
                    self.equipo = try JSONDecoder().decode([Equipo].self, from: data!)
                } catch {
                    print("Parse error")
                }
            }
            }.resume()
            
            
            equipoPickerView.tag = 1
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


extension AddEquipoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    // Número de componentes
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Número de renglones
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView.tag == 1 {
            return equipo.count
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
            return equipo[row].tipoEq
        } else if pickerView.tag == 2 {
            return duraciones[row]
        } else{
            return horas[row]
        }
    }
    
    // Que hacer con la opción selecionada
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView.tag == 1 {
            equipoText.text = equipo[row].tipoEq
            nombre = equipo[row].tipoEq
            id = equipo[row].id
            tipoEq = equipo[row].tipoEq
            disponibleEq = equipo[row].tipoEq
            caracteristicas = equipo[row].caracteristicas
            if disponibleEq == "Ocupado"{
                occupied()
            }
        } else if pickerView.tag == 2{
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
