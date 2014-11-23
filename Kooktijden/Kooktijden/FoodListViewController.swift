//
//  FoodListViewController.swift
//  Kooktijden
//
//  Created by Harm Brugge on 07-11-14.
//  Copyright (c) 2014 De appothekers. All rights reserved.
//

import UIKit

protocol StartTimerDelegate {
    func startTimer(foodItem:FoodItem, timer:String)
}

class FoodListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var delegate:StartTimerDelegate? = nil
    var timer: String?
    
    @IBOutlet weak var foodListTableView: UITableView!
    
    var dataSource = DataSource()
    var foodItems = [FoodItem]()
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodItems.count
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        var localNotification:UILocalNotification = UILocalNotification()
        localNotification.alertAction = "Test"
        localNotification.alertBody = "Doet ie het?"
        localNotification.fireDate = NSDate(timeIntervalSinceNow: 30)
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
        */
        
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
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:FoodItemTableViewCell = self.foodListTableView.dequeueReusableCellWithIdentifier("foodCell") as FoodItemTableViewCell
        
        let rowData: FoodItem = self.foodItems[indexPath.row] as FoodItem
        cell.loadItem(rowData)
        
        // De button van cell heeft in zijn tag de id van het foodItem
        cell.setTimerBtn?.addTarget(self, action: "setTimerBtnPressed:", forControlEvents: .TouchUpInside)
        cell.setTimerBtn?.tag = indexPath.row
                
        return cell

    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var foodDetailViewController: FoodDetailViewController = FoodDetailViewController(nibName: "FoodDetailViewController", bundle: nil)
        foodDetailViewController.foodItem = self.foodItems[indexPath.row]
        foodDetailViewController.delegate = self.delegate
        foodDetailViewController.timer = timer
        self.navigationController?.pushViewController(foodDetailViewController, animated: true)
    }
    
    func setTimerBtnPressed(sender: UIButton!) {
        if (delegate != nil) {
            delegate!.startTimer(self.foodItems[sender.tag], timer: self.timer!)
            self.navigationController?.popToRootViewControllerAnimated(true)
        }

    }
    
    
    
}

