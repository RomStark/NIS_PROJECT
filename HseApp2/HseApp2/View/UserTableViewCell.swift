//
//  UserTableViewCell.swift
//  HseApp2
//
//  Created by Al Stark on 15.03.2022.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configCell(_ str: String){
        label.text = str
    }
    
}
