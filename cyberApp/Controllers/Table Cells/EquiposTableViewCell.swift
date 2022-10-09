//
//  EquiposTableViewCell.swift
//  cyberApp
//
//  Created by Salomon Martinez on 04/10/22.
//

import UIKit

class EquiposTableViewCell: UITableViewCell {

        @IBOutlet weak var labelTitulo: UILabel!
        @IBOutlet weak var labelFecha: UILabel!
        @IBOutlet weak var labelHorario: UILabel!
        @IBOutlet weak var labelEstatus: UILabel!
        
        func update(r:Equipos){
            labelTitulo.text = r.titulo
            labelFecha.text = r.fechaReserva
            labelHorario.text = r.horario
            labelEstatus.text = r.estatus
        }

        override func awakeFromNib() {
            super.awakeFromNib()
            
        }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)

            // Configure the view for the selected state
        }

    }

