//
//  FirebaseAddViewController.swift
//  Firebase-Alamofire-URLSession-Not-App
//
//  Created by Suleyman YAZICI on 27.09.2023.
//

import UIKit
import Firebase

class FirebaseAddViewController: UIViewController {

    var ref : DatabaseReference!
    @IBOutlet weak var finalAddTextField: UITextField!
    @IBOutlet weak var vizeAddTextField: UITextField!
    @IBOutlet weak var dersAddTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
    }
    

    @IBAction func addButton(_ sender: Any) {
        
        if let dersAdi = dersAddTextField.text, let vize = vizeAddTextField.text, let final = finalAddTextField.text{
            addNot(ders_adi: dersAdi, not1: Int(vize)!, not2: Int(final)!)
            navigationController?.popViewController(animated: true)
        }
        
    }
    
    func addNot(ders_adi:String, not1:Int, not2:Int){
        
        let dict:[String:Any] = ["ders_adi":ders_adi, "not1":not1, "not2":not2]
        
        let newRef = ref.child("notlar").childByAutoId()
    
        newRef.setValue(dict)
    }
    
}
