//
//  FoodDetailController.swift
//  Kooktijden
//
//  Created by Harm Brugge on 08-11-14.
//  Copyright (c) 2014 De appothekers. All rights reserved.
//

import UIKit

class FoodDetailController: UIViewController, UITableViewDelegate{

    //var timer: Timer?
    var foodItem: FoodItem?
    
    //@IBOutlet var timeRemainingLabel: UILabel!
    @IBOutlet var foodItemLabel: UILabel!
    @IBOutlet var firstLetterImage: UILabel!
    //@IBOutlet var setTimer: UIButton!
    /*
    @IBAction func start(sender: AnyObject) {
        self.timer!.start()
    }
    */
    
    //func displayTimeRemaining(timeRemaining: String) -> Void {
    //    self.timeRemainingLabel.text = timeRemaining
    //}
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstLetterImage.text = self.foodItem!.nameEN[0]
        foodItemLabel.text = self.foodItem!.nameEN
    }
    
    /*
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "setTimer" {
            /*
            var vc = segue.destinationViewController as CookerController
            vc.timer = Timer(duration: foodItem!.cookingTimeMax, handler: vc.displayTimeRemaining)
            vc.timer!.start()
            */
        }
    }
    */
    
}
