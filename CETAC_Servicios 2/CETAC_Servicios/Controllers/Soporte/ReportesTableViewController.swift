//
//  ReporteTableViewController.swift
//  CETAC_Servicios
//
//  Created by user193304 on 10/16/21.
//

import UIKit
import Firebase

class ReportesTableViewController: UITableViewController {
    var expedienteControlador = fetcherController()
    var datos = [Sesion]()
    var selectedid: String = "id"
    var selecteddoctor : String = "doctor"
    var selectedpaciente : String = "paciente"
    var selectednumSesion: Int = 0
    var selectedfecha: String = ""
    var selectedevaluacion: String = ""
    var selectednumExpediente : Int = 0
    var selectedcouta : Double = 0.0
    var selectedcierre: Bool = false
    var selectedherramienta : String = ""
    var selectedmotivo : String = ""
    var selectedtipo : String = ""
    var selectedintervencion : String = ""
    //var selectedcuota : Int?
    @IBOutlet weak var continuar: UIBarButtonItem!
    @IBAction func tapContinuar(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "irUsuario", sender: continuar )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        expedienteControlador.fetchServicios{ (result) in
            switch result{
            case .success(let sesiones):self.updateUI(with: sesiones)
            case .failure(let error):self.displayError(error, title: "No se pudo acceder a las sesiones")
            }
        }
        

    }
    func updateUI(with sesiones:Sesiones){
        DispatchQueue.main.async {
            self.datos = sesiones
            self.tableView.reloadData()
        }
    }
    func updateUI(){
        
        expedienteControlador.fetchServicios{ (result) in
            switch result{
            case .success(let sesiones):self.updateUI(with: sesiones)
            case .failure(let error):self.displayError(error, title: "No se pudo acceder a las sesiones")
            }
            
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

     override   func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

     override   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return datos.count
    }
        
        

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celula", for: indexPath) as! ExpedienteTableViewCell

        let sesiones = datos[indexPath.row]
        if sesiones.id == selectedid {
                    cell.accessoryType = .checkmark
                } else {
                    cell.accessoryType = .none
                }

        cell.update(with: sesiones)
        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sesiones = datos[indexPath.row]
        selectedid = sesiones.id
        selecteddoctor = sesiones.doctor
        selectedpaciente = sesiones.paciente
        selectednumSesion = sesiones.numSesion
        selectednumExpediente = sesiones.numExpediente
        selectedcouta = sesiones.cuota
        selectedfecha = sesiones.fecha
        selectedevaluacion = sesiones.evaluacion
        selectedcierre = sesiones.cierre
        selectedherramienta = sesiones.herramienta
        selectedmotivo = sesiones.motivo
        selectedtipo = sesiones.tipo
        selectedintervencion = sesiones.intervencion
        tableView.reloadData()
    }

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "irUsuario" {
        let siguiente = segue.destination as! UsuarioTableViewController
            siguiente.selectedid = self.selectedid
            siguiente.selecteddoctor = self.selecteddoctor
            siguiente.selectedpaciente = self.selectedpaciente
            siguiente.selectednumSesion = self.selectednumSesion
            siguiente.selectednumExpediente = self.selectednumExpediente
            siguiente.selectedcuota = self.selectedcouta
            siguiente.selectednumSesion = self.selectednumSesion
            siguiente.selectedfecha = self.selectedfecha
            siguiente.selectedevaluacion = self.selectedevaluacion
            siguiente.selectedcierre = self.selectedcierre
            siguiente.selectedherramienta = self.selectedherramienta
            siguiente.selectedmotivo = self.selectedmotivo
            siguiente.selectedtipo = self.selectedtipo
            siguiente.selectedintervencion = self.selectedintervencion
        //let indice = self.tableView.indexPathForSelectedRow?.row
        //siguiente.sesiones = datos[indice!]
        }else if segue.identifier == "irUsuario_"{
            
            let siguiente = segue.destination as! ControllerAdminExpedientes
                siguiente.selectedid = self.selectedid
                siguiente.selecteddoctor = self.selecteddoctor
                siguiente.selectedpaciente = self.selectedpaciente
                siguiente.selectednumSesion = self.selectednumSesion
                siguiente.selectednumExpediente = self.selectednumExpediente
                siguiente.selectedcuota = self.selectedcouta
                siguiente.selectednumSesion = self.selectednumSesion
                siguiente.selectedfecha = self.selectedfecha
                siguiente.selectedevaluacion = self.selectedevaluacion
                siguiente.selectedcierre = self.selectedcierre
                siguiente.selectedherramienta = self.selectedherramienta
                siguiente.selectedmotivo = self.selectedmotivo
                siguiente.selectedtipo = self.selectedtipo
                siguiente.selectedintervencion = self.selectedintervencion
            
        }
    }
    

}

