//
//  FoodListViewController.swift
//  Kooktijden
//
//  Created by Harm Brugge on 07-11-14.
//  Copyright (c) 2014 De appothekers. All rights reserved.
//

import UIKit

protocol StartTimerDelegate {
    func startTimer(foodItem:FoodItem)
}

class FoodListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var delegate:StartTimerDelegate? = nil
    
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
        
        self.foodItems = dataSource.getFoods()
        self.foodListTableView!.reloadData()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "foodDetail" {
            var foodDetailController: FoodDetailController = segue.destinationViewController as FoodDetailController            
            foodDetailController.foodItem = self.foodItems[foodListTableView!.indexPathForSelectedRow()!.row]
        }

    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:FoodItemTableViewCell = self.foodListTableView.dequeueReusableCellWithIdentifier("foodCell") as FoodItemTableViewCell
        
        let rowData: FoodItem = self.foodItems[indexPath.row] as FoodItem
                
        cell.loadItem(rowData)
        
        return cell

    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // self.performSegueWithIdentifier("foodDetail", sender: self)
        if (delegate != nil) {
            delegate!.startTimer(self.foodItems[foodListTableView!.indexPathForSelectedRow()!.row])
            self.navigationController?.popToRootViewControllerAnimated(true)
        }
    }
    
    
    
}

