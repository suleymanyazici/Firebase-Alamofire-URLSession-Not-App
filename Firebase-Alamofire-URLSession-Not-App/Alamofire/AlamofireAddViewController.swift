//
//  AlamofireAddViewController.swift
//  Firebase-Alamofire-URLSession-Not-App
//
//  Created by Suleyman YAZICI on 27.09.2023.
//

import UIKit
import Alamofire

class AlamofireAddViewController: UIViewController {

    @IBOutlet weak var finalAddTextField: UITextField!
    @IBOutlet weak var vizeAddTextField: UITextField!
    @IBOutlet weak var dersAddTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    

    @IBAction func addButton(_ sender: Any) {
        
        if let dersAdi = dersAddTextField.text, let vize = vizeAddTextField.text, let final = finalAddTextField.text{
            if let vizeInt = Int(vize), let finalInt = Int(final){
                addNot(ders_adi: dersAdi, not1: vizeInt, not2: finalInt)
                self.navigationController?.popViewController(animated: true)
            }
        }
        
    }
    

    func addNot(ders_adi:String,not1:Int,not2:Int){
        
        let parameters : Parameters = ["ders_adi":ders_adi,"not1":not1,"not2":not2]
        AF.request("http://kasimadalan.pe.hu/notlar/insert_not.php", method: .post,parameters: parameters).response{
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
