//
//  adminControll.swift
//  CETAC_Servicios
//
//  Created by user193524 on 10/18/21.
//

import Foundation
import grpc
//
//  UsuarioTableViewController.swift
//  CETAC_Servicios
//
//  Created by user193304 on 10/16/21.
//

import UIKit

class ControllerAdminExpedientes: UITableViewController,MotivoTableViewControllerDelegate,HerramientaTableViewControllerDelegate,IntervencionTableViewControllerDelegate,TipoTableViewControllerDelegate {
    func herramientaTableViewController(_ controller: HerramientaTableViewController, didSelect herramienta: String) {
        self.selectedherramienta = herramienta
        updateHerramienta()
    }
    
    func intervencionTableViewController(_ controller: IntervencionTableViewController, didSelect intervencion: String) {
        self.selectedintervencion = intervencion
        updateIntervencion()
    }
    
    func tipoTableViewController(_ controller: TipoTableViewController, didSelect tipo: String) {
        self.selectedtipo = tipo
        updateTipo()
    }
    
    func motivoTableViewController(_ controller: MotivoTableViewController, didSelect motivo: String) {
        self.selectedmotivo = motivo
        updateMotivo()
    }
    var expedienteControlador = fetcherController()
    var sesiones: Sesion?
    var editar = false
    //button
    
    @IBOutlet weak var modificar: UIButton!
    //#
    
