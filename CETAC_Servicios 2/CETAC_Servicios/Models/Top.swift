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
    var id : String
    
    init(nombre: String, num: Int, id : String) {
        self.nombre = nombre
        self.num = num
        self.id = id
    }
    
    init (aDoc: DocumentSnapshot) {
        self.nombre = aDoc.get("nombre") as? String ?? ""
        self.num = aDoc.get("valor") as? Int ?? 0
        self.id = aDoc.documentID
    }
    
}
typealias Tops = [Top]


