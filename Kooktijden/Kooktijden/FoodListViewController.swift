//
//  FoodListViewController.swift
//  Kooktijden
//
//  Created by Harm Brugge on 07-11-14.
//  Copyright (c) 2014 De appothekers. All rights reserved.
//

import UIKit

class FoodListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let kCellIdentifier: String = "FoodItemCell"
    
    @IBOutlet weak var foodListTableView: UITableView!
    
    var dataSource = DataSource()
    var foodItems = [FoodItem]()
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodItems.count
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Foods"
        
        var nib = UINib(nibName: "FoodItemTableViewCell", bundle: nil)
        
        foodListTableView.registerNib(nib, forCellReuseIdentifier: "foodCell")
        
        self.tableData = dataSource.getFoods()
        self.foodListTableView!.reloadData()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:FoodItemTableViewCell = self.foodListTableView.dequeueReusableCellWithIdentifier("foodCell") as FoodItemTableViewCell

        
        let rowData: FoodItem = self.tableData[indexPath.row] as FoodItem
        
        cell.loadItem(rowData)
        
        return cell

    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Get the row data for the selected row
        let foodItem = self.foodItems[indexPath.row]
        
        var name: String = foodItem.nameEN!
        var id: Int = foodItem.id
        
        var alert: UIAlertView = UIAlertView()
        alert.title = name
        alert.message = name
        alert.addButtonWithTitle("Ok")
        alert.show()
    }
    
    
}

