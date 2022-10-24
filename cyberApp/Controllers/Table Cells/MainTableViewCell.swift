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
        labelEstatus.text = r.disponibleEsp
        labelCapacidad.text = r.capacidad
    }
    func update(r:Equipo){
        labelTitulo.text = r.tipoEq
        labelEstatus.text = r.disponibleEq
    }
    func update(r:License){
        labelTitulo.text = r.tipoSoft
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
