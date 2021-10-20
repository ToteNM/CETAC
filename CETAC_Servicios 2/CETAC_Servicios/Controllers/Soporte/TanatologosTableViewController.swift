//
//  TanatologosTableViewController.swift
//  CETAC_Servicios
//
//  Created by user193304 on 10/16/21.
//

import UIKit

class TanatologosTableViewController: UITableViewController {
    var usuarioControlador = fetcherController()
    var datos = [Usuario]()
    var selectedname = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        /*self.tapGestureRecognizer = UITapGestureRecognizer(target: self, action: action)
        if let tapGestureRecognizer = self.tapGestureRecognizer {
          tapGestureRecognizer.cancelsTouchesInView = false
          self.addGestureRecognizer(tapGestureRecognizer)
        }*/

        usuarioControlador.fetchTanatologos{ (result) in
            switch result{
            case .success(let usuarios):self.updateUI(with: usuarios)
            case .failure(let error):self.displayError(error, title: "No se pudo acceder a los tanatologos")
            }
        }
    }
    
    func updateUI(with usuarios:Usuarios){
        DispatchQueue.main.async {
            self.datos = usuarios
            self.tableView.reloadData()
        }
    }
    func updateUI(){
        
        usuarioControlador.fetchTanatologos{ (result) in
            switch result{
            case .success(let usuarios):self.updateUI(with: usuarios)
            case .failure(let error):self.displayError(error, title: "No se pudo acceder a los tanatologos")
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

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return datos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "zelda", for: indexPath) as! TanatologoTableViewCell

        // Configure the cell...
        let usuario = datos[indexPath.row]
        //cell.stackk.backgroundColor = UIColor(cgColor: UIColor.systemGray.cgColor)
        if usuario.nombre == selectedname {
                    cell.accessoryType = .checkmark
                } else {
                    cell.accessoryType = .none
                }

        cell.update(with: usuario, cont: indexPath.row)
        // Configure the cell...

        return cell
        
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let usuario = datos[indexPath.row]
        /*let cell = tableView.cellForRow(at: indexPath) as! TanatologoTableViewCell
        cell.stackk.backgroundColor = UIColor(cgColor: UIColor.systemGreen.cgColor)*/
        selectedname = usuario.nombre
        tableView.reloadData()

    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TanatologoTableViewCell
        cell.stackk.backgroundColor = UIColor(cgColor: UIColor.systemGray.cgColor)
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
        /*if segue.identifier == "irFechas" {
        let siguiente = segue.destination as! Fechas1ViewController
        siguiente.nombre = self.selectedname
        siguiente.fechai = ""
        siguiente.fechaf = ""
        }*/
        if segue.identifier == "irFechas" {
        let siguiente = segue.destination as! Fechas1ViewController
        siguiente.nombre = self.selectedname
        siguiente.fechai = ""
        siguiente.fechaf = ""
        }
        //let indice = self.tableView.indexPathForSelectedRow?.row
        //siguiente.tanatologo = datos[indice!]
    }
    


}

