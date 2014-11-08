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
        
        let id = Expression<Int>("id")
        let nameEn = Expression<String>("nameEn")
        
        let foods = db["foods"]
        for food in foods {
            println(food[id])
        }

        
        var items: [FoodItem] = []
        for row in db.prepare("SELECT * FROM foods") {
            var foodItem = FoodItem()
            //foodItem.id = row[0]
            //foodItem.nameEN = row[1]
            items.append(foodItem)
            println("id: \(row[0]), food: \(row[1])")

        }
    
        return items
    }
    func writeFoods() {
        let statement = db.prepare("INSERT INTO foods (name_EN) VALUES (?)")
        for food in ["poop", "banaan"] {
            statement.run(food)
        }
    }

}












