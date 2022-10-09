//
//  LicenciasTableViewCell.swift
//  cyberApp
//
//  Created by Salomon Martinez on 04/10/22.
//

import UIKit

class LicenciasTableViewCell: UITableViewCell {

    @IBOutlet weak var labelTitulo: UILabel!
    @IBOutlet weak var labelFecha: UILabel!
    @IBOutlet weak var labelHorario: UILabel!
    @IBOutlet weak var labelEstatus: UILabel!
    
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
