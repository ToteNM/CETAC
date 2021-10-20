//
//  TanatologoMainViewController.swift
//  CETAC_Servicios
//
//  Created by Héctor Arturo Noyola Mondragón.  on 18/10/21.
//

import UIKit

class TanatologoMainViewController: UIViewController {
    
    var userID = ""
    var name = ""
    var fetcher = fetcherController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(userID)
        
        fetcher.fetchUsuarioPorCorreo(email: userID){ (result) in
            switch result{
            //Funciona
            case .success(let nombre):self.updateUI(with: nombre)
            case .failure(let error):self.displayError(error, title: "No se pudo acceder a Sesion")
            }
        }
        // Do any additional setup after loading the view.
    }
    
    func displayError(_ error: Error, title: String){
        DispatchQueue.main.async{
            let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func updateUI(with nombre: String) {
        self.name = nombre
        print(name)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "nuevoUsuario"  {
            let navigationContoller = segue.destination as! UINavigationController

            let receiverViewController = navigationContoller.topViewController as! NuevoPacienteTableViewController

            receiverViewController.doctor = name

        }
        
        if segue.identifier == "continuar" {
            let navigationContoller = segue.destination as! UINavigationController

            let receiverViewController = navigationContoller.topViewController as! PacientesTableViewController

            receiverViewController.doctor = name
        }
        
        if segue.identifier == "toExpedientes"  {
            let navigationContoller = segue.destination as! UINavigationController

            let receiverViewController = navigationContoller.topViewController as! ExpedientesTableViewController

            receiverViewController.doctor = name
        }
    }
    

}
