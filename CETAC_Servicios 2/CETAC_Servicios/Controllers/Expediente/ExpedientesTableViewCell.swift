//
//  ExpedientesTableViewCell.swift
//  CRUDTanatologos
//
//  Created by Héctor Arturo Noyola Mondragón.  on 03/10/21.
//

import UIKit

class ExpedientesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var month: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var motivo: UILabel!
    @IBOutlet weak var doctor: UILabel!
    @IBOutlet weak var tipo: UILabel!
    @IBOutlet weak var numero: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(with sesion: Sesion){
        nombre.text = sesion.paciente
        motivo.text = sesion.motivo
        doctor.text = sesion.doctor
        tipo.text = sesion.tipo
        numero.text = "#" + String(sesion.numSesion)
        //01/02/2020
        let dia = String(sesion.fecha.prefix(2))
        day.text = dia
        let anio = String(sesion.fecha.suffix(4))
        year.text = anio
        let start = sesion.fecha.index(sesion.fecha.startIndex, offsetBy: 3)
        let end = sesion.fecha.index(sesion.fecha.endIndex, offsetBy: -5)
        let range = start..<end
        var mes = String(sesion.fecha[range])
        switch mes {
        case "01":
            mes = "ENE"
            break;
        case "02":
            mes = "FEB"
            break;
        case "03":
            mes = "MAR"
            break;
        case "04":
            mes = "ABR"
            break;
        case "05":
            mes = "MAY"
            break;
        case "06":
            mes = "JUN"
            break;
        case "07":
            mes = "JUL"
            break;
        case "08":
            mes = "AGO"
            break;
        case "09":
            mes = "SEP"
            break;
        case "10":
            mes = "OCT"
            break;
        case "11":
            mes = "NOV"
            break;
        case "12":
            mes = "DEC"
            break;
        default:
            mes = "???"
            break;
    }
        month.text = mes
        
    }

}
