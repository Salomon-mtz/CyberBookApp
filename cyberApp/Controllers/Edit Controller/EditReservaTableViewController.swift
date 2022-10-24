//
//  AddEditReservaTableViewController.swift
//  retoVersionBeta
//
//  Created by molina on 23/09/22.
//

import UIKit

class EditReservaTableViewController: UITableViewController{
    
    var reservas:Reserva?
    
    //PASO 0 crear un IBOutlet del boton save
    @IBOutlet weak var saveButton: UIBarButtonItem! //paso 0
    @IBOutlet weak var textTitulo: UILabel!
    @IBOutlet weak var textFecha: UILabel!
    @IBOutlet weak var textHorario: UILabel!
    
    @IBOutlet weak var qr: UIImageView!
    
    init?(coder: NSCoder, c: Reserva?) {
        self.reservas = c
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
        saveButton.isEnabled = !icono.isEmpty && !fecha.isEmpty && !horario.isEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let reserva = reservas{
            textTitulo.text = reserva.tipoRes
            textFecha.text = reserva.fecha
            textHorario.text = reserva.tiempoRes
            let code = reserva.codigo
            print("Codigo: ")
            print(code)
            let image = generateQRCode(from: code)
            qr.image = image
            title = "Detalles de Reserva"
        }
        else{
            title = "Insert reserva"
        }
        //paso 3 invocar la función updateSaveButtonState()
        updateSaveButtonState()

        
    }
    
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }

        return nil
    }
    



    

}
