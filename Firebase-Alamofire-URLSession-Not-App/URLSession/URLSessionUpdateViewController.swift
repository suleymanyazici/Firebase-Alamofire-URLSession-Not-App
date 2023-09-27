//
//  URLSessionUpdateViewController.swift
//  Firebase-Alamofire-URLSession-Not-App
//
//  Created by Suleyman YAZICI on 27.09.2023.
//

import UIKit

class URLSessionUpdateViewController: UIViewController {
    
    @IBOutlet weak var finalTextField: UITextField!
    @IBOutlet weak var vizeTextField: UITextField!
    @IBOutlet weak var dersAdiTextField: UITextField!
    var updateNot : Notlar?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let not = updateNot{
            finalTextField.text = not.not2
            vizeTextField.text = not.not1
            dersAdiTextField.text = not.ders_adi
        }
        
    }
    
    @IBAction func updateButton(_ sender: Any) {
        let alert = UIAlertController(title: "Güncelleme", message: "Güncelleme yapmak istediğine emin misin?", preferredStyle: .alert)
        let evetButton = UIAlertAction(title: "Evet", style: .default){_ in
            print("İşlem kabul edildi")
            if let not = self.updateNot,let dersAdiText = self.dersAdiTextField.text,let vizeNotField = self.vizeTextField.text,let finalTextField = self.finalTextField.text{
                if let notId = Int(not.not_id!), let vize = Int(vizeNotField), let final = Int(finalTextField){
                    self.updateNot(not_id: notId, ders_adi: dersAdiText, not1: vize, not2: final)
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
    
    func updateNot(not_id:Int,ders_adi:String,not1:Int,not2:Int){
        var request = URLRequest(url: URL(string: "http://kasimadalan.pe.hu/notlar/update_not.php")!)
        request.httpMethod = "POST"
        
        let postString = "not_id=\(not_id)&ders_adi=\(ders_adi)&not1=\(not1)&not2=\(not2)"
        request.httpBody = postString.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { data,response,error in
            if error != nil || data == nil {
                print("Hata")
                return
            }
            
            do{
                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:Any]{
                    print(json)
                }
                
            }catch{
                print(error.localizedDescription)
            }
        }.resume()
    }
}
