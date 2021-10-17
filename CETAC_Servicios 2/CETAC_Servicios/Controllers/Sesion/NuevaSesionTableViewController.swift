//
//  NuevaSesionTableViewController.swift
//  CRUDTanatologos
//
//  Created by Héctor Arturo Noyola Mondragón.  on 06/10/21.
//

import UIKit
import Firebase

class NuevaSesionTableViewController: UITableViewController, HerramientaTableViewControllerDelegate, IntervencionTableViewControllerDelegate, MotivoTableViewControllerDelegate, TipoTableViewControllerDelegate, UITextViewDelegate {
    
    func tipoTableViewController(_ controller: TipoTableViewController, didSelect tipo: String) {
        self.tipo = tipo
        updateTipo()
        updateAceptarButton()
    }

    func herramientaTableViewController(_ controller: HerramientaTableViewController, didSelect herramienta: String) {
        self.herramienta = herramienta
        updateHerramienta()
        updateAceptarButton()
    }
    
    func intervencionTableViewController(_ controller: IntervencionTableViewController, didSelect intervencion: String) {
        self.intervencion = intervencion
        updateIntervencion()
        updateAceptarButton()
    }
    
    func motivoTableViewController(_ controller: MotivoTableViewController, didSelect motivo: String) {
        self.motivo = motivo
        updateMotivo()
        updateAceptarButton()
    }
    
    var herramienta: String?
    var intervencion: String?
    var motivo: String?
    var tipo : String?
    var nombre = "Nombre vacío"
    var cierre = true
    var fetcher = fetcherController()
    var numSesiones = 0
    var cuotaGlobal = 0.0
    var patientId : String?
    
    @IBOutlet weak var nombreUsuario: UILabel!
    @IBOutlet weak var aceptarButton: UIBarButtonItem!
    @IBOutlet weak var tipoDetail: UILabel!
    @IBOutlet weak var motivoDetail: UILabel!
    @IBOutlet weak var intervencionDetail: UILabel!
    @IBOutlet weak var herramientaDetail: UILabel!
    @IBOutlet weak var cierreSwitch: UISwitch!
    @IBOutlet weak var evaluacionText: UITextView!
    @IBOutlet weak var cuota: UITextField!
    
    
    @IBSegueAction func selectHerramienta(_ coder: NSCoder) -> UITableViewController? {
        let herramientaController = HerramientaTableViewController(coder: coder)
        herramientaController?.delegate = self
        herramientaController?.herramientaSelect = herramienta
        
        return herramientaController
    }
    
    @IBSegueAction func selectIntervencion(_ coder: NSCoder) -> UITableViewController? {
        let intervencionController = IntervencionTableViewController(coder: coder)
        intervencionController?.delegate = self
        intervencionController?.intervencionSelect = intervencion
        
        return intervencionController
    }
    
    @IBSegueAction func selectMotivo(_ coder: NSCoder) -> UITableViewController? {
        let motivoController = MotivoTableViewController(coder: coder)
        motivoController?.delegate = self
        motivoController?.motivoSelect = motivo
        
        return motivoController
        
    }
    
    @IBSegueAction func selectTipo(_ coder: NSCoder) -> UITableViewController? {
        let tipoController = TipoTableViewController(coder: coder)
        tipoController?.delegate = self
        tipoController?.tipoSelect = tipo
        
        return tipoController
    }
    
