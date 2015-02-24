//
//  FoodItem.swift
//  Kooktijden
//
//  Created by Harm Brugge on 07-11-14.
//  Copyright (c) 2014 De appothekers. All rights reserved.
//

import Foundation
import UIKit

class FoodItem: NSObject {
    var id = 0
    var name: String = ""
    var letterColor: UIColor?
    var cookingTimeMin = 0
    var cookingTimeMax = 0
    var descriptionText: String?
}