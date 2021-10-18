//
//  TanatologoTableViewCell.swift
//  CETAC_Servicios
//
//  Created by user193304 on 10/16/21.
//

import UIKit

class TanatologoTableViewCell: UITableViewCell {

    @IBOutlet weak var num: UILabel!
    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var servicio: UILabel!
    var numero: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(with usuario: Usuario, cont: Int){
        num.text = String(cont+1)
        nombre.text = usuario.nombre + " " + usuario.apellidos
        servicio.text = usuario.intervencion
        /*num.text = String(tanatologo.num)
        nombre.text = tanatologo.nombre
        servicio.text = tanatologo.servicio*/
    }
}
