//
//  FirebaseViewController.swift
//  Firebase-Alamofire-URLSession-Not-App
//
//  Created by Suleyman YAZICI on 27.09.2023.
//

import UIKit
import Firebase


class FirebaseViewController: UIViewController {
    var ref : DatabaseReference!
    var notList = [Notlar]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

        ref = Database.database().reference()
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FirebaseToDetail"{
            let indeks = sender as? Int
            let gidilecekVC = segue.destination as! FirebaseDetailViewController
            gidilecekVC.gelenNot = notList[indeks!]
            
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        getAllNot()
    }
    
    func getAllNot(){
        ref.child("notlar").observe(.value, with: { snapshot in
            
            if let gelenVeri = snapshot.value as? [String:AnyObject]{
                self.notList.removeAll()
                
                for gelen in gelenVeri {
                    if let dict = gelen.value as? NSDictionary{
                        let key = gelen.key
                        let ders_adi = dict["ders_adi"] as? String ?? ""
                        let vize = dict["not1"] as? Int ?? 0
                        let final = dict["not2"] as? Int ?? 0
                        
                        let not = Notlar(not_id: key, ders_adi: ders_adi, not1: String(vize), not2: String(final))
                            
                        self.notList.append(not)

                        

                    }
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    
                }
            }
            
        })
        
        
    }

    

}
extension FirebaseViewController : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let not = notList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "FirebaseCell", for: indexPath) as! FirebaseTableViewCell
        cell.dersAdiCellLabel.text = not.ders_adi
        cell.vizeCellLabel.text = not.not1
        cell.finalCellLabel.text = not.not2
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "FirebaseToDetail", sender: indexPath.row)
    }
}
