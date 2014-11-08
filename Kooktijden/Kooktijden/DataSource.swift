//
//  DataSource.swift
//  Kooktijden
//
//  Created by Harm Brugge on 07-11-14.
//  Copyright (c) 2014 De appothekers. All rights reserved.
//

import Foundation
import SQLite

class DataSource {
    
    var path: String
    let db: Database
    
    init() {
        path = NSBundle.mainBundle().pathForResource("foods", ofType:"sqlite")!
        db = Database(path)
    }
    
    func getFoods() -> [FoodItem] {
        var items: [FoodItem] = []
        
        
        let foods = db["foods"]
        
        for food in foods {
            var foodItem = FoodItem()
            
            foodItem.id = food[Expression<Int>("id")]!
            foodItem.nameEN = food[Expression<String>("name_EN")]!
            foodItem.nameNL = food[Expression<String>("name_NL")]!
            foodItem.descriptionEN = food[Expression<String>("description_EN")]
            foodItem.descriptionNL = food[Expression<String>("description_NL")]
            foodItem.cookingTimeMin = food[Expression<Int>("cooking_time_min")]!
            foodItem.cookingTimeMax = food[Expression<Int>("cooking_time_max")]!

            items.append(foodItem)
        }
    
        return items
    }
//    func writeFoods() {
//        let statement = db.prepare("INSERT INTO foods (name_EN) VALUES (?)")
//        for food in ["poop", "banaan"] {
//            statement.run(food)
//        }
//    }

}












