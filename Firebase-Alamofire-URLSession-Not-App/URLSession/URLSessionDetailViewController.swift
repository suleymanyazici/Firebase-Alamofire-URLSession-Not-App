//
//  URLSessionDetailViewController.swift
//  Firebase-Alamofire-URLSession-Not-App
//
//  Created by Suleyman YAZICI on 27.09.2023.
//

import UIKit

class URLSessionDetailViewController: UIViewController {

    @IBOutlet weak var ortStringDetailLabel: UILabel!
    @IBOutlet weak var ortNotDetailLabel: UILabel!
    @IBOutlet weak var finalDetailLabel: UILabel!
    @IBOutlet weak var vizeDetailLabel: UILabel!
    @IBOutlet weak var dersAdiDetailLabel: UILabel!
    var gelenNot : Notlar?
    override func viewDidLoad() {
        super.viewDidLoad()

        if let not = gelenNot{
            dersAdiDetailLabel.text = not.ders_adi
            vizeDetailLabel.text = not.not1
            finalDetailLabel.text = not.not2
            
            if let ortVizeInt = Double(not.not1!),let ortFinalInt = Double(not.not2!){
                let ortSonuc = (ortVizeInt*0.4)+(ortFinalInt*0.6)
                ortNotDetailLabel.text = String(ortSonuc)
                switch ortSonuc {
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
            }else{
                print("Girilen Not Geçersizdir")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "URLSessionDetailToUpdate"{
            let gidilecekVC = segue.destination as! URLSessionUpdateViewController
            gidilecekVC.updateNot = gelenNot
        }
    }
    
    
    @IBAction func deleteButton(_ sender: Any) {
        let alert = UIAlertController(title: "Güncelleme", message: "Güncelleme yapmak istediğine emin misin?", preferredStyle: .alert)
        let silButton = UIAlertAction(title: "Sil", style: .destructive){_ in
            print("İşlem kabul edildi")
            if let n = self.gelenNot {
                if let notId = Int(n.not_id!) {
                    self.deleteNot(not_id: notId)
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
            
        
        let vazButton = UIAlertAction(title: "Vazgeç", style: .cancel){_ in
        print("işlemden vazgeçildi")
        }
        alert.addAction(silButton)
        alert.addAction(vazButton)
        self.present(alert, animated: true)
        
    }
    func deleteNot(not_id:Int){
        
        var request = URLRequest(url: URL(string: "http://kasimadalan.pe.hu/notlar/delete_not.php")!)
        request.httpMethod = "POST"
        let postString = "not_id=\(not_id)"
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
