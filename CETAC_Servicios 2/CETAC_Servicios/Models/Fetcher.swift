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
        db.collection("sesion").order(by: "paciente").getDocuments{ (querySnapshot, err) in
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
    
    func fetchPacientesOpen(completion: @escaping (Result<Pacientes, Error>)-> Void){
        var pacientes = [Paciente]()
        db.collection("paciente").order(by: "nombre").getDocuments{ (querySnapshot, err) in
            if let err = err {
                print("Error getting document: \(err)")
                completion(.failure(err))
            } else {
                for document in querySnapshot!.documents {
                    var p = Paciente(aDoc: document)
                    if p.cierre == false {
                        pacientes.append(p)
                    }
                }
                completion(.success(pacientes))
            }
        }
    }
    
    func fetchPacientesporGenero(completion: @escaping (Result<[Int], Error>)-> Void){
        var datos = [0,0,0]
        db.collection("paciente").getDocuments{ (querySnapshot, err) in
            if let err = err {
                print("Error getting document: \(err)")
                completion(.failure(err))
            } else {
                for document in querySnapshot!.documents {
                    var p = Paciente(aDoc: document)
                    if p.sexo == "Hombre" {
                        datos[0] += 1
                    }
                    else if p.sexo == "Mujer"{
                        datos[1] += 1
                    }
                    else {
                        datos[2] += 1
                    }
                }
                completion(.success(datos))
            }
        }
    }
    
    func fetchTopServicios(completion: @escaping (Result<Tops, Error>)-> Void){
        var tops = [Top]()
        db.collection("globales").document("YyvCoL37678hRbDu0Hu9").collection("servicios").getDocuments{ (querySnapshot, err) in
            if let err = err {
                print("Error getting document: \(err)")
                completion(.failure(err))
            } else {
                for document in querySnapshot!.documents {
                    var p = Top(aDoc: document)
                    tops.append(p)
                }
                completion(.success(tops))
            }
        }
    }
    
    func fetchUsuarioPorCorreo(email : String, completion: @escaping (Result<String, Error>)-> Void){
        var nombre = ""
        db.collection("users").whereField("email", isEqualTo: email).getDocuments{ (querySnapshot, err) in
            if let err = err {
                print("Error getting document: \(err)")
                completion(.failure(err))
            } else {
                for document in querySnapshot!.documents {
                    var p = Usuario(aDoc: document)
                    nombre = p.nombre
                }
                completion(.success(nombre))
            }
        }
    }
    
    func fetchNombreHerramientaActual(herr : String, completion: @escaping (Result<Tops, Error>)-> Void){
        var tops = [Top]()
        db.collection("globales").document("YyvCoL37678hRbDu0Hu9").collection("herramienta").whereField("nombre", isEqualTo: herr).getDocuments{ (querySnapshot, err) in
            if let err = err {
                print("Error getting document: \(err)")
                completion(.failure(err))
            } else {
                for document in querySnapshot!.documents {
                    var p = Top(aDoc: document)
                    tops.append(p)
                }
                completion(.success(tops))
            }
        }
    }
    
    func fetchNombreIntervencionActual(herr : String, completion: @escaping (Result<Tops, Error>)-> Void){
        var tops = [Top]()
        db.collection("globales").document("YyvCoL37678hRbDu0Hu9").collection("intervencion").whereField("nombre", isEqualTo: herr).getDocuments{ (querySnapshot, err) in
            if let err = err {
                print("Error getting document: \(err)")
                completion(.failure(err))
            } else {
                for document in querySnapshot!.documents {
                    var p = Top(aDoc: document)
                    tops.append(p)
                }
                completion(.success(tops))
            }
        }
    }
    
    func fetchNombreServicioActual(herr : String, completion: @escaping (Result<Tops, Error>)-> Void){
        var tops = [Top]()
        db.collection("globales").document("YyvCoL37678hRbDu0Hu9").collection("servicios").whereField("nombre", isEqualTo: herr).getDocuments{ (querySnapshot, err) in
            if let err = err {
                print("Error getting document: \(err)")
                completion(.failure(err))
            } else {
                for document in querySnapshot!.documents {
                    var p = Top(aDoc: document)
                    tops.append(p)
                }
                completion(.success(tops))
            }
        }
    }
    
    func fetchNombreMotivoActual(herr : String, completion: @escaping (Result<Tops, Error>)-> Void){
        var tops = [Top]()
        db.collection("globales").document("YyvCoL37678hRbDu0Hu9").collection("motivos").whereField("nombre", isEqualTo: herr).getDocuments{ (querySnapshot, err) in
            if let err = err {
                print("Error getting document: \(err)")
                completion(.failure(err))
            } else {
                for document in querySnapshot!.documents {
                    var p = Top(aDoc: document)
                    tops.append(p)
                }
                completion(.success(tops))
            }
        }
    }
    
    func fetchTopMotivos(completion: @escaping (Result<Tops, Error>)-> Void){
        var motivos = [Top]()
        db.collection("globales").document("YyvCoL37678hRbDu0Hu9").collection("motivos").order(by: "valor", descending: true).limit(to: 5).getDocuments{ (querySnapshot, err) in
            if let err = err {
                print("Error getting document: \(err)")
                completion(.failure(err))
            } else {
                for document in querySnapshot!.documents {
                    var p = Top(aDoc: document)
                    motivos.append(p)
                }
                completion(.success(motivos))
            }
        }
    }
    
    func fetchTopIntervenciones(completion: @escaping (Result<Tops, Error>)-> Void){
        var intervenciones = [Top]()
        db.collection("globales").document("YyvCoL37678hRbDu0Hu9").collection("intervencion").order(by: "valor", descending: true).limit(to: 5).getDocuments{ (querySnapshot, err) in
            if let err = err {
                print("Error getting document: \(err)")
                completion(.failure(err))
            } else {
                for document in querySnapshot!.documents {
                    var p = Top(aDoc: document)
                    intervenciones.append(p)
                }
                completion(.success(intervenciones))
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
    
    func fetchTanatologos(completion: @escaping (Result<Usuarios, Error>)-> Void){
        var pacientes = [Usuario]()
        db.collection("users").whereField("rol", isEqualTo: 2).getDocuments{ (querySnapshot, err) in
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
    
    func fetchGlobales(completion: @escaping (Result<[Globales], Error>)-> Void){
        var globales = [Globales]()
        db.collection("globales").getDocuments{ (querySnapshot, err) in
            if let err = err {
                print("Error getting document: \(err)")
                completion(.failure(err))
            } else {
                for document in querySnapshot!.documents {
                    var p = Globales(aDoc: document)
                    globales.append(p)
                }
                completion(.success(globales))
            }
        }
    }
    
    func fetchCuotaGlobal(completion: @escaping (Result<Double, Error>)-> Void){
        var cuota = 0.0
        db.collection("globales").getDocuments{ (querySnapshot, err) in
            if let err = err {
                print("Error getting document: \(err)")
                completion(.failure(err))
            } else {
                for document in querySnapshot!.documents {
                    var p = Globales(aDoc: document)
                    cuota += p.cuota
                }
                completion(.success(cuota))
            }
        }
    }
    
    func fetchCuotaporTanatologo(fechainicio: String, fechafinal: String, completion: @escaping (Result<Double, Error>)-> Void){
        var cuota = 0.0
        db.collection("sesion").whereField("doctor", isEqualTo: "Rita Alcalde").whereField("fecha", in: [fechainicio, fechafinal]).getDocuments{ (querySnapshot, err) in
            if let err = err {
                print("Error getting document: \(err)")
                completion(.failure(err))
            } else {
                for document in querySnapshot!.documents {
                    var p = Sesion(aDoc: document)
                    cuota += p.cuota
                }
                completion(.success(cuota))
            }
        }
    }
    
    func fetchNumUsuariosPorTanatologoEnRangoDeFecha(dateInicio: String, dateFinal: String, completion: @escaping (Result<Int, Error>)-> Void){
            var numero = 0
            var pacientes = [String]()
            db.collection("sesion").order(by: "fecha").start(at: [dateInicio]).end(at: [dateFinal]).getDocuments{ (querySnapshot, err) in
                if let err = err {
                    print("Error getting document: \(err)")
                    completion(.failure(err))
                } else {
                    for document in querySnapshot!.documents {
                        var p = Sesion(aDoc: document)
                        if !pacientes.contains(p.paciente)  {
                            numero += 1
                            pacientes.append(p.paciente)
                        }
                    }
                    completion(.success(numero))
                }
            }
        }

    func updateExpediente(updateExpediente: Sesion, completion: @escaping (Result<String, Error>) -> Void){
        db.collection("sesion").document(updateExpediente.id).updateData([
            "numSesion": updateExpediente.numSesion,
            "numExpediente": updateExpediente.numExpediente,
            "cuota": updateExpediente.cuota,
            "fecha": updateExpediente.fecha,
            "evaluacion": updateExpediente.evaluacion,
            "cierre": updateExpediente.cierre,
            "herramienta": updateExpediente.herramienta,
            "intervencion": updateExpediente.intervencion,
            "motivo": updateExpediente.motivo,
            "tipo": updateExpediente.tipo,
            "doctor": updateExpediente.doctor,
            "paciente": updateExpediente.paciente
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
                completion(.failure(err))
            } else {
                print("Document successfully updated")
                completion(.success("Document successfully updated"))
            }
        }
    }
    
    
    
}
