//
//  ViewController.swift
//  CETAC_Servicios
//
//  Created by user193304 on 9/27/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var lblArr = ["Misión", "Visión", "Valores", "Objetivos"]
                                    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}
extension ViewController:UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lblArr.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? NosotrosCollectionViewCell
        cell?.lbl.text = lblArr[indexPath.row]
        cell?.img.image = UIImage(named: "rick")
        //cell?.lbl1.text = "Visión"
        /*cell?.lbl2.text = "isión"
        cell?.lbl3.text = "Viión"*/

        
        /*cell?.img1.image = UIImage(named: "rick")
        cell?.img2.image = UIImage(named: "rick")
        cell?.img3.image = UIImage(named: "rick")*/
        
        return cell!
    }
}

