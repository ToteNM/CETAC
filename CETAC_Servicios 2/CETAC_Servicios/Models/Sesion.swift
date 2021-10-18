//
//  Sesion.swift
//  CRUDTanatologos
//
//  Created by Héctor Arturo Noyola Mondragón.  on 03/10/21.
//

import Foundation
import Firebase

class Sesion : Codable{
    
    var id: String
    var doctor : String
    var paciente : String
    var numSesion: Int
    var numExpediente: Int
    var cuota: Double
    var fecha: String
    var evaluacion: String
    var cierre: Bool
    var herramienta : String
    var motivo : String
    var tipo : String
    var intervencion : String
    
    init(id: String, numSesion: Int, numExpediente: Int, cuota: Double, fecha: String, evaluacion: String, cierre: Bool, paciente_id: String, herramienta : String, motivo : String, tipo : String, intervencion : String, doctor : String, paciente : String){
        self.id = id
        self.numSesion = numSesion
        self.numExpediente = numExpediente
        self.cuota = cuota
        self.fecha = fecha
        self.evaluacion = evaluacion
        self.cierre = cierre
        self.herramienta = herramienta
        self.intervencion = intervencion
        self.motivo = motivo
        self.tipo = tipo
        self.doctor = doctor
        self.paciente = paciente
    }
    
    init (aDoc: DocumentSnapshot) {
        self.id = aDoc.documentID
        self.numSesion = aDoc.get("numSesion") as? Int ?? -1
        self.numExpediente = aDoc.get("numExpediente") as? Int ?? -1
        self.cuota = aDoc.get("cuota") as? Double ?? 0.0
        self.fecha = aDoc.get("fecha") as? String ?? ""
        self.evaluacion = aDoc.get("evaluacion") as? String ?? ""
        self.cierre = aDoc.get("cierre") as? Bool ?? false
        self.herramienta = aDoc.get("herramienta") as? String ?? ""
        self.intervencion = aDoc.get("intervencion") as? String ?? ""
        self.motivo = aDoc.get("motivo") as? String ?? ""
        self.tipo = aDoc.get("tipo") as? String ?? ""
        self.doctor = aDoc.get("doctor") as? String ?? ""
        self.paciente = aDoc.get("paciente") as? String ?? ""
    }
}

typealias Sesiones = [Sesion]
