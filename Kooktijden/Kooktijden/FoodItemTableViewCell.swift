//
//  FoodItemTableViewCell.swift
//  Kooktijden
//
//  Created by Tom Doesburg on 8/11/14.
//  Copyright (c) 2014 De appothekers. All rights reserved.
//

import UIKit

class FoodItemTableViewCell : UITableViewCell {
    
    @IBOutlet var foodItemLabel: UILabel!
    @IBOutlet var firstLetterImage: UILabel!
    @IBOutlet var setTimerBtn: UIButton!
    
    func loadItem(foodItem: FoodItem, index: Int) {
        firstLetterImage.text = foodItem.name[0]
        firstLetterImage.font = UIFont(name: "Roboto-Light", size: 20)!
        
        let color = index % 4
        let colorArray = [UIColor.listColor0(), UIColor.listColor1(), UIColor.listColor2(), UIColor.listColor3()]
        firstLetterImage.backgroundColor = colorArray[color]
        
        firstLetterImage.textColor = UIColor.whiteColor()
        firstLetterImage.layer.cornerRadius = firstLetterImage.frame.size.width / 2.0
        firstLetterImage.clipsToBounds = true
        
        foodItemLabel.text = foodItem.name
        foodItemLabel.font = UIFont(name: "Roboto-Light", size: 16)!

    }
    
}

