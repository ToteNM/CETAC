//
//  IndivTanatologoTableViewController.swift
//  CETAC_Servicios
//
//  Created by user193304 on 10/17/21.
//

import UIKit

class IndivTanatologoTableViewController: UITableViewController {
    var individualControlador = fetcherController()
    var cuotas = 0.0
    var nombre = ""
    var fechai = ""
    var fechaf = ""
    var editar = false
    //@IBOutlet weak var individualtableView: UITableView!
    @IBOutlet weak var cuota: UILabel!
    @IBOutlet weak var usuarios: UILabel!
    @IBOutlet weak var fechaInicio: UITextField!
    @IBOutlet weak var fechaFin: UITextField!
    @IBOutlet weak var aceptar: UIButton!
    @IBAction func aceptarTapped(_ sender: UIButton) {
        fechai = fechaInicio.text!
        fechaf = fechaFin.text!
        print("jala1")
        //individualtableView.reloadData()
        print("jala")
        
    }
    @IBAction func editarServicio(_ sender: UIButton) {
        //editar = !editar
        //botones(estado: editar)
        //botones2(estado: editar)
        print("mdmds")
        
       
    }
    
    @IBAction func guardarEdicion(_ sender: UIButton) {
        
        
        editar = !editar
        //botones(estado: editar)
        //boton0.isEnabled = false
        //boton0.isHidden = true
        //let expedienteUpdated = Expediente(id: passDato!.id, nombreUsuario: usuario0.text!, nombreTanatologo: tanatologo0.text!, motivo: motivo0.text!, servicio: servicio0.text!, herramienta: herramienta0.text!, fecha: [0], numExpediente: Int(expedienteNum0.text!)!, numSesion: Int(sesionNum0.text!)!)
        //miFetch.updateExpediente(updateExpediente: expedienteUpdated){ (result) in
        //}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        //individualtableView.dataSource = self
        //individualtableView.delegate = self
        individualControlador.fetchCuotaporTanatologo(fechainicio: fechai, fechafinal: fechaf){ (result) in
            switch result{
            case .success(let cuota):self.updateUI(with: cuota)
            case .failure(let error):self.displayError(error, title: "No se pudo acceder a las sesiones")
            }
        }

    }
    func updateUI(with cuota:Double){
        DispatchQueue.main.async {
            print("cambio")
            self.cuotas = cuota
            self.cuota.text = String(cuota)
            self.tableView.reloadData()
        }
    }
    
    
        
    func displayError(_ error: Error, title: String) {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }

    // MARK: - Table view data source


    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
