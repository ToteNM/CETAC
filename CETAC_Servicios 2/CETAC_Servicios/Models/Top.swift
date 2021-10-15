//
//  Top.swift
//  CETAC_Servicios
//
//  Created by user193304 on 10/15/21.
//

import Foundation
import Firebase

class Top: Codable {
    var nombre : String
    var num : Int
    
    init(nombre: String, num: Int) {
        self.nombre = nombre
        self.num = num
    }
    
    init (aDoc: DocumentSnapshot) {
        self.nombre = aDoc.get("nombre") as? String ?? ""
        self.num = aDoc.get("valor") as? Int ?? 0
    }
    
}
typealias Tops = [Top]


