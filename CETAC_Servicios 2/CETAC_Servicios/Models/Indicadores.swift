//
//  Indicadores.swift
//  CRUDTanatologos
//
//  Created by Héctor Arturo Noyola Mondragón.  on 12/10/21.
//

import Foundation
import Firebase

class Indicador : Codable {
    var cuota: Int
    var usuariosMes : Int
    var usuariosSem : Int
    var usuariosTres : Int
    
    init(cuota : Int, usuariosMes : Int, usuariosSem : Int, usuariosTres : Int){
        self.cuota = cuota
        self.usuariosMes = usuariosMes
        self.usuariosSem = usuariosSem
        self.usuariosTres = usuariosTres
    }
    
    init (aDoc: DocumentSnapshot) {
        self.cuota = aDoc.get("cuota") as? Int ?? -1
        self.usuariosMes = aDoc.get("usuariosMes") as? Int ?? -1
        self.usuariosSem = aDoc.get("usuariosSem") as? Int ?? -1
        self.usuariosTres = aDoc.get("usuariosTres") as? Int ?? -1
    }
}

typealias Indicadores = [Indicador]
