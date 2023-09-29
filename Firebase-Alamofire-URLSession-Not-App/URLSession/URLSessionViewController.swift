//
//  URLSessionViewController.swift
//  Firebase-Alamofire-URLSession-Not-App
//
//  Created by Suleyman YAZICI on 27.09.2023.
//

import UIKit

class URLSessionViewController: UIViewController {
    
    var notList = [Notlar]()
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
        let index = sender as? Int
        if segue.identifier == "toURLSessionDetail"{
            let gidilecekVC = segue.destination as! URLSessionDetailViewController
            gidilecekVC.gelenNot = notList[index!]
        }
    }
    
    func getAllNot(){
        let url = URL(string: "http://kasimadalan.pe.hu/notlar/tum_notlar.php")!
        
        URLSession.shared.dataTask(with: url) {
            data,response,error in
            if error != nil || data == nil {
                print("Hata")
                return
            }
            
            do{
                let cevap = try JSONDecoder().decode(NotlarResponse.self, from: data!)
                
                if let gelenNot = cevap.notlar {
                    self.notList = gelenNot
                }else{
                    self.notList = [Notlar]()
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }catch{
                print(error.localizedDescription)
            }
        }.resume()
    }
    
}
extension URLSessionViewController : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let not = notList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "URLSessionCell", for: indexPath) as! URLSessionTableViewCell
        cell.dersAdiCellLabel.text = not.ders_adi
        cell.vizeCellLabel.text = not.not1
        cell.finalCellLabel.text = not.not2
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toURLSessionDetail", sender: indexPath.row)
    }
}

