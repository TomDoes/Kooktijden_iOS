//
//  FoodItemTableViewCell.swift
//  Kooktijden
//
//  Created by Tom Doesburg on 8/11/14.
//  Copyright (c) 2014 De appothekers. All rights reserved.
//

import UIKit

class FoodItemTableViewCell : UITableViewCell {
    
    @IBOutlet var foodItemLabel: UILabel?
    @IBOutlet var firstLetterImage: UILabel?
    @IBOutlet var setTimerBtn: UIButton?
    
    @IBAction func setTimer(sender: AnyObject) {
        
    }
    func loadItem(foodItem: FoodItem) {
        firstLetterImage?.text = foodItem.nameEN[0]
        foodItemLabel?.text = foodItem.nameEN
    }
    
}

