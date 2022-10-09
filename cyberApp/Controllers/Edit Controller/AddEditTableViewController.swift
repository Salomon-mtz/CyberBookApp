//
//  AddEditReservaTableViewController.swift
//  retoVersionBeta
//
//  Created by molina on 23/09/22.
//

import UIKit

class AddEditReservaTableViewController: UITableViewController {
    
    var classrooms:Classroom?
    
    //PASO 0 crear un IBOutlet del boton save
    @IBOutlet weak var saveButton: UIBarButtonItem! //paso 0
    @IBOutlet weak var textTitulo: UILabel!
    @IBOutlet weak var textFecha: UITextField!
    @IBOutlet weak var textHorario: UITextField!
    @IBOutlet weak var textEstatus: UILabel!
    @IBOutlet weak var textCapacidad: UILabel!
    
    let datePicker = UIDatePicker()
    
    init?(coder: NSCoder, c: Classroom?) {
        self.classrooms = c
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Paso 2 crear función updateSaveButtonState
    func updateSaveButtonState() {
        let icono = textTitulo.text ?? ""
        let fecha = textFecha.text ?? ""
        let horario = textHorario.text ?? ""
        let estatus = textEstatus.text ?? ""
        let capacidad = textCapacidad.text ?? ""
        saveButton.isEnabled = !icono.isEmpty && !fecha.isEmpty && !horario.isEmpty && !estatus.isEmpty && !capacidad.isEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let classroom = classrooms{
            textTitulo.text = classroom.nombreEspacio
            textFecha.text = classroom.fechaEsp
            textHorario.text = classroom.tiempoEsp
            textEstatus.text = classroom.disponibleEsp
            textCapacidad.text = classroom.capacidad
            title = "Edit reserva"
        }
        else{
            title = "Insert reserva"
        }
        //paso 3 invocar la función updateSaveButtonState()
        updateSaveButtonState()
        createDatePicker()
        
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
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        self.textFecha.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        guard segue.identifier == "saveUnwind" else { return }
        let titulo = textTitulo.text ?? ""
        let fecha = textFecha.text ?? ""
        let horario = textHorario.text ?? ""
        let estatus = textEstatus.text ?? ""
        let capacidad = textCapacidad.text ?? ""
        if classrooms == nil{ //insertando nuevo
            classrooms = Classroom(nombreEspacio: titulo, caracteristicas: "hola", tiempoEsp: horario, disponibleEsp: estatus, capacidad: capacidad, fechaEsp: fecha)
        }
        else{//editando reserva
            classrooms = Classroom(id: self.classrooms!.id, nombreEspacio: titulo, caracteristicas: "hola", tiempoEsp: horario, disponibleEsp: estatus, capacidad: capacidad, fechaEsp: fecha)

        }
    }
    

}
