//
//  Paciente.swift
//  CRUDTanatologos
//
//  Created by Héctor Arturo Noyola Mondragón.  on 03/10/21.
//

import Foundation
import Firebase

class Paciente : Codable {
    var id: String
    var domicilio : String
    var edad : Int
    var estadoCivil : String
    var nombre : String
    var numCasa : Int
    var numCel : Int
    var numHijos : Int
    var numExpediente : Int
    var ocupacion : String
    var procedencia : String
    var sexo : String
    var religion : String
    var cierre : Bool
    
    init(id : String, domicilio : String, edad: Int, estadoCivil : String, nombre : String, numCasa : Int, numCel : Int, numHijos : Int, numExpediente : Int, sexo : String, ocupacion : String, procedencia : String, religion : String){
        self.id = id
        self.domicilio = domicilio
        self.edad = edad
        self.estadoCivil = estadoCivil
        self.nombre = nombre
        self.numCasa = numCasa
        self.numCel = numCel
        self.numHijos = numHijos
        self.numExpediente = numExpediente
        self.ocupacion = ocupacion
        self.procedencia = procedencia
        self.sexo = sexo
        self.religion = religion
        self.cierre = false
    }
    
    init (aDoc: DocumentSnapshot) {
        self.id = aDoc.documentID
        self.domicilio = aDoc.get("domicilio") as? String ?? ""
        self.edad = aDoc.get("edad") as? Int ?? -1
        self.estadoCivil = aDoc.get("estadoCivil") as? String ?? ""
        self.nombre = aDoc.get("nombre") as? String ?? ""
        self.numCasa = aDoc.get("numCasa") as? Int ?? -1
        self.numCel = aDoc.get("numCel") as? Int ?? -1
        self.numHijos = aDoc.get("numHijos") as? Int ?? -1
        self.numExpediente = aDoc.get("numExpediente") as? Int ?? -1
        self.ocupacion = aDoc.get("ocupacion") as? String ?? ""
        self.procedencia = aDoc.get("procedencia") as? String ?? ""
        self.sexo = aDoc.get("sexo") as? String ?? ""
        self.religion = aDoc.get("religion") as? String ?? ""
        self.cierre = aDoc.get("cierre") as? Bool ?? false
    }
}

typealias Pacientes = [Paciente]
