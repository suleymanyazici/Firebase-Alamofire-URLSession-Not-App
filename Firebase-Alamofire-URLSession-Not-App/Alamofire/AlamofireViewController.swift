//
//  AlamofireViewController.swift
//  Firebase-Alamofire-URLSession-Not-App
//
//  Created by Suleyman YAZICI on 27.09.2023.
//

import UIKit
import Alamofire

class AlamofireViewController: UIViewController {
    
    var notList = [Notlar]()
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
                
    }
    override func viewWillAppear(_ animated: Bool) {
        getAllNot()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAlamofireDetail"{
            let indeks = sender as? Int
            let gidilecekVC = segue.destination as! AlamofireDetailViewController
            gidilecekVC.gelenNot = notList[indeks!]
        }
    }
    
    func getAllNot(){
        
        AF.request("http://kasimadalan.pe.hu/notlar/tum_notlar.php", method: .get).response{
            response in
            if let data = response.data{
                do{
                    let response = try JSONDecoder().decode(NotlarResponse.self, from: data)
                    
                    if let notListesi = response.notlar{
                        self.notList = notListesi
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                }catch{
                    print(error.localizedDescription)
                }
            }
            
        }
        
    }
}

extension AlamofireViewController : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let not = notList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlamofireCell", for: indexPath) as! AlamofireTableViewCell
        cell.dersAdiCellLabel.text = not.ders_adi
        cell.vizeCellLabel.text = not.not1
        cell.finalCellLabel.text = not.not2
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toAlamofireDetail", sender: indexPath.row)
    }
}
