//
//  LogInViewController.swift
//  CETAC_Servicios
//
//  Created by user193304 on 10/5/21.
//

import UIKit
import FirebaseAuth

class LogInViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    var usuariosCuenta = UsersController()
    var pasarUID = ""
    var email = ""
    var roles = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailField.delegate = self
        passwordField.delegate = self
        // Do any additional setup after loading the view.
        
        setUpElements()
    }
    func setUpElements() {
        //Esconder el error
        errorLabel.alpha = 0
        
        //Estilo a los elementos
        Utilities.styleTextField(emailField)
        Utilities.styleTextField(passwordField)
        Utilities.styleFilledButton(login)
    }

    
    
    @IBAction func loginTapped(_ sender: Any) {
        //Validar los campos
        
        // Crear los text fiel en blanco
        let email = emailField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Sign in con el usuario
        Auth.auth().signIn(withEmail: email, password: password) { [self]
            (result, error) in
            
            if error != nil {
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
                return
            }
            self.pasarUID = result!.user.uid
            self.email = result!.user.email!
            
            self.usuariosCuenta.leerUsuario(id: self.pasarUID) {(nombre, email, rol) in
                self.roles = rol
                if rol == 1 {
                    self.performSegue(withIdentifier: "irAdmin", sender: self)
                    return
                }
                if rol == 2 {
                    self.performSegue(withIdentifier: "irTanatologos", sender: self)
                    return
                }
                if rol == 3 {
                    self.performSegue(withIdentifier: "irSoporte", sender: self)
                    return
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "irTanatologos" {
            let siguienteVista = segue.destination as! TanatologoMainViewController
            siguienteVista.userID = self.email
        }
    }
}
