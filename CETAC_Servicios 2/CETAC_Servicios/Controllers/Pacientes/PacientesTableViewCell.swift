//
//  PacienteTableViewCell.swift
//  CRUDTanatologos
//
//  Created by Héctor Arturo Noyola Mondragón.  on 06/10/21.
//

import UIKit

class PacienteTableViewCell: UITableViewCell {

    @IBOutlet weak var nombreLabel: UILabel!
    @IBOutlet weak var datosLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(with paciente: Paciente){
        nombreLabel.text = paciente.nombre;
    }

}
