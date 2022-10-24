//
//  AddEditReservaTableViewController.swift
//  retoVersionBeta
//
//  Created by molina on 23/09/22.
//

import UIKit
/*
class AddEditReservaTableViewController: UITableViewController{
    
    var reservaController = ReservaController()
    var classroom = Classrooms()
    
    @IBOutlet weak var hardwareTextField: UITextField!
    @IBOutlet weak var textFecha: UITextField!
    @IBOutlet weak var textHorario: UITextField!
    
    let datePicker = UIDatePicker()
    let timePicker = UIPickerView()
    var hardwarePickerView = UIPickerView()
    
    var fecha = ""
    var tiempo = ""
    
    
    @IBAction func done() {
        
        // nueva reserva
        let reservaNueva = Reserva(fecha: fecha, tiempoRes: tiempo)
        // Insertar la nueva reserva en el servidor
        Task{
            do{
                try await reservaController.insertReserva(nuevareserva: reservaNueva)
                // self.updateUI()
                showAlert()
            }catch{
                displayError(ReservaError.itemNotFound, title: "No se pudo acceder a las reservas")
            }
        }
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Reservación registrada", message: "Se guardo la información de tu reservación", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel))
        
        present(alert, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createDatePicker()
        createPicker()
        
        let url = URL(string: "http://20.38.4.246:8080/espacios/")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil {
                do {
                    self.classroom = try JSONDecoder().decode([Classroom].self, from: data!)
                } catch {
                    print("Parse error")
                }
            }
        }.resume()
        
    }
    
    let duraciones = ["1 hora", "2 horas", "3 horas", "4 horas", "5 horas"]
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return duraciones.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ timePicker: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return duraciones[row]
    }
    
    func pickerView(_ timePicker: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.textHorario.text = self.duraciones[row]
    }
    
    func createToolBarPicker() -> UIToolbar{
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressedPicker))
        toolbar.setItems([doneButton], animated: true)
        
        return toolbar
    }
    
    func createPicker(){
        timePicker.delegate = self
        timePicker.dataSource = self
        
        textHorario.inputView = timePicker
        textHorario.inputAccessoryView = createToolBarPicker()
    }
    
    @objc func donePressedPicker(){
        let row = self.timePicker.selectedRow(inComponent: 0)
        self.timePicker.selectRow(row, inComponent: 0, animated: false)
        self.textHorario.text = self.duraciones[row]
        
        self.view.endEditing(true)
    }
    
    func createToolbar() -> UIToolbar{
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
        return toolbar
    }
    
    func createDatePicker(){
        datePicker.preferredDatePickerStyle = .inline
        datePicker.datePickerMode = .date
        textFecha.inputView = datePicker
        textFecha.inputAccessoryView = createToolbar()
    }
    
    @objc func donePressed(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        
        self.textFecha.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    func displayError(_ error: Error, title: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
    
extension AddEditReservaTableViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    // Número de componentes
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Número de renglones
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return classroom.count
        
    }
    
    // Obtener las opciones para el pickView
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return classroom[row].nombreEspacio
    }
    
    // Que hacer con la opción selecionada
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        hardwareTextField.text = classroom[row].nombreEspacio
        
        hardwareTextField.resignFirstResponder()
        
    }
    
    
}*/
