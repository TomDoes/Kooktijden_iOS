//
//  CustomTimerTableViewCell.swift
//  Kooktijden
//
//  Created by Tom Doesburg on 24/1/15.
//  Copyright (c) 2015 De appothekers. All rights reserved.
//

import UIKit

class CustomTimerTableViewCell: UITableViewCell {

    @IBOutlet var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        label.font = UIFont(name: "Roboto-Light", size: 20)!
        

        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
