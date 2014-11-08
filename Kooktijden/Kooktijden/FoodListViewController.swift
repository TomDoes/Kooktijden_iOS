//
//  FoodListViewController.swift
//  Kooktijden
//
//  Created by Harm Brugge on 07-11-14.
//  Copyright (c) 2014 De appothekers. All rights reserved.
//

import UIKit

class FoodListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var foodListTableView: UITableView!
    
    var dataSource = DataSource()
    var tableData = []
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
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
    
    
}

