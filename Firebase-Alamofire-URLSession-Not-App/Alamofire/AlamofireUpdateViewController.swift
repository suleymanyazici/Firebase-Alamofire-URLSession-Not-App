//
//  AlamofireUpdateViewController.swift
//  Firebase-Alamofire-URLSession-Not-App
//
//  Created by Suleyman YAZICI on 27.09.2023.
//

import UIKit
import Alamofire
class AlamofireUpdateViewController: UIViewController {

    @IBOutlet weak var finalTextField: UITextField!
    @IBOutlet weak var vizeTextField: UITextField!
    @IBOutlet weak var dersAdiTextField: UITextField!
    var updateNot : Notlar?
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        if let updateNots = updateNot{
            finalTextField.text = updateNots.not2
            vizeTextField.text = updateNots.not1
            dersAdiTextField.text = updateNots.ders_adi
        }
    }
    
    @IBAction func updateButton(_ sender: Any) {
        let alert = UIAlertController(title: "Güncelleme", message: "Güncelleme yapmak istediğine emin misin?", preferredStyle: .alert)
        let evetButton = UIAlertAction(title: "Evet", style: .default){_ in
            print("İşlem kabul edildi")
            if let not = self.updateNot, let dersAdi = self.dersAdiTextField.text, let vize = self.vizeTextField.text, let final = self.finalTextField.text{
                if let notId = Int(not.not_id!), let vizeInt = Int(vize), let finalInt = Int(final){
                    self.updateNot(not_id: notId, ders_adi: dersAdi, not1: vizeInt, not2: finalInt)
                    self.navigationController?.popViewController(animated: true)

                }
            }
        }
        let vazButton = UIAlertAction(title: "Vazgeç", style: .cancel){_ in
        print("işlemden vazgeçildi")
        }
        alert.addAction(evetButton)
        alert.addAction(vazButton)
        self.present(alert, animated: true)
        
            }
    
    func updateNot(not_id:Int, ders_adi:String, not1:Int,not2:Int){
    
        let parameters : Parameters = ["not_id":not_id,"ders_adi":ders_adi,"not1":not1,"not2":not2]
        AF.request("http://kasimadalan.pe.hu/notlar/update_not.php",method: .post,parameters: parameters).response{
            response in
            if let data = response.data{
                do{
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]{
                        print(json)
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
}
