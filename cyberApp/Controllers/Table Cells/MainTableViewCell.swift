//
//  MainTableViewCell.swift
//  cyberApp
//
//  Created by Salomon Martinez on 02/10/22.
//

import UIKit

class MainTableViewCell: UITableViewCell {

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
    func update(r:Equipos){
        labelTitulo.text = r.titulo
        labelFecha.text = r.fechaReserva
        labelHorario.text = r.horario
        labelEstatus.text = r.estatus
    }
    func update(r:License){
        labelTitulo.text = r.tipoSoft
        labelFecha.text = r.fechaSoft
        labelHorario.text = r.tiempoSoft
        labelEstatus.text = r.disponibleSoft
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
