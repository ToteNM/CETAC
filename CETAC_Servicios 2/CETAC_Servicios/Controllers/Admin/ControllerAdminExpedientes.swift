//
//  adminControll.swift
//  CETAC_Servicios
//
//  Created by user193524 on 10/18/21.
//

import Foundation
//
//  UsuarioTableViewController.swift
//  CETAC_Servicios
//
//  Created by user193304 on 10/16/21.
//

import UIKit

class ControllerAdminExpedientes: UITableViewController {
    var sesiones: Sesion?
    var editar = false
    //button
    
    @IBOutlet weak var modificar: UIButton!
    //#
    
    @IBOutlet weak var nombre_: UITextField!
    @IBOutlet weak var num_expediente: UILabel!
    @IBOutlet weak var num_sesion: UILabel!
    @IBOutlet weak var motivo: UILabel!
    @IBOutlet weak var servicio: UILabel!
    @IBOutlet weak var intervencion: UILabel!
    @IBOutlet weak var herramienta: UILabel!
    @IBOutlet weak var doctor: UILabel!
    @IBOutlet weak var fecha: UILabel!
    @IBOutlet weak var cuota: UILabel!
    @IBOutlet weak var cierre: UILabel!
    @IBOutlet weak var evaluacion: UITextView!
    
    var selectedid: String = "idd"
    var selecteddoctor : String = "doc"
    var selectedpaciente : String = "pac"
    var selectednumSesion: Int = 0
    var selectednumExpediente: Int = 0
    var selectedcuota: Double = 0.0
    var selectedfecha: String = "fecha"
    var selectedevaluacion: String = "eva"
    var selectedcierre: Bool = false
    var selectedherramienta : String = "herr"
    var selectedmotivo : String = "motivo"
    var selectedtipo : String = "tipo"
    var selectedintervencion : String = "inter"
    
    @IBAction func editarServicio(_ sender: UIButton) {
        //editar = !editar
        //botones(estado: editar)
        //botones2(estado: editar)
        print("mdmds")
        nombre_.isUserInteractionEnabled = true
        nombre_.backgroundColor = UIColor.systemGray5
        //modificar.currentBackgroundImage = UIImage.init(systemName: "lock.open")
        let imgae = UIImage.init(systemName: "lock.open")
        //modificar.currentBackgroundImage = imgae
        modificar.setBackgroundImage(imgae, for: .normal)
        //modificar.setBackgroundImage(image: UIImage.init(), for: )
        
        
        
        
        
        
        
        
       
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
        nombre_.text = selectedpaciente
        num_sesion.text = String(selectednumSesion)
        num_expediente.text = String(selectednumExpediente)
        cuota.text = String(selectedcuota)
        motivo.text = selectedmotivo
        servicio.text = selectedherramienta
        intervencion.text = selectedintervencion
        herramienta.text = selectedherramienta
        doctor.text = selecteddoctor
        fecha.text = selectedfecha
        evaluacion.text = selectedevaluacion
        if selectedcierre == false {
            cierre.text = "Abierto"
        } else {
            cierre.text = "Cerrado"
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        /*expedienteControlador.fetchServicios{ (result) in
            switch result{
            case .success(let sesiones):self.updateUI(with: sesiones)
            case .failure(let error):self.displayError(error, title: "No se pudo acceder a las sesiones")
            }
        }*/
    
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

