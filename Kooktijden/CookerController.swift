//
//  CookerController.swift
//  Kooktijden
//
//  Created by Harm Brugge on 11-11-14.
//  Copyright (c) 2014 De appothekers. All rights reserved.
//

import UIKit

class CookerController: UIViewController, StartTimerDelegate {
    
    var timer1: Timer?
    var timer2: Timer?
    
    @IBOutlet var foodItem1Label: UILabel!
    @IBOutlet var foodItem2Label: UILabel!
    @IBOutlet var timeRemaining1Label: UILabel!
    @IBOutlet var timeRemaining2Label: UILabel!
    
    func handleTimer1(timeRemaining: String) {
        self.timeRemaining1Label.text = timeRemaining
    }
    func handleTimer2(timeRemaining: String) {
        self.timeRemaining2Label.text = timeRemaining
    }
    
    func startTimer(foodItem: FoodItem, timer: String) {
        if (timer == "timer1") {
            self.foodItem1Label.text = foodItem.nameEN
            if (timer1 != nil) { timer1!.stop() }
            timer1 = Timer(duration: foodItem.cookingTimeMax, handler: handleTimer1)
            timer1!.start()
        }
        if (timer == "timer2") {
            self.foodItem2Label.text = foodItem.nameEN
            if (timer2 != nil) { timer2!.stop() }
            timer2 = Timer(duration: foodItem.cookingTimeMax, handler: handleTimer2)
            timer2!.start()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController as FoodListViewController
        vc.delegate = self
        vc.timer = segue.identifier
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