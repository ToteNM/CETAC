//
//  CETAC_ServiciosTests.swift
//  CETAC_ServiciosTests
//
//  Created by user193304 on 10/19/21.
//

import XCTest
@testable import CETAC_Servicios
import Firebase

class CETAC_ServiciosTests: XCTestCase {
    var listaPacientes = [Paciente]()
    var listaSesiones = [Sesion]()
    var listaUsuarios = [Usuario]()
    var listaIndicadores = [Indicador]()
    var listaGlobales = [Globales]()
    
    override func setUp() {
        let paciente1 = Paciente(id : String(1), domicilio : "calle Morelos", edad: 33, estadoCivil : "soltero", nombre : "Pablo Gonzalez", numCasa : 8, numCel : 5522996642, numHijos : 2, numExpediente : 2, sexo : "Masculino", ocupacion : "Abogado", procedencia : "Norte", religion : "budista")
        let paciente2 = Paciente(id : String(4), domicilio : "calle Independencia", edad: 24, estadoCivil : "casado", nombre : "Pedro Perez", numCasa : 20, numCel : 5522910879, numHijos : 0, numExpediente : 9, sexo : "Masculino", ocupacion : "Contador", procedencia : "Sur", religion : "católico")
        let paciente3 = Paciente(id: "Aq3NuSHXYF0Y0Cb4zEDk", domicilio: "Calle Prueba # 7", edad: 48, estadoCivil: "Concubinato", nombre: "Jesús Cáceres", numCasa : 5546372819, numCel : 5543787766, numHijos : 2, numExpediente : 5, sexo: "Hombre", ocupacion : "Doctor", procedencia : "Sur", religion: "Judío")
        listaPacientes.append(paciente1)
        listaPacientes.append(paciente2)
        listaPacientes.append(paciente3)
        
        let sesion1 = Sesion(id: "5", numSesion: 3, numExpediente: 8, cuota: 300.0, fecha: "2021/10/12", evaluacion: "Buen trabajo", cierre: false, paciente_id: "8", herramienta : "encuadre", motivo : "comunicacion", tipo : "Servicios Acompanamiento", intervencion : "Acompañamiento Individual", doctor : "Leonardo Morales", paciente : "Rita Alora")
        
        let sesion3 = Sesion(id: "4VhhbT0rBFMFDmDMqQ1K", numSesion: 3, numExpediente: 11, cuota: 100.0, fecha: "2021/10/14", evaluacion : "A", cierre : false, paciente_id: "8", herramienta : "Contención", motivo: "Ansiedad", tipo : "Herramientas alternativas", intervencion : "Acompañamiento Individual", doctor: "Rita Alcalde", paciente : "Miguel Ángel Valdez")

        listaSesiones.append(sesion1)
        listaSesiones.append(sesion3)
        
        let usuario1 = Usuario(apellidos: "Torres", email: "tower@hotmail.com", nombre: "Monica", rol: 3, uid: "50", intervencion: "Tanatologia")
        let usuario2 = Usuario(apellidos: "Morales", email: "leo@hotmail.com", nombre: "Leonardo", rol: 2, uid: "0", intervencion: "Tanatología")

        listaUsuarios.append(usuario1)
        listaUsuarios.append(usuario2)
        
        let indicador1 = Indicador(cuota : 3000, usuariosMes : 20, usuariosSem : 4, usuariosTres : 16)
        let indicador2 = Indicador(cuota : 20000, usuariosMes: 23, usuariosSem: 8, usuariosTres: 15)

        listaIndicadores.append(indicador1)
        listaIndicadores.append(indicador2)
        
        let global1 = Globales(cuota : 5000.0, usuariosAtendidos : 109, expedientesCount : 160)
        let global2 = Globales(cuota : 22780.0, usuariosAtendidos: 14, expedientesCount : 18)

        listaGlobales.append(global1)
        listaGlobales.append(global2)
    }
    
    func testPacientes() throws {
        let paciente = "Jesús Cáceres"
        var encontrado = false
        for pac in listaPacientes {
            if pac.nombre == paciente {
                encontrado = true
            }
        }
        XCTAssertTrue(encontrado)
    }
    
    func testSesiones() throws {
        let sesion = "4VhhbT0rBFMFDmDMqQ1K"
        var encontrado = false
        for iid in listaSesiones {
            if iid.id == sesion {
                encontrado = true
            }
        }
        XCTAssertTrue(encontrado)
    }
    
    func testUsuarios() throws {
        let email = "leo@hotmail.com"
        var encontrado = false
        for ema in listaUsuarios {
            if ema.email == email {
                encontrado = true
            }
        }
        XCTAssertTrue(encontrado)
    }
    
    func testIndicadores() throws {
        let cuota = 20000
        var encontrado = false
        for cuo in listaIndicadores {
            if cuo.cuota == cuota {
                encontrado = true
            }
        }
        XCTAssertTrue(encontrado)
    }
    
    func testGlobales() throws {
        let usuariosAtendid = 14
        var encontrado = false
        for usuarios in listaGlobales {
            if usuarios.usuariosAtendidos == usuariosAtendid {
                encontrado = true
            }
        }
        XCTAssertTrue(encontrado)
    }
    
    func testVisualizarUsuarios() throws {
            let fetcher = fetcherController()
            var usuariosGot = false
            fetcher.fetchUsuarios{ (result) in
                switch result{
                //Funciona
                case .success(let sesiones): usuariosGot = true
                case .failure(let error): usuariosGot = false
                }
            }
            let seconds = 7.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                XCTAssertTrue(usuariosGot)
            }
      }
    
    func testCambiarValorDeCerradoAVerdadero() throws {
            let fetcher = fetcherController()
            let db = Firestore.firestore()
            let patientId = "XtZLymaoobyluvwpZO4n"
            var cambio = false
            db.collection("paciente").document(patientId).updateData([
                "cierre": true
            ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document updated")
                    cambio = true
                }
            }
            let seconds = 7.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                XCTAssertTrue(cambio)
            }
        }
    
    func testAnadirSesion() throws {
        var added = false
        let db = Firestore.firestore()
        db.collection("indicadores").addDocument(data: [
            "cuota" : 6000,
            "doctor": "Jonathan",
            "usuariosMes": 10,
            "usuariosSem": 2,
            "usuariosTres": 6,
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added")
                added = true
            }
        }
        let seconds = 7.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            XCTAssertTrue(added)
        }
    }


    


    
}

