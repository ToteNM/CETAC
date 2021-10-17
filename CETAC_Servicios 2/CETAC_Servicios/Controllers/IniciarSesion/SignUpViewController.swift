//
//  SignUpViewController.swift
//  CETAC_Servicios
//
//  Created by user193304 on 10/5/21.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {
    @IBOutlet weak var nombreField: UITextField!
    @IBOutlet weak var apellidosField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var intervencionField: UITextField!
    @IBOutlet weak var rolField: UITextField!
    @IBOutlet weak var signup: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBAction func intervencionTap(_ sender: UITextField) {
    }
    
    
    var pasarUID = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

                    //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
                    tap.cancelsTouchesInView = false

                view.addGestureRecognizer(tap)

        setUpElements()
    }
    
    func mostrarAlerta(_ error:String){
        let alerta = UIAlertController(title: "Aviso", message: error, preferredStyle: .alert)
        alerta.addAction(UIAlertAction(title: "Cerrar", style: .cancel, handler: { action in
            print("Cerrar")
        }))
        present(alerta, animated: true)
    }
    
    @objc func dismissKeyboard() {
            //Causes the view (or one of its embedded text fields) to resign the first responder status.
            view.endEditing(true)
        }

    func setUpElements() {
        //Esconder el error
        errorLabel.alpha = 0
        
        //Estilo a los elementos
        Utilities.styleTextField(nombreField)
        Utilities.styleTextField(apellidosField)
        Utilities.styleTextField(emailField)
        Utilities.styleTextField(passwordField)
        Utilities.styleFilledButton(signup)
        Utilities.styleTextField(rolField)
        Utilities.styleTextField(intervencionField)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func validateFields() -> String? {
        
        // Checar que los campos esten completos
        if nombreField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || apellidosField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || intervencionField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || rolField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            mostrarAlerta("Por favor, llena todos los campos")
        }
        // checar si la contraseña es segura
        let cleanedPassword = passwordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            //Contraseña no es segura
            mostrarAlerta("Por favor, asegurate de que tu contraseña contenga al menos 8 caracteres, contenga un caracter especial y un número")
        }
        
        return nil
    }
    
    @IBAction func signupTapped(_ sender: Any) {
        // Validar los campos
        let error = validateFields()
        
        if error != nil {
            //Hay algo malo con los campos, muestra el mensaje de error
            //showError(error!)
            mostrarAlerta(error!)
            
        }
        else {
            // Crear variables
            let nombre = nombreField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let apellidos = apellidosField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let intervencion = intervencionField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let rol = String(rolField.text!.trimmingCharacters(in: .whitespacesAndNewlines))
            let rolnum = Int(rol) ?? 0
            // Crear el usuario
            
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                // Checar errores
                
                if err != nil{
                    self.mostrarAlerta("Error creando usuario")
                }
                else {
                    
                    //self.pasarUID = result!.user.uid
                    
                    let db = Firestore.firestore()
                     db.collection("users").document(result!.user.uid).setData(["nombre":nombre, "apellidos":apellidos, "rol":rolnum, "intervencion":intervencion, "email": email]) { (error) in
                        if error != nil{
                            self.mostrarAlerta("Cuenta creada con exito!")
                            //return
                        } 
                        
                    }
                   
                    self.mostrarAlerta("Usuario Creado")
                }
                
            }
            
        }
        
    }
    func showError(_ message:String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }


}
