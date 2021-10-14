//
//  NuevoPacienteTableViewController.swift
//  CRUDTanatologos
//
//  Created by Héctor Arturo Noyola Mondragón.  on 04/10/21.
//

import UIKit
import Firebase
import grpc

class NuevoPacienteTableViewController: UITableViewController, ProcedenciaTableViewControllerDelegate, ReligionTableViewControllerDelegate, SexoTableViewControllerDelegate, EstadoCivilTableViewControllerDelegate, UITextFieldDelegate {
    
    func estadoCivilTableViewController(_ controller: EstadoCivilTableViewController, didSelect estadoCivil: String) {
        self.estadoCivil = estadoCivil
        updateEstadoCivil()
        updateContinuarButton()
    }
    
    func procedenciaTableViewController(_ controller: ProcedenciaTableViewController, didSelect estado: String) {
        self.estado = estado
        updateProcedencia()
        updateContinuarButton()
    }
    
    func religionTableViewController(_ controller: ReligionTableViewController, didSelect religion: String) {
        self.religion = religion
        updateReligion()
        updateContinuarButton()
    }
    
    func sexoTableViewController(_ controller: SexoTableViewController, didSelect sexo: String) {
        self.sexo = sexo
        updateSexo()
        updateContinuarButton()
    }
    
    @IBOutlet weak var continuarButton: UIBarButtonItem!
    var estado: String?
    var religion: String?
    var sexo: String?
    var estadoCivil : String?
    var patientId : String?

    @IBOutlet weak var estadoCivilDetailLabel: UILabel!
    @IBOutlet weak var sexoDetailLabel: UILabel!
    @IBOutlet weak var religionDetailLabel: UILabel!
    @IBOutlet weak var procedenciaDetailLabel: UILabel!
    @IBOutlet weak var fechaLabel: UILabel!
    @IBOutlet weak var fechaPicker: UIDatePicker!
    @IBOutlet weak var nombre: UITextField!
    @IBOutlet weak var numCasa: UITextField!
    @IBOutlet weak var telCelular: UITextField!
    @IBOutlet weak var domicilio: UITextField!
    @IBOutlet weak var hijosStepperLabel: UILabel!
    @IBOutlet weak var hijosStepper: UIStepper!
    @IBOutlet weak var ocupacionLabel: UITextField!
    
    @IBSegueAction func selectProcedencia(_ coder: NSCoder) -> ProcedenciaTableViewController? {
        let procedenciaController = ProcedenciaTableViewController(coder: coder)
        procedenciaController?.delegate = self
        procedenciaController?.estadoSelect = estado
        
        return procedenciaController
    }
    @IBSegueAction func selectReligion(_ coder: NSCoder) -> ReligionTableViewController? {
        let religionController = ReligionTableViewController(coder: coder)
        religionController?.delegate = self
        religionController?.religionSelect = religion
        
        return religionController
    }
    
    @IBSegueAction func selectSexo(_ coder: NSCoder) -> UITableViewController? {
        let sexoController = SexoTableViewController(coder: coder)
        sexoController?.delegate = self
        sexoController?.sexoSelect = sexo
        
        return sexoController
    }
    @IBSegueAction func selectEstadoCivil(_ coder: NSCoder) -> EstadoCivilTableViewController? {
        let estadoCivilController = EstadoCivilTableViewController(coder: coder)
        estadoCivilController?.delegate = self
        estadoCivilController?.estadoCivilSelect = estadoCivil
        
        return estadoCivilController
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        updateDateViews()
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        updateHijos()
    }
    
    /*
    @IBAction func ocultarTeclado(_ sender: UITapGestureRecognizer) {
        print("Tapped")
        nombre.resignFirstResponder()
        numCasa.resignFirstResponder()
        telCelular.resignFirstResponder()
        ocupacionLabel.resignFirstResponder()
        domicilio.resignFirstResponder()
    */
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let midnightToday = Calendar.current.startOfDay(for: Date())
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

            //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
            tap.cancelsTouchesInView = false

        view.addGestureRecognizer(tap)
        
