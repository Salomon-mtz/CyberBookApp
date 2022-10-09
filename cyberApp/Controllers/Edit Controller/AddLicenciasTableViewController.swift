//
//  AddLicenciasTableViewController.swift
//  cyberApp
//
//  Created by Salomon Martinez on 04/10/22.
//

import UIKit

class AddLicenciasTableViewController: UITableViewController {

    var licencia:License?
    
    //PASO 0 crear un IBOutlet del boton save
    @IBOutlet weak var saveButton: UIBarButtonItem! //paso 0
    @IBOutlet weak var textTitulo: UILabel!
    @IBOutlet weak var textFecha: UITextField!
    @IBOutlet weak var textHorario: UITextField!
    @IBOutlet weak var textEstatus: UILabel!
    
    let datePicker = UIDatePicker()
    
    init?(coder: NSCoder, l: License?) {
        self.licencia = l
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
        saveButton.isEnabled = !icono.isEmpty && !fecha.isEmpty && !horario.isEmpty && !estatus.isEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let licence = licencia{
            textTitulo.text = licence.tipoSoft
            textFecha.text = licence.fechaSoft
            textHorario.text = licence.tiempoSoft
            textEstatus.text = licence.disponibleSoft
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
        dateFormatter.dateFormat = "MMMM d, yyyy"
        
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
        licencia = License(fechaSoft: fecha, tipoSoft: titulo, caracteristicas: titulo, tiempoSoft: horario, disponibleSoft: estatus)
    }
    

}