    /*
    @IBAction func ocultarTeclado(_ sender: UITapGestureRecognizer) {
        evaluacionText.resignFirstResponder()
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetcher.fetchNumSesionesPorNombreDePaciente(paciente: nombre){ (result) in
            switch result{
            //Funciona
            case .success(let sesiones):self.updateUI(with: sesiones)
            case .failure(let error):self.displayError(error, title: "No se pudo acceder a Sesion")
            }
        }
        
        fetcher.fetchGlobales { (result) in
            switch result{
            //Funciona
            case .success(let globales):self.updateUI2(with: globales)
            case .failure(let error):self.displayError(error, title: "No se pudo acceder a Sesion")
            }
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

            //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
            tap.cancelsTouchesInView = false

        view.addGestureRecognizer(tap)
        
        updateHerramienta()
        updateIntervencion()
        updateMotivo()
        updateTipo()
        updateAceptarButton()
        evaluacionText.delegate = self
        nombreUsuario.text = nombre
        cierreSwitch.isOn = false

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func updateUI(with sesiones: Int){
        DispatchQueue.main.async {
            self.numSesiones = sesiones
            print(self.numSesiones)
        }
    }
    
    func updateUI2(with globales: [Globales]){
        DispatchQueue.main.async {
            self.cuotaGlobal = globales[0].cuota
            print(self.cuotaGlobal)
        }
    }
    
    func displayError(_ error: Error, title: String){
        DispatchQueue.main.async{
            let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func cierreSwitchChanged(_ sender: Any) {
        cierre = cierreSwitch.isOn
    }
    
    func updateHerramienta() {
        if let herramienta = herramienta {
            herramientaDetail.text = herramienta
        } else {
            herramientaDetail.text = "Not set"
        }
    }
    
    func updateIntervencion() {
        if let intervencion = intervencion {
            intervencionDetail.text = intervencion
        } else {
            intervencionDetail.text = "Not set"
        }
    }
    
    func updateMotivo() {
        if let motivo = motivo {
            motivoDetail.text = motivo
        } else {
            motivoDetail.text = "Not set"
        }
    }
    
    func updateTipo() {
        if let tipo = tipo {
            tipoDetail.text = tipo
        } else {
            tipoDetail.text = "Not set"
        }
    }
    
    func updateAceptarButton() {
        let herr = herramientaDetail.text ?? ""
        let inter = intervencionDetail.text ?? ""
        let motiv = motivoDetail.text ?? ""
        let tipo = tipoDetail.text ?? ""
        let eval = evaluacionText.text ?? ""
        let cuota = Double(self.cuota.text!) ?? -1
        aceptarButton.isEnabled = herr != "Not set" && inter != "Not set" && motiv != "Not set" && tipo != "Not set" && !eval.isEmpty && cuota > 0.0
    }
    
    func textViewDidChange(_ textView: UITextView) {
        updateAceptarButton()
    }
    
    @IBAction func textFieldDidChange(_ sender: UITextField) {
        updateAceptarButton()
    }
    
    
    var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        return dateFormatter
    }()
    
    @IBAction func aceptarButtonTapped(_ sender: Any) {
        let herr = herramientaDetail.text ?? ""
        let inter = intervencionDetail.text ?? ""
        let motiv = motivoDetail.text ?? ""
        let tipo = tipoDetail.text ?? ""
        let eval = evaluacionText.text ?? ""
        let cierre = cierreSwitch.isOn
        let nombre = nombreUsuario.text ?? ""
        let cuota = Double(self.cuota.text!) ?? -1
        let db = Firestore.firestore()
        let today = Date()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let fecha = dateFormatter.string(from: today)
        var ref: DocumentReference? = nil
        ref = db.collection("sesion").addDocument(data: [
            "doctor": "Rita Alcalde",
            "evaluacion": eval,
            "fecha": fecha,
            "herramienta": herr,
            "intervencion": inter,
            "motivo": motiv,
            "numSesion": numSesiones+1,
            "paciente": nombre,
            "tipo": tipo,
            "cuota": cuota
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        db.collection("paciente").document(patientId!).updateData([
            "cierre": cierre
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document paciente updated")
            }
        }
        db.collection("globales").document("YyvCoL37678hRbDu0Hu9").updateData([
            "cuota": self.cuotaGlobal + cuota
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document globales updated")
            }
        }
        performSegue(withIdentifier: "unwind", sender: aceptarButton )
    }

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
