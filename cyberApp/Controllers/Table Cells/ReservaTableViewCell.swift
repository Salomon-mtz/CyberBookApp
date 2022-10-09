//
//  ReservaTableViewCell.swift
//  cyberApp
//
//  Created by Salomon Martinez on 05/10/22.
//

import UIKit

class ReservaTableViewCell: UITableViewCell {

    @IBOutlet weak var labelTitulo: UILabel!
    @IBOutlet weak var labelFecha: UILabel!
    @IBOutlet weak var labelHorario: UILabel!
    @IBOutlet weak var labelEstatus: UILabel!
    @IBOutlet weak var labelCapacidad: UILabel!
    
    func update(r:Reserva){
        labelTitulo.text = r.tipoRes
        labelFecha.text = r.fecha
        labelHorario.text = r.tiempoRes
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
