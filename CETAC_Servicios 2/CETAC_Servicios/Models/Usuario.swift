//
//  Usuario.swift
//  CRUDTanatologos
//
//  Created by Héctor Arturo Noyola Mondragón.  on 11/10/21.
//

import Foundation
import Firebase

class Usuario : Codable {
    var apellidos: String
    var email: String
    var nombre: String
    var rol: Int
    var uid: String
    
    init(apellidos: String, email: String, nombre: String, rol: Int, uid: String){
        self.apellidos = apellidos
        self.email = email
        self.nombre = nombre
        self.rol = rol
        self.uid = uid
    }
    
    init (aDoc: DocumentSnapshot) {
        self.apellidos = aDoc.get("apellidos") as? String ?? ""
        self.rol = aDoc.get("rol") as? Int ?? -1
        self.email = aDoc.get("email") as? String ?? ""
        self.nombre = aDoc.get("nombre") as? String ?? ""
        self.uid = aDoc.get("uid") as? String ?? ""
    }
}

typealias Usuarios = [Usuario]
