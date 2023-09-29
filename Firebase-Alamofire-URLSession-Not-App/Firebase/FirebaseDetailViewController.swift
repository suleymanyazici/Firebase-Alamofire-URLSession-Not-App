//
//  FirebaseDetailViewController.swift
//  Firebase-Alamofire-URLSession-Not-App
//
//  Created by Suleyman YAZICI on 27.09.2023.
//

import UIKit
import Firebase
class FirebaseDetailViewController: UIViewController {
    
    @IBOutlet weak var ortStringDetailLabel: UILabel!
    @IBOutlet weak var ortNotDetailLabel: UILabel!
    @IBOutlet weak var finalDetailLabel: UILabel!
    @IBOutlet weak var vizeDetailLabel: UILabel!
    @IBOutlet weak var dersAdiDetailLabel: UILabel!
    var gelenNot : Notlar?
    var ref : DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
        if let not = gelenNot{
            finalDetailLabel.text = not.not2
            vizeDetailLabel.text = not.not1
            dersAdiDetailLabel.text = not.ders_adi
            
            if let vizeInt = Double(not.not1!),let finalInt = Double(not.not2!){
                self.ortNotDetailLabel.text = String((vizeInt*0.4) + (finalInt*0.6))
            }
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FirebaseDetailToUpdate"{
            let gidilecekVC = segue.destination as! FirebaseUpdateViewController
            gidilecekVC.updateNots = gelenNot
        }
    }
    

    @IBAction func deleteButton(_ sender: Any) {
        let alert = UIAlertController(title: "Sil", message: "Silmek istediğine emin misin?", preferredStyle: .alert)
        let silButton = UIAlertAction(title: "Sil", style: .destructive){ _ in
            if let key = self.gelenNot?.not_id{
                self.deleteNot(not_id: key)
                self.navigationController?.popViewController(animated: true)
            }
        }
        let vazButton = UIAlertAction(title: "Vazgeç", style: .cancel)
        alert.addAction(silButton)
        alert.addAction(vazButton)
        
        self.present(alert, animated: true)
        
    }
    
    func deleteNot(not_id:String){
        ref.child("notlar").child(not_id).removeValue()
    }

}
