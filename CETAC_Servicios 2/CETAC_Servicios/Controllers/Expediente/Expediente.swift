//
//  Sesion.swift
//  JonatanFireB
//
//  Created by user193524 on 10/7/21.
//

import Foundation
import Firebase

class Expediente : Codable{
    var id : String
    var nombreUsuario : String
    var nombreTanatologo : String
    var motivo : String
    var servicio : String
    var herramienta : String
    var fecha: Array<Int>
    var numExpediente : Int
    var numSesion: Int
    
    
    
    
        
    
    init(id: String, nombreUsuario : String, nombreTanatologo : String, motivo : String, servicio : String, herramienta : String, fecha: Array<Int>, numExpediente : Int, numSesion: Int){
        self.id = id
        self.numExpediente = numExpediente
        self.fecha = fecha
        self.herramienta = herramienta
        self.motivo = motivo
        self.nombreUsuario = nombreUsuario
        self.numSesion = numSesion
        self.servicio = servicio
        self.nombreTanatologo = nombreTanatologo
    }
    
    init (aDoc: DocumentSnapshot) {
        self.id = aDoc.documentID
        self.numExpediente = aDoc.get("expediente") as? Int ?? -1
        self.fecha = aDoc.get("fecha_sesion") as? Array<Int> ?? []
        self.herramienta = aDoc.get("herramienta") as? String ?? ""
        self.motivo = aDoc.get("motivo") as? String ?? ""
        self.nombreUsuario = aDoc.get("nombre") as? String ?? ""
        self.numSesion = aDoc.get("num_sesion") as? Int ?? -1
        self.servicio = aDoc.get("servicio") as? String ?? ""
        self.nombreTanatologo = aDoc.get("tanatologo") as? String ?? ""
        
        

    }
}

typealias Expedientes = [Expediente]
