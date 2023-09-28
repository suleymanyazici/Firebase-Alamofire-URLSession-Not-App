//
//  URLSessionAddViewController.swift
//  Firebase-Alamofire-URLSession-Not-App
//
//  Created by Suleyman YAZICI on 27.09.2023.
//

import UIKit

class URLSessionAddViewController: UIViewController {

    @IBOutlet weak var finalAddTextField: UITextField!
    @IBOutlet weak var vizeAddTextField: UITextField!
    @IBOutlet weak var dersAddTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
    
    @IBAction func addButton(_ sender: Any) {
        
        if let ad = dersAddTextField.text, let vize = vizeAddTextField.text, let final = finalAddTextField.text{
            
            if let vizeInt = Int(vize), let finalInt = Int(final){
                
                addNot(ders_adi: ad, not1: vizeInt, not2: finalInt)
                
                navigationController?.popViewController(animated: true)
            }
        }
        
    }
    
    
    func addNot(ders_adi:String, not1:Int , not2:Int){
    var request = URLRequest(url: URL(string: "http://kasimadalan.pe.hu/notlar/insert_not.php")!)
    request.httpMethod = "POST"
    let postString = "ders_adi=\(ders_adi)&not1=\(not1)&not2=\(not2)"
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
