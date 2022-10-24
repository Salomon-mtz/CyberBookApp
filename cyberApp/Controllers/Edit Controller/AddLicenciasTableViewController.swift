//
//  AddLicenciasTableViewController.swift
//  cyberApp
//
//  Created by Salomon Martinez on 04/10/22.
//

import UIKit

class AddLicenciasTableViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var licences:License?
    
    //PASO 0 crear un IBOutlet del boton save
    @IBOutlet weak var saveButton: UIBarButtonItem! //paso 0
    @IBOutlet weak var textTitulo: UILabel!
    @IBOutlet weak var textFecha: UITextField!
    @IBOutlet weak var textHorario: UITextField!
    @IBOutlet weak var textEstatus: UILabel!
    
    let datePicker = UIDatePicker()
    let timePicker = UIPickerView()
    
    init?(coder: NSCoder, l: License?) {
        self.licences = l
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
        
        if let licence = licences{
            textTitulo.text = licence.tipoSoft
            textEstatus.text = licence.disponibleSoft
            title = "Edit reserva"
        }
        else{
            title = "Insert reserva"
        }
        //paso 3 invocar la función updateSaveButtonState()
        updateSaveButtonState()
        createDatePicker()
        createPicker()

        
    }
    
    let duraciones = ["1 días", "2 días", "3 días", "4 días", "5 días"]
    
    @objc func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return duraciones.count
    }

    @objc(numberOfComponentsInPickerView:) func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    @objc func pickerView(_ timePicker: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return duraciones[row]
    }
    
    @objc func pickerView(_ timePicker: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
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
    
    
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        guard segue.identifier == "saveUnwind" else { return }
        let titulo = textTitulo.text ?? ""
        let fecha = textFecha.text ?? ""
        let horario = textHorario.text ?? ""
        let estatus = textEstatus.text ?? ""
        licences = License(tipoSoft: titulo, caracteristicas: titulo, disponibleSoft: estatus)
    }
    

}
