//
//  ClassroomTableViewCell.swift
//  cyberApp
//
//  Created by Salomon Martinez on 29/09/22.
//

import UIKit

class ClassroomTableViewCell: UITableViewCell {

    @IBOutlet weak var labelTitulo: UILabel!
    @IBOutlet weak var labelEstatus: UILabel!
    @IBOutlet weak var labelCapacidad: UILabel!
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
    
    func update(r:Classroom){
        labelTitulo.text = r.nombreEspacio
        //labelEstatus.text = r.disponibleEsp
        if r.disponibleEsp == "Disponible"{
            labelEstatus.text = "Disponible"
            labelEstatus.textColor = Green
        }
        else {
            labelEstatus.text = "Ocupado"
            labelEstatus.textColor = Red
        }
        labelCapacidad.text = r.capacidad
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
