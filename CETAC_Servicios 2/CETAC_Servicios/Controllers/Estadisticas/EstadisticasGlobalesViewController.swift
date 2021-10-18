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
    @IBOutlet weak var cuotaglobal: UILabel!
    
    let fetcher = fetcherController()
    var datos = [0,0,0]
    var tops = [Top]()
    var motivos = [Top]()
    var intervenciones = [Top]()
    var cuota = 0.0
    
    lazy var pieChart: PieChartView = {
        let pieChartView = PieChartView()
        return pieChartView
    }()
    
    lazy var barChart: BarChartView = {
        let barChartView = BarChartView()
        return barChartView
    }()
    
    lazy var barChart1: BarChartView = {
        let barChartView = BarChartView()
        return barChartView
    }()
    
    lazy var barChart2: BarChartView = {
        let barChartView = BarChartView()
        return barChartView
    }()
    
    lazy var horizontalbarChart: HorizontalBarChartView = {
        let horizontalbarChartView = HorizontalBarChartView()
        return horizontalbarChartView
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
        fetcher.fetchTopMotivos{ (result) in
                    switch result{
                    //Funciona
                    case .success(let motivos):self.updateUI3(with: motivos)
                    case .failure(let error):self.displayError(error, title: "No se pudo acceder a Motivos")
                    }
                }
        
        
        fetcher.fetchTopIntervenciones{ (result) in
                    switch result{
                    //Funciona
                    case .success(let intervenciones):self.updateUI4(with: intervenciones)
                    case .failure(let error):self.displayError(error, title: "No se pudo acceder a Intervenciones")
                    }
                }
        
        fetcher.fetchCuotaGlobal{ (result) in
                    switch result{
                    //Funciona
                    case .success(let cuota):self.updateUI5(with: cuota)
                    case .failure(let error):self.displayError(error, title: "No se pudo acceder a Cuota Global")
                    }
                }

        graficausuarios.addSubview(pieChart)
        pieChart.center(in: graficausuarios)
        pieChart.width(to: graficausuarios)
        pieChart.heightToWidth(of: graficausuarios)
        //motivostopChartUpdate()
        
        graficaservicios.addSubview(barChart)
        barChart.center(in: graficaservicios)
        barChart.width(to: graficaservicios)
        barChart.heightToWidth(of: graficaservicios)
        //serviciosChartUpdate()
        
        graficamotivos.addSubview(barChart1)
        barChart1.center(in: graficamotivos)
        barChart1.width(to: graficamotivos)
        barChart1.heightToWidth(of: graficamotivos)
        
        /*graficamotivos.addSubview(horizontalbarChart)
        horizontalbarChart.center(in: graficamotivos)
        horizontalbarChart.width(to: graficamotivos)
        horizontalbarChart.heightToWidth(of: graficamotivos)*/
        
        graficaintervencion.addSubview(barChart2)
        barChart2.center(in: graficaintervencion)
        barChart2.width(to: graficaintervencion)
        barChart2.heightToWidth(of: graficaintervencion)
        
        
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
    
    func updateUI3(with motivos: [Top]){
            DispatchQueue.main.async {
                self.motivos = motivos
                self.motivostopChartUpdate()

            }
        }
    
    func updateUI4(with intervenciones: [Top]){
            DispatchQueue.main.async {
                self.intervenciones = intervenciones
                self.intervenciontopChartUpdate()

            }
        }
    
    func updateUI5(with cuota: Double){
            DispatchQueue.main.async {
                self.cuota = cuota
                self.cuotaGlobalUpdate()

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
    
    func cuotaGlobalUpdate() {
        self.cuotaglobal.text = "$ " + String(self.cuota)
    }
    
    func usuariosgeneroChartUpdate() {
        let entry1 = PieChartDataEntry(value: Double(datos[0]), label: "Hombres")
        let entry2 = PieChartDataEntry(value: Double(datos[1]), label: "Mujeres")
        let entry3 = PieChartDataEntry(value: Double(datos[2]), label: "Otros")
        let dataSet = PieChartDataSet(entries: [entry1, entry2, entry3], label: "Usuarios por Genero")
        dataSet.colors = [
            NSUIColor(cgColor: UIColor.systemBlue.cgColor),
            NSUIColor(cgColor: UIColor.systemRed.cgColor),
            NSUIColor(cgColor: UIColor.systemIndigo.cgColor)
        ]
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
        let entry2 = BarChartDataEntry(x: 2, y:  Double(tops[1].num))
        let entry3 = BarChartDataEntry(x: 3, y:  Double(tops[2].num))
        let dataSet = BarChartDataSet(entries: [entry1, entry2, entry3], label: "")
        dataSet.colors = [
            NSUIColor(cgColor: UIColor.systemBlue.cgColor),
            NSUIColor(cgColor: UIColor.systemRed.cgColor),
            NSUIColor(cgColor: UIColor.systemGreen.cgColor)
        ]
        let data = BarChartData(dataSet: dataSet)
        let test = LegendEntry()
        test.label = tops[0].nombre
        test.form = Legend.Form.square
        test.formSize = 10.0
        test.formColor = NSUIColor(cgColor: UIColor.systemBlue.cgColor)
        let test1 = LegendEntry()
        test1.label = tops[1].nombre
        test1.form = Legend.Form.square
        test1.formSize = 10.0
        test1.formColor = NSUIColor(cgColor: UIColor.systemRed.cgColor)
        let test2 = LegendEntry()
        test2.label = tops[2].nombre
        test2.form = Legend.Form.square
        test2.formSize = 10.0
        test2.formColor = NSUIColor(cgColor: UIColor.systemGreen.cgColor)
        
        let tests = [test, test1, test2]
        barChart.legend.extraEntries = tests
        barChart.data = data
        barChart.chartDescription?.text = "Top 3 de Servicios"
        

        barChart.notifyDataSetChanged()
    }
    
    func motivostopChartUpdate() {
        let entry1 = BarChartDataEntry(x: 1, y:  Double(motivos[0].num))
        let entry2 = BarChartDataEntry(x: 2, y:  Double(motivos[1].num))
        let entry3 = BarChartDataEntry(x: 3, y:  Double(motivos[2].num))
        let entry4 = BarChartDataEntry(x: 4, y:  Double(motivos[3].num))
        let entry5 = BarChartDataEntry(x: 5, y:  Double(motivos[4].num))
        let dataSet = BarChartDataSet(entries: [entry1, entry2, entry3, entry4, entry5], label: "")
        dataSet.colors = [
            NSUIColor(cgColor: UIColor.systemBlue.cgColor),
            NSUIColor(cgColor: UIColor.systemRed.cgColor),
            NSUIColor(cgColor: UIColor.systemGreen.cgColor),
            NSUIColor(cgColor: UIColor.systemPink.cgColor),
            NSUIColor(cgColor: UIColor.systemPurple.cgColor),
        ]
        let data = BarChartData(dataSet: dataSet)
        let test = LegendEntry()
        test.label = motivos[0].nombre
        test.form = Legend.Form.square
        test.formSize = 10.0
        test.formColor = NSUIColor(cgColor: UIColor.systemBlue.cgColor)
        let test1 = LegendEntry()
        test1.label = motivos[1].nombre
        test1.form = Legend.Form.square
        test1.formSize = 10.0
        test1.formColor = NSUIColor(cgColor: UIColor.systemRed.cgColor)
        let test2 = LegendEntry()
        test2.label = motivos[2].nombre
        test2.form = Legend.Form.square
        test2.formSize = 10.0
        test2.formColor = NSUIColor(cgColor: UIColor.systemGreen.cgColor)
        let test3 = LegendEntry()
        test3.label = motivos[3].nombre
        test3.form = Legend.Form.square
        test3.formSize = 10.0
        test3.formColor = NSUIColor(cgColor: UIColor.systemPink.cgColor)
        let test4 = LegendEntry()
        test4.label = motivos[4].nombre
        test4.form = Legend.Form.square
        test4.formSize = 10.0
        test4.formColor = NSUIColor(cgColor: UIColor.systemPurple.cgColor)
        
        let tests = [test, test1, test2, test3, test4]
        barChart1.legend.extraEntries = tests
        barChart1.data = data
        
        
        barChart1.notifyDataSetChanged()
    }
    
    
    func intervenciontopChartUpdate() {
        let entry1 = BarChartDataEntry(x: 1, y:  Double(intervenciones[0].num))
        let entry2 = BarChartDataEntry(x: 2, y:  Double(intervenciones[1].num))
        let entry3 = BarChartDataEntry(x: 3, y:  Double(intervenciones[2].num))
        let entry4 = BarChartDataEntry(x: 4, y:  Double(intervenciones[3].num))
        let entry5 = BarChartDataEntry(x: 5, y:  Double(intervenciones[4].num))
        let dataSet = BarChartDataSet(entries: [entry1, entry2, entry3, entry4, entry5], label: "")
        dataSet.colors = [
            NSUIColor(cgColor: UIColor.systemBlue.cgColor),
            NSUIColor(cgColor: UIColor.systemRed.cgColor),
            NSUIColor(cgColor: UIColor.systemGreen.cgColor),
            NSUIColor(cgColor: UIColor.systemPink.cgColor),
            NSUIColor(cgColor: UIColor.systemPurple.cgColor),
        ]
        let data = BarChartData(dataSet: dataSet)
        let test = LegendEntry()
        test.label = intervenciones[0].nombre
        test.form = Legend.Form.square
        test.formSize = 10.0
        test.formColor = NSUIColor(cgColor: UIColor.systemBlue.cgColor)
        let test1 = LegendEntry()
        test1.label = intervenciones[1].nombre
        test1.form = Legend.Form.square
        test1.formSize = 10.0
        test1.formColor = NSUIColor(cgColor: UIColor.systemRed.cgColor)
        let test2 = LegendEntry()
        test2.label = intervenciones[2].nombre
        test2.form = Legend.Form.square
        test2.formSize = 10.0
        test2.formColor = NSUIColor(cgColor: UIColor.systemGreen.cgColor)
        let test3 = LegendEntry()
        test3.label = intervenciones[3].nombre
        test3.form = Legend.Form.square
        test3.formSize = 10.0
        test3.formColor = NSUIColor(cgColor: UIColor.systemPink.cgColor)
        let test4 = LegendEntry()
        test4.label = intervenciones[4].nombre
        test4.form = Legend.Form.square
        test4.formSize = 10.0
        test4.formColor = NSUIColor(cgColor: UIColor.systemPurple.cgColor)
        
        let tests = [test, test1, test2, test3, test4]
        barChart2.legend.extraEntries = tests
        barChart2.data = data
        barChart2.notifyDataSetChanged()
        
    }
}
