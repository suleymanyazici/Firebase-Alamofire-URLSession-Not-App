//
//  AlamofireTableViewCell.swift
//  Firebase-Alamofire-URLSession-Not-App
//
//  Created by Suleyman YAZICI on 27.09.2023.
//

import UIKit

class AlamofireTableViewCell: UITableViewCell {

    @IBOutlet weak var finalCellLabel: UILabel!
    @IBOutlet weak var vizeCellLabel: UILabel!
    @IBOutlet weak var dersAdiCellLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
