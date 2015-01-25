//
//  FoodListViewController.swift
//  Kooktijden
//
//  Created by Harm Brugge on 07-11-14.
//  Copyright (c) 2014 De appothekers. All rights reserved.
//

import UIKit

protocol SetCustomTimerDelegate {
    func setCustomTimer(foodItem: FoodItem)
}

class FoodListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SetCustomTimerDelegate {
    
    var delegate: TimerDelegate? = nil
    var timer: String?
    
    @IBOutlet weak var foodListTableView: UITableView!
    
    var dataSource = DataSource()
    var foodItems = [FoodItem]()
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodItems.count + 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 66.0
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
        var nib2 = UINib(nibName: "CustomTimerTableViewCell", bundle: nil)
        
        foodListTableView.registerNib(nib, forCellReuseIdentifier: "foodCell")
        foodListTableView.registerNib(nib2, forCellReuseIdentifier: "customTimerCell")
        self.foodItems = dataSource.getFoods()
        self.foodListTableView!.reloadData()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(indexPath.row == 0) {
            var cell:CustomTimerTableViewCell = self.foodListTableView.dequeueReusableCellWithIdentifier("customTimerCell") as CustomTimerTableViewCell
            return cell
        }
        var cell:FoodItemTableViewCell = self.foodListTableView.dequeueReusableCellWithIdentifier("foodCell") as FoodItemTableViewCell
        
        let rowData: FoodItem = self.foodItems[indexPath.row - 1] as FoodItem
        cell.loadItem(rowData, index: indexPath.row - 1)
        
        // De button van cell heeft in zijn tag de id van het foodItem
        cell.setTimerBtn?.addTarget(self, action: "setTimerBtnPressed:", forControlEvents: .TouchUpInside)
        cell.setTimerBtn?.tag = indexPath.row - 1
                
        return cell

    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.row == 0) {
            var setCustomTimerViewController: SetCustomTimerViewController = SetCustomTimerViewController(nibName: "SetCustomTimerViewController", bundle: nil)
            setCustomTimerViewController.delegate = self;
            self.presentViewController(setCustomTimerViewController, animated: true, completion: nil)
        } else {
            var foodDetailViewController: FoodDetailViewController = FoodDetailViewController(nibName: "FoodDetailViewController", bundle: nil)
            foodDetailViewController.foodItem = self.foodItems[indexPath.row - 1]
            foodDetailViewController.delegate = self.delegate
            foodDetailViewController.timer = timer
            self.navigationController?.pushViewController(foodDetailViewController, animated: true)
        }
        
    }
    
    func setTimerBtnPressed(sender: UIButton!) {
        if (delegate != nil) {
            delegate!.startTimer(self.foodItems[sender.tag])
            self.navigationController?.popToRootViewControllerAnimated(true)
        }

    }
    
    func setCustomTimer(foodItem: FoodItem) {
        delegate!.startTimer(foodItem)
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    
    
}

