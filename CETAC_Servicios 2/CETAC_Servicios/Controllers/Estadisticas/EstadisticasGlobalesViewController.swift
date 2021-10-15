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
    var tops = [Top]()
    
    lazy var pieChart: PieChartView = {
        let pieChartView = PieChartView()
        return pieChartView
    }()
    
    lazy var barChart: BarChartView = {
        let barChartView = BarChartView()
        return barChartView
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
        
        fetcher.fetchTopServicios{ (result) in
                    switch result{
                    //Funciona
                    case .success(let tops):self.updateUI2(with: tops)
                    case .failure(let error):self.displayError(error, title: "No se pudo acceder a Usuarios por Genero")
                    }
                }

        graficausuarios.addSubview(pieChart)
        pieChart.center(in: graficausuarios)
        pieChart.width(to: graficausuarios)
        pieChart.heightToWidth(of: graficausuarios)
        usuariosgeneroChartUpdate()
        
        graficaservicios.addSubview(barChart)
        barChart.center(in: graficaservicios)
        barChart.width(to: graficaservicios)
        barChart.heightToWidth(of: graficaservicios)
        //serviciosChartUpdate()
        
        
    }
    func updateUI(with datos: [Int]){
            DispatchQueue.main.async {
                self.datos = datos
                self.usuariosgeneroChartUpdate()

            }
        }
    func updateUI2(with tops: [Top]){
            DispatchQueue.main.async {
                self.tops = tops
                self.serviciosChartUpdate()

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
    
    func serviciosChartUpdate() {
        let entry1 = BarChartDataEntry(x: 1, y:  Double(tops[0].num))
        print(tops[0].num)
        print(tops[1].num)
        print(tops[2].num)
        let entry2 = BarChartDataEntry(x: 2, y:  Double(tops[1].num))
        let entry3 = BarChartDataEntry(x: 3, y:  Double(tops[2].num))
        let dataSet = BarChartDataSet(entries: [entry1, entry2, entry3], label: "Top 3 Servicios")
        print(tops[0].nombre)
        print(tops[1].nombre)
        print(tops[2].nombre)
        let data = BarChartData(dataSet: dataSet)
        barChart.data = data
        barChart.chartDescription?.text = "Top 3 de Servicios"
        
        let servicios = ["", tops[0].nombre, tops[1].nombre, tops[2].nombre]
        barChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: servicios)
//        barChart.xAxis.granularity = 0

        //All other additions to this function will go here
        

        //This must stay at end of function
        barChart.notifyDataSetChanged()
    }

}
