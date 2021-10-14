//
//  SesionController.swift
//  CRUDTanatologos
//
//  Created by Héctor Arturo Noyola Mondragón.  on 03/10/21.
//

import Foundation
import Firebase

class fetcherController {
    
    let db = Firestore.firestore()
    
    func fetchServicios(completion: @escaping (Result<Sesiones, Error>)-> Void){
        var sesiones = [Sesion]()
        db.collection("sesion").getDocuments{ (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                completion(.failure(err))
            } else {
                for document in querySnapshot!.documents {
                    var s = Sesion(aDoc: document)
                    sesiones.append(s)
                }
                completion(.success(sesiones))
            }
        }
    }
    
    func fetchPacientes(completion: @escaping (Result<Pacientes, Error>)-> Void){
        var pacientes = [Paciente]()
        db.collection("paciente").order(by: "nombre").getDocuments{ (querySnapshot, err) in
            if let err = err {
                print("Error getting document: \(err)")
                completion(.failure(err))
            } else {
                for document in querySnapshot!.documents {
                    var p = Paciente(aDoc: document)
                    pacientes.append(p)
                }
                completion(.success(pacientes))
            }
        }
    }
    
    func fetchNumSesionesPorNombreDePaciente(paciente: String, completion: @escaping (Result<Int, Error>)-> Void){
        var numero = 0
        db.collection("sesion").whereField("paciente", isEqualTo: paciente).getDocuments{ (querySnapshot, err) in
            if let err = err {
                print("Error getting document: \(err)")
                completion(.failure(err))
            } else {
                for document in querySnapshot!.documents {
                    numero += 1
                }
                completion(.success(numero))
            }
        }
    }
    
    func fetchUsuarios(completion: @escaping (Result<Usuarios, Error>)-> Void){
        var pacientes = [Usuario]()
        db.collection("users").order(by: "rol").getDocuments{ (querySnapshot, err) in
            if let err = err {
                print("Error getting document: \(err)")
                completion(.failure(err))
            } else {
                for document in querySnapshot!.documents {
                    var p = Usuario(aDoc: document)
                    pacientes.append(p)
                }
                completion(.success(pacientes))
            }
        }
    }
    
    func fetchIndicadores(completion: @escaping (Result<Indicadores, Error>)-> Void){
        var indicadores = [Indicador]()
        db.collection("indicadores").getDocuments{ (querySnapshot, err) in
            if let err = err {
                print("Error getting document: \(err)")
                completion(.failure(err))
            } else {
                for document in querySnapshot!.documents {
                    var p = Indicador(aDoc: document)
                    indicadores.append(p)
                }
                completion(.success(indicadores))
            }
        }
    }
    /*
    func fetchPacientes(completion: @escaping (Result<Pacientes, Error>)-> Void) {
        var pacientes = [Paciente]()
        db.collection("usuario").document("5lY4J7phoNhoAfltbC0V").collection("tanatologo").document("WrPhouVWtNM7DbP20hQi").collection("paciente").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                completion(.failure(err))
            } else {
                for document in querySnapshot!.documents {
                    var s = Paciente(aDoc: document)
                    pacientes.append(s)
                }
                completion(.success(pacientes))
            }
        }
    }
    
    func fetchTanatologos(completion: @escaping (Result<Tanatologos, Error>)-> Void) {
        var tanatologos = [Tanatologo]()
        db.collection("usuario").document("5lY4J7phoNhoAfltbC0V").collection("tanatologo").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                completion(.failure(err))
            } else {
                for document in querySnapshot!.documents {
                    var s = Tanatologo(aDoc: document)
                    tanatologos.append(s)
                }
                completion(.success(tanatologos))
            }
        }
    }
     */
    
    
}
