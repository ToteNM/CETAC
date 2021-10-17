//
//  Globales.swift
//  CETAC_Servicios
//
//  Created by Héctor Arturo Noyola Mondragón.  on 17/10/21.
//

import Foundation
import Firebase

class Globales : Codable {
    var cuota: Double
    var usuariosAtendidos: Int
    
    init(cuota : Double, usuariosAtendidos : Int){
        self.cuota = cuota
        self.usuariosAtendidos = usuariosAtendidos
    }
    
    init (aDoc: DocumentSnapshot) {
        self.cuota = aDoc.get("cuota") as? Double ?? -1.0
        self.usuariosAtendidos = aDoc.get("usuariosAtendidos") as? Int ?? -1
    }
}

