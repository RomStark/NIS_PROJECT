//
//  TableViewCell.swift
//  HseApp2
//
//  Created by Al Stark on 15.03.2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    var label : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        label = UILabel()
        addSubview(label)
        label.text = "User"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configLabel(_ str: String){
        label.text = str
    }

}
