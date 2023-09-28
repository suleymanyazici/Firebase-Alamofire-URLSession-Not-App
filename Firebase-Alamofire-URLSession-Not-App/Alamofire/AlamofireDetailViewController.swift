//
//  AlamofireDetailViewController.swift
//  Firebase-Alamofire-URLSession-Not-App
//
//  Created by Suleyman YAZICI on 27.09.2023.
//

import UIKit
import Alamofire

class AlamofireDetailViewController: UIViewController {
    
    @IBOutlet weak var ortStringDetailLabel: UILabel!
    @IBOutlet weak var ortNotDetailLabel: UILabel!
    @IBOutlet weak var finalDetailLabel: UILabel!
    @IBOutlet weak var vizeDetailLabel: UILabel!
    @IBOutlet weak var dersAdiDetailLabel: UILabel!
    var gelenNot : Notlar?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let not = gelenNot{
            finalDetailLabel.text = not.not2
            vizeDetailLabel.text = not.not1
            dersAdiDetailLabel.text = not.ders_adi
            
            if let vizeInt = Double(not.not1!),let finalInt = Double(not.not2!){
                let ortNot = (vizeInt * 0.4) + (finalInt * 0.6)
                self.ortNotDetailLabel.text = String(ortNot)
                switch ortNot {
                case 0...49:
                    ortStringDetailLabel.textColor = .red
                    ortNotDetailLabel.textColor = .red
                case 50...85:
                    ortStringDetailLabel.textColor = .black
                    ortNotDetailLabel.textColor = .black
                default:
                    ortStringDetailLabel.textColor = .green
                    ortNotDetailLabel.textColor = .green
                }
                
            }
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AlamofireDetailToUpdate"{
            let indeks = sender as? Int
            let gidilecekVC = segue.destination as! AlamofireUpdateViewController
            gidilecekVC.updateNot = gelenNot
            
        }
    }
    
    @IBAction func deleteButton(_ sender: Any) {
        let alert = UIAlertController(title: "Sil", message: "Silmek istediğine emin misin?", preferredStyle: .alert)
        let silAction = UIAlertAction(title: "Sil", style: .destructive){_ in
            if let not = self.gelenNot{
                if let notId = Int(not.not_id!){
                    self.deleteNot(not_id: notId)
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
        let vazAction = UIAlertAction(title: "Vazgeç", style: .cancel)
        alert.addAction(silAction)
        alert.addAction(vazAction)
        self.present(alert, animated: true)
        
        
    }
    
    
    
    func deleteNot(not_id:Int){
        let parameters : Parameters = ["not_id":not_id]
        AF.request("http://kasimadalan.pe.hu/notlar/delete_not.php",method: .post,parameters: parameters).response{
            response in
            if let data = response.data{
                do{
                    if let json = try JSONSerialization.jsonObject(with: data,options: []) as? [String : Any]{
                        print(json)
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
}

