//
//  FirebaseUpdateViewController.swift
//  Firebase-Alamofire-URLSession-Not-App
//
//  Created by Suleyman YAZICI on 27.09.2023.
//

import UIKit
import Firebase

class FirebaseUpdateViewController: UIViewController {

    var ref : DatabaseReference!
    @IBOutlet weak var finalTextField: UITextField!
    @IBOutlet weak var vizeTextField: UITextField!
    @IBOutlet weak var dersAdiTextField: UITextField!
    var updateNots : Notlar?
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
        if let not = updateNots{
            finalTextField.text = not.not2
            vizeTextField.text = not.not1
            dersAdiTextField.text = not.ders_adi
        }
        
    }
    

    @IBAction func updateButton(_ sender: Any) {
        
        let alert = UIAlertController(title: "Güncelle", message: "Güncellemek istediğine emin misin?", preferredStyle: .alert)
        let guncelleButton = UIAlertAction(title: "Güncelle", style: .default){ _ in
            if let not = self.updateNots, let dersAdi = self.dersAdiTextField.text, let vize = self.vizeTextField.text, let final = self.finalTextField.text{
                if let key = not.not_id, let vizeInt = Int(vize),let finalInt = Int(final){
                    self.updateNot(not_id: key, ders_adi: dersAdi, not1: vizeInt, not2: finalInt)
                }
            }
            self.navigationController?.popViewController(animated: true)
        }
        let vazButton = UIAlertAction(title: "Vazgeç", style: .cancel)
        alert.addAction(guncelleButton)
        alert.addAction(vazButton)
        
        self.present(alert, animated: true)
        
        
        
    }
    
    func updateNot(not_id:String,ders_adi:String,not1:Int,not2:Int){
        ref.child("notlar").updateChildValues(["key":not_id,"ders_adi":ders_adi,"not1":not1,"not2":not2])
    }

}
