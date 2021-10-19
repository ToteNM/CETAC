//
//  Fechas1ViewController.swift
//  CETAC_Servicios
//
//  Created by user193304 on 10/18/21.
//

import UIKit

class Fechas1ViewController: UIViewController {

    var nombre = ""
    var fechai = ""
    var fechaf = ""
    
    @IBOutlet weak var fechainicio: UITextField!
    @IBOutlet weak var fechafin: UITextField!
    @IBOutlet weak var continuar: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "irIndividual" {
        let siguiente = segue.destination as! IndivTanatologoTableViewController
        siguiente.fechai = self.fechainicio.text!
        siguiente.fechaf = self.fechafin.text!
        }
        
    }
}
