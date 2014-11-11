//
//  CookerController.swift
//  Kooktijden
//
//  Created by Harm Brugge on 11-11-14.
//  Copyright (c) 2014 De appothekers. All rights reserved.
//

import UIKit

class CookerController: UIViewController, StartTimerDelegate {
    
    var timer: Timer?
    var foodItem: FoodItem?
    
    @IBOutlet var foodItemLabel: UILabel!
    @IBOutlet var timeRemainingLabel: UILabel!
    
    func displayTimeRemaining(timeRemaining: String) -> Void {
        self.timeRemainingLabel.text = timeRemaining
    }
    
    func startTimer(foodItem: FoodItem) {
        self.foodItemLabel.text = foodItem.nameEN
        if (timer != nil) {
            timer!.stop()
        }
        timer = Timer(duration: foodItem.cookingTimeMax, handler: displayTimeRemaining)
        timer!.start()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController as FoodListViewController
        vc.delegate = self
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Cooking times"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}