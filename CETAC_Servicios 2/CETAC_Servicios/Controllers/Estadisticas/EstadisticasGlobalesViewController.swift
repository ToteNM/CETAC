//
//  EstadisticasGlobalesViewController.swift
//  CETAC_Servicios
//
//  Created by user193304 on 10/14/21.
//

import UIKit
import Charts
import TinyConstraints

class EstadisticasGlobalesViewController: UIViewController {

    @IBOutlet weak var graficausuarios: UIView!
    @IBOutlet weak var graficaservicios: UIView!
    @IBOutlet weak var graficamotivos: UIView!
    @IBOutlet weak var graficaintervencion: UIView!
    
    let fetcher = fetcherController()
    var datos = [0,0,0]
    
    lazy var pieChart: PieChartView = {
        let pieChartView = PieChartView()
        return pieChartView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetcher.fetchPacientesporGenero{ (result) in
                    switch result{
                    //Funciona
                    case .success(let datos):self.updateUI(with: datos)
                    case .failure(let error):self.displayError(error, title: "No se pudo acceder a Usuarios por Genero")
                    }
                }

        graficausuarios.addSubview(pieChart)
        pieChart.center(in: graficausuarios)
        pieChart.width(to: graficausuarios)
        pieChart.heightToWidth(of: graficausuarios)
        usuariosgeneroChartUpdate()
        
        
    }
    func updateUI(with datos: [Int]){
            DispatchQueue.main.async {
                self.datos = datos
                self.view.setNeedsLayout()

            }
        }
    func displayError(_ error: Error, title: String){
            DispatchQueue.main.async{
                let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func usuariosgeneroChartUpdate() {
        let entry1 = PieChartDataEntry(value: Double(datos[0]), label: "Hombres")
        let entry2 = PieChartDataEntry(value: Double(datos[1]), label: "Mujeres")
        let entry3 = PieChartDataEntry(value: Double(datos[2]), label: "Otros")
        let dataSet = PieChartDataSet(entries: [entry1, entry2, entry3], label: "Usuarios por Genero")
        dataSet.colors = ChartColorTemplates.joyful()
        let data = PieChartData(dataSet: dataSet)
        pieChart.data = data
        pieChart.chartDescription?.text = "Usuarios atendidos por tanatologo"

        //All other additions to this function will go here
        pieChart.holeColor = UIColor.clear
        pieChart.chartDescription?.textColor = UIColor.blue
        pieChart.legend.textColor = UIColor.blue
        
        //This must stay at end of function
        pieChart.notifyDataSetChanged()
    }

}
