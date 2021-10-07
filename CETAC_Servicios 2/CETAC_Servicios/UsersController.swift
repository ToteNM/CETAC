//
//  UsersController.swift
//  CETAC_Servicios
//
//  Created by user193304 on 10/6/21.
//

import Foundation
import Firebase
import FirebaseFirestore

/*struct Usuario: Codable {
    let id:String
    let nombre, email: String
    let rol: Int
    init(nombre:String, email:String, rol: Int){
        self.nombre = nombre
        self.email  = email
        self.rol = rol
        id = "1234"
    }
    init(id:String, nombre:String, email:String, rol: Int){
        self.id = id
        self.nombre = nombre
        self.email  = email
        self.rol = rol
    }
    init(aDoc: DocumentSnapshot){
        self.id = aDoc.documentID
        self.nombre = aDoc.get("nombre") as? String ?? "" //?? operador terciario
        self.email = aDoc.get("email") as? String ?? ""
        self.rol = aDoc.get("rol") as? Int ?? 0
    }
}

typealias Usuarios = [Usuario]*/
class UsersController{
    func leerUsuario (id:String, completion: @escaping (String, String, Int) -> Void){
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(id)
        docRef.getDocument { (document, error) in
            if let document = document{
                /*let email = document.get("email") as? String ?? ""
                let nombre = document.get("nombre") as? String ?? ""
                let rol = document.get("rol") as? Int ?? 0*/
                //let nombre = document.get("nombre") as! String
                let nombre = document.get("nombre") as! String
                
                let email = document.get("email") as! String
                
                let rol = document.get("rol") as! Int
                completion(nombre,email,rol)
            }
        }
    }
}
