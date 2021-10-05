//
//  InicioUsuarioViewController.swift
//  CETAC_Servicios
//
//  Created by user193304 on 10/5/21.
//

import UIKit

class InicioUsuarioViewController: UIViewController {

    @IBOutlet weak var signup: UIButton!
    @IBOutlet weak var login: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements() {
        Utilities.styleFilledButton(signup)
        Utilities.styleHollowButton(login)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
