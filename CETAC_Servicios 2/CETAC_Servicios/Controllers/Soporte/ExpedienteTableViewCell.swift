//
//  ExpedienteTableViewCell.swift
//  CETAC_Servicios
//
//  Created by user193304 on 10/16/21.
//

import UIKit

class ExpedienteTableViewCell: UITableViewCell {
   

    @IBOutlet weak var diaFecha: UILabel!
    @IBOutlet weak var mesFecha: UILabel!
    @IBOutlet weak var añoFecha: UILabel!
    @IBOutlet weak var usuario: UILabel!
    @IBOutlet weak var motivo: UILabel!
    @IBOutlet weak var doctor: UILabel!
    @IBOutlet weak var numsesion: UILabel!
    @IBOutlet weak var intervencion: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func update(with expediente: Sesion){
        usuario.text = expediente.paciente
        motivo.text = expediente.motivo
        doctor.text = expediente.doctor
        intervencion.text = expediente.intervencion
        numsesion.text = "#" + String(expediente.numSesion)
        //01/02/2020
        let diaFecha1 = String(expediente.fecha.prefix(2))
        diaFecha.text = diaFecha1
        let añoFecha1 = String(expediente.fecha.suffix(4))
        añoFecha.text = añoFecha1
        let start = expediente.fecha.index(expediente.fecha.startIndex, offsetBy: 3)
        let end = expediente.fecha.index(expediente.fecha.endIndex, offsetBy: -5)
        let range = start..<end
        var mesFecha1 = String(expediente.fecha[range])
        switch mesFecha1 {
        case "01":
            mesFecha1 = "ENE"
            break;
        case "02":
            mesFecha1 = "FEB"
            break;
        case "03":
            mesFecha1 = "MAR"
            break;
        case "04":
            mesFecha1 = "ABR"
            break;
        case "05":
            mesFecha1 = "MAY"
            break;
        case "06":
            mesFecha1 = "JUN"
            break;
        case "07":
            mesFecha1 = "JUL"
            break;
        case "08":
            mesFecha1 = "AGO"
            break;
        case "09":
            mesFecha1 = "SEP"
            break;
        case "10":
            mesFecha1 = "OCT"
            break;
        case "11":
            mesFecha1 = "NOV"
            break;
        case "12":
            mesFecha1 = "DEC"
            break;
        default:
            mesFecha1 = "???"
            break;
    }
        mesFecha.text = mesFecha1
        
    }

}