    @IBOutlet weak var switchw: UISwitch!
    @IBOutlet weak var nombre_: UITextField!
    @IBOutlet weak var num_expediente_: UILabel!
    @IBOutlet weak var num_sesion_: UILabel!
    @IBOutlet weak var motivo_: UILabel!
    @IBOutlet weak var servicio_: UILabel!
    @IBOutlet weak var intervencion_: UILabel!
    @IBOutlet weak var herramienta_: UILabel!
    @IBOutlet weak var doctor_: UILabel!
    @IBOutlet weak var fecha_: UILabel!
    @IBOutlet weak var cuota_: UILabel!
    @IBOutlet weak var cierre_: UILabel!
    @IBOutlet weak var evaluacion_: UITextView!
    @IBOutlet weak var editarDoctorNombre: UITextField!
    @IBOutlet weak var editarCouta: UITextField!
    
    
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
        editar = !editar
        botones(estado: editar)
        //botones2(estado: editar)
        
       
    }
    
    @IBAction func changeDate(_ sender: Any) { fecha_.text = dateFormatter.string(from: datePicker.date)
    }
    
    @IBOutlet weak var dateView: UITableViewCell!
    @IBOutlet weak var doctorView: UITableViewCell!
    @IBOutlet weak var tipoView: UITableViewCell!
    @IBOutlet weak var motivoView: UITableViewCell!
    @IBOutlet weak var herramientaView: UITableViewCell!
    @IBOutlet weak var intervencionView: UITableViewCell!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var coutaView: UITableViewCell!
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
        num_sesion_.text = String(selectednumSesion)
        num_expediente_.text = String(selectednumExpediente)
        cuota_.text = String(selectedcuota)
        motivo_.text = selectedmotivo
        servicio_.text = selectedherramienta
        intervencion_.text = selectedintervencion
        herramienta_.text = selectedherramienta
        doctor_.text = selecteddoctor
        fecha_.text = selectedfecha
        evaluacion_.text = selectedevaluacion
        switchw.isOn = false
        
        if selectedcierre == false {
            cierre_.text = "Abierto"
        } else {
            cierre_.text = "Cerrado"
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
    
    func botones(estado:Bool){
        if estado{
            nombre_.isUserInteractionEnabled = true
            nombre_.backgroundColor = UIColor.systemGray5
            let imgae = UIImage.init(systemName: "lock.open")
            switchw.isHidden = false
            cierre_.isHidden=true
            modificar.setBackgroundImage(imgae, for: .normal)
            fecha_.isHidden=true
            dateView.isHidden = false
            editarDoctorNombre.isHidden=false
            editarDoctorNombre.isUserInteractionEnabled = true
            editarDoctorNombre.backgroundColor = UIColor.systemGray5
            editarCouta.isHidden=false
            editarCouta.isUserInteractionEnabled = true
            editarCouta.backgroundColor = UIColor.systemGray5
            doctorView.isHidden = false
            tipoView.backgroundColor = UIColor.systemGray5
            intervencionView.backgroundColor = UIColor.systemGray5
            motivoView.backgroundColor = UIColor.systemGray5
            herramientaView.backgroundColor = UIColor.systemGray5
            coutaView.isHidden = false
            tipoView.isUserInteractionEnabled=true;
            motivoView.isUserInteractionEnabled=true;
            herramientaView.isUserInteractionEnabled=true;
            intervencionView.isUserInteractionEnabled=true;
           
            
            
            
        }
        else{
            if editarDoctorNombre.hasText{
                doctor_.text = editarDoctorNombre.text
            }
            if editarCouta.hasText{
                cuota_.text = editarCouta.text
            }
            
            
            nombre_.isUserInteractionEnabled = false
            nombre_.backgroundColor = UIColor.clear
            let imgae = UIImage.init(systemName: "lock")
            
            
            let expedienteUpdated = Sesion(id: selectedid, numSesion: selectednumSesion, numExpediente: selectednumExpediente, cuota: Double(cuota_.text!) ?? selectedcuota, fecha: fecha_.text!, evaluacion: evaluacion_.text!, cierre: switchw.isOn, paciente_id: selectedpaciente, herramienta: herramienta_.text! , motivo: motivo_.text!, tipo: servicio_.text!, intervencion: intervencion_.text!, doctor: doctor_.text ?? selecteddoctor, paciente: nombre_.text!)
            expedienteControlador.updateExpediente(updateExpediente: expedienteUpdated){ (result) in
            }
            switchw.isHidden=true
            cierre_.isHidden=false
            fecha_.isHidden=false
            
            modificar.setBackgroundImage(imgae, for: .normal)
            dateView.isHidden=true
            
            editarDoctorNombre.isHidden=true
            editarDoctorNombre.isUserInteractionEnabled = false
            editarDoctorNombre.backgroundColor = UIColor.clear
            editarCouta.isHidden=true
            editarCouta.isUserInteractionEnabled = false
            editarCouta.backgroundColor = UIColor.clear
            doctorView.isHidden = true
            tipoView.backgroundColor = UIColor.clear
            intervencionView.backgroundColor = UIColor.clear
            motivoView.backgroundColor = UIColor.clear
            herramientaView.backgroundColor = UIColor.clear
            tipoView.isUserInteractionEnabled=false;
            motivoView.isUserInteractionEnabled=false;
            herramientaView.isUserInteractionEnabled=false;
            intervencionView.isUserInteractionEnabled=false;
        }
    }
    func updateMotivo() {
        motivo_.text = selectedmotivo
        
    }
    func updateHerramienta() {
        herramienta_.text = selectedherramienta
    }
    
    func updateIntervencion() {
        intervencion_.text = selectedintervencion
    }
    func updateTipo() {
        servicio_.text = selectedtipo
    }
    var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        return dateFormatter
    }()
    @IBSegueAction func selectHerramienta(_ coder: NSCoder) -> UITableViewController? {
        let herramientaController = HerramientaTableViewController(coder: coder)
        herramientaController?.delegate = self
        herramientaController?.herramientaSelect = selectedherramienta
        
        return herramientaController
    }
    
    @IBSegueAction func selectIntervencion(_ coder: NSCoder) -> UITableViewController? {
        let intervencionController = IntervencionTableViewController(coder: coder)
        intervencionController?.delegate = self
        intervencionController?.intervencionSelect = selectedintervencion
        
        return intervencionController
    }
    @IBSegueAction func selectMotivo(_ coder: NSCoder) -> UITableViewController? {
        let motivoController = MotivoTableViewController(coder: coder)
        motivoController?.delegate = self
        motivoController?.motivoSelect = selectedmotivo
        
        return motivoController
        
    }
    @IBSegueAction func selectTipo(_ coder: NSCoder) -> UITableViewController? {
        let tipoController = TipoTableViewController(coder: coder)
        tipoController?.delegate = self
        tipoController?.tipoSelect = selectedtipo
        
        return tipoController
    }
    @IBAction func cierreSwitchChanged(_ sender: Any) {
        //cierre_ = switchw.isOn
        
        selectedcierre = switchw.isOn
        if selectedcierre == false {
            cierre_.text = "Abierto"
        } else {
            cierre_.text = "Cerrado"
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

