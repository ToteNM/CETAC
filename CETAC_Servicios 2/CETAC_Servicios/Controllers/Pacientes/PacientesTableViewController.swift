//
//  PacientesTableViewController.swift
//  CRUDTanatologos
//
//  Created by Héctor Arturo Noyola Mondragón.  on 06/10/21.
//

import UIKit

class PacientesTableViewController: UITableViewController {
    
    var fetcher = fetcherController()
    var datos = [Paciente]()
    var selectedName = "Nombre de ejemplo"
    var selectedID = "ID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetcher.fetchPacientes{ (result) in
            switch result{
            //Funciona
            case .success(let pacientes):self.updateUI(with: pacientes)
            case .failure(let error):self.displayError(error, title: "No se pudo acceder a Sesion")
            }
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func updateUI(with pacientes: Pacientes){
        DispatchQueue.main.async {
            self.datos = pacientes
            self.tableView.reloadData()
        }
    }
    
    func displayError(_ error: Error, title: String){
        DispatchQueue.main.async{
            let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return datos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PacienteCell", for: indexPath) as! PacienteTableViewCell
        
        let paciente = datos[indexPath.row]
        
        if paciente.nombre == selectedName {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        cell.update(with: paciente)
        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let paciente = datos[indexPath.row]
        selectedName = paciente.nombre
        selectedID = paciente.id
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "toExpediente" {
            let siguienteVista = segue.destination as! NuevaSesionTableViewController
            print(selectedName)
            siguienteVista.nombre = self.selectedName
            siguienteVista.patientId = self.selectedID
        }
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
