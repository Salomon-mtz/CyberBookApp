//
//  ClassroomTableViewCell.swift
//  cyberApp
//
//  Created by Salomon Martinez on 29/09/22.
//

import UIKit

class ClassroomTableViewCell: UITableViewCell {

    @IBOutlet weak var labelTitulo: UILabel!
    @IBOutlet weak var labelFecha: UILabel!
    @IBOutlet weak var labelHorario: UILabel!
    @IBOutlet weak var labelEstatus: UILabel!
    @IBOutlet weak var labelCapacidad: UILabel!
    
    func update(r:Classroom){
        labelTitulo.text = r.nombreEspacio
        labelFecha.text = r.fechaEsp
        labelHorario.text = r.tiempoEsp
        labelEstatus.text = r.disponibleEsp
        labelCapacidad.text = r.capacidad
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