        fechaPicker.maximumDate = midnightToday
        fechaPicker.date = midnightToday
        updateDateViews()
        updateHijos()
        updateProcedencia()
        updateReligion()
        updateSexo()
        updateEstadoCivil()
        updateContinuarButton()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        return dateFormatter
    }()
    
    func updateProcedencia() {
        if let estado = estado {
            procedenciaDetailLabel.text = estado
        } else {
            procedenciaDetailLabel.text = "Not set"
        }
    }
    
    func updateReligion() {
        if let religion = religion {
            religionDetailLabel.text = religion
        } else {
            religionDetailLabel.text = "Not set"
        }
    }
    
    func updateSexo() {
        if let sexo = sexo {
            sexoDetailLabel.text = sexo
        } else {
            sexoDetailLabel.text = "Not set"
        }
    }
    
    func updateEstadoCivil() {
        if let estadoCivil = estadoCivil {
            estadoCivilDetailLabel.text = estadoCivil
        } else {
            estadoCivilDetailLabel.text = "Not set"
        }
    }
    
    func updateDateViews() {
        fechaLabel.text = dateFormatter.string(from: fechaPicker.date)
    }
    
    func updateHijos() {
        hijosStepperLabel.text = "\(Int(hijosStepper.value))"
    }
    
    func updateContinuarButton() {
        let nombre = nombre.text ?? ""
        let numCasa = Int(numCasa.text!) ?? -1
        let telCelular = Int(telCelular.text!) ?? 0
        let domicilio = domicilio.text ?? ""
        let fecha = fechaLabel.text ?? ""
        //let hijos = Int(hijosStepper.value)
        let procedencia = procedenciaDetailLabel.text
        let religion = religionDetailLabel.text
        let sexo = sexoDetailLabel.text
        let estadoCivil = estadoCivilDetailLabel.text
        continuarButton.isEnabled = !nombre.isEmpty && numCasa > -1 && telCelular > -1 && !domicilio.isEmpty && !fecha.isEmpty && procedencia != "Not set" && religion != "Not set" && sexo != "Not set" && estadoCivil != "Not set"
    }
    
    @IBAction func textEditingChanged(_ sender: UITextField){
        updateContinuarButton()
    }

    @IBAction func continuarButtonTapped(_ sender: Any) {
        let nombre = nombre.text ?? ""
        let numCasa = Int(numCasa.text!) ?? -1
        let telCelular = Int(telCelular.text!) ?? 0
        let domicilio = domicilio.text ?? ""
        let fecha = fechaLabel.text ?? ""
        let hijos = Int(hijosStepper.value)
        let procedencia = procedenciaDetailLabel.text ?? ""
        let religion = religionDetailLabel.text ?? ""
        let sexo = sexoDetailLabel.text ?? ""
        let ocupacion = ocupacionLabel.text ?? ""
        let estadoCivil = estadoCivilDetailLabel.text ?? ""
        
        let calendar = Calendar.current
        // Replace the hour (time) of both dates with 00:00
        let today = Date()
        let date1 = calendar.startOfDay(for: fechaPicker.date)
        let date2 = calendar.startOfDay(for: today)

        let components = calendar.dateComponents([.year], from: date1, to: date2)
        let edad = components.year!
        
        print("Done tapped")
        print("Nombre: \(nombre)")
        print("Número de casa: \(numCasa)")
        print("Teléfono celular: \(telCelular)")
        print("Domicilio: \(domicilio)")
        print("Fecha de Nacimiento: \(fecha)")
        print("Edad: \(edad)")
        print("Hijos: \(hijos)")
        print("Procedencia: \(procedencia)")
        print("Religion: \(religion)")
        print("Sexo: \(sexo)")
        print("Estado Civil: \(estadoCivil)")
        
        let db = Firestore.firestore()
        var ref: DocumentReference? = nil
        ref = db.collection("paciente").addDocument(data: [
            "domicilio": domicilio,
            "edad": edad,
            "estadoCivil": estadoCivil,
            "nombre": nombre,
            "numCasa": numCasa,
            "numCelular": telCelular,
            "numHijos": hijos,
            "ocupacion": ocupacion,
            "procedencia": procedencia,
            "religion": religion,
            "sexo": sexo,
            "cierre": false
        ])
            { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        
        patientId = ref?.documentID
        
        if hijos > 0 {
            performSegue(withIdentifier: "addHijos", sender: continuarButton)
        } else {
            performSegue(withIdentifier: "toExpediente", sender: continuarButton)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "toExpediente" {
            let siguienteVista = segue.destination as! NuevaSesionTableViewController
            siguienteVista.nombre = self.nombre.text!
            siguienteVista.patientId = self.patientId!
        }
        else if segue.identifier == "addHijos" {
            let siguienteVista = segue.destination as! AddHijosTableViewController
            siguienteVista.numHijos = Int(hijosStepper.value)
            siguienteVista.padre = nombre.text ?? ""
            siguienteVista.patientId = self.patientId!
        }
    }
    // MARK: - Table view data source


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
