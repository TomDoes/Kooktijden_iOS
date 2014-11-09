//
//  FoodDetailController.swift
//  Kooktijden
//
//  Created by Harm Brugge on 08-11-14.
//  Copyright (c) 2014 De appothekers. All rights reserved.
//

import UIKit

class FoodDetailController: UIViewController, UITableViewDelegate{
    
    @IBOutlet weak var foodItemLabel: UILabel!
    @IBOutlet weak var firstLetterImage: UILabel!
    
    var foodItem: FoodItem?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstLetterImage.text = self.foodItem?.nameEN[0]
        foodItemLabel.text = self.foodItem?.nameEN
    }
    
}
