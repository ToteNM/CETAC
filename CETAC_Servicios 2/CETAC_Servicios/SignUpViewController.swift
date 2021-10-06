//
//  SignUpViewController.swift
//  CETAC_Servicios
//
//  Created by user193304 on 10/5/21.
//

import UIKit
//import FirebaseAuth

class SignUpViewController: UIViewController {
    @IBOutlet weak var nombreField: UITextField!
    @IBOutlet weak var apellidosField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signup: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
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
        if nombreField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || apellidosField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Por favor, llena todos los campos"
        }
        // checar si la contraseña es segura
        let cleanedPassword = passwordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            //Contraseña no es segura
            return "Por favor, asegurate de que tu contraseña contenga al menos 8 caracteres, contenga un caracter especial y un número"
        }
        
        return nil
    }
    
    @IBAction func signupTapped(_ sender: Any) {
        // Validar los campos
        let error = validateFields()
        
        if error != nil {
            //Hay algo malo con los campos, muestra el mensaje de error
            showError(error!)
            
        }
        else {
            // Crear el usuario
            
            // Transicion a la pantalla
        }
        
    }
    func showError(_ message:String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
}
