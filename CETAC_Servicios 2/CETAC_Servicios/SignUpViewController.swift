//
//  SignUpViewController.swift
//  CETAC_Servicios
//
//  Created by user193304 on 10/5/21.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var nombreField: UITextField!
    @IBOutlet weak var apellidosField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signup: UIButton!
    @IBOutlet weak var error: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    func setUpElements() {
        //Esconder el error
        error.alpha = 0
        
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

    @IBAction func signupTapped(_ sender: Any) {
    }
    
    
}
