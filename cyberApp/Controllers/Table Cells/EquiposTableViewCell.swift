//
//  EquiposTableViewCell.swift
//  cyberApp
//
//  Created by Salomon Martinez on 04/10/22.
//

import UIKit

class EquiposTableViewCell: UITableViewCell {

        @IBOutlet weak var labelTitulo: UILabel!
        @IBOutlet weak var labelEstatus: UILabel!
        @IBOutlet weak var labelCarac: UILabel!
    
    
    let Green = UIColor(
        red:37/255,
        green:182/255,
        blue:37/255,
        alpha:1.0)
    
    let Red = UIColor(
        red:209/255,
        green:44/255,
        blue:44/255,
        alpha:1.0)
    
        func update(r:Equipo){
            labelTitulo.text = r.tipoEq
            //labelEstatus.text = r.disponibleEq
            if r.disponibleEq == "Disponible"{
                labelEstatus.text = "Disponible"
                labelEstatus.textColor = Green
            }
            else {
                labelEstatus.text = "Ocupado"
                labelEstatus.textColor = Red
            }
            labelCarac.text = r.caracteristicas
        }

        override func awakeFromNib() {
            super.awakeFromNib()
            
        }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)

            // Configure the view for the selected state
        }

    }

