//
//  LicenciasTableViewCell.swift
//  cyberApp
//
//  Created by Salomon Martinez on 04/10/22.
//

import UIKit

class LicenciasTableViewCell: UITableViewCell {

    @IBOutlet weak var labelTitulo: UILabel!
    @IBOutlet weak var labelCaracteristicas: UILabel!
    @IBOutlet weak var labelEstatus: UILabel!
    
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
    
    
    func update(r:License){
        labelTitulo.text = r.tipoSoft
        labelCaracteristicas.text = r.caracteristicas
        //labelEstatus.text = r.disponibleSoft
        if r.disponibleSoft == "Disponible"{
            labelEstatus.text = "Disponible"
            labelEstatus.textColor = Green
        }
        else {
            labelEstatus.text = "Ocupado"
            labelEstatus.textColor = Red
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
