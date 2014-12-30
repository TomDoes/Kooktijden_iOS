//
//  CookerViewController.swift
//  Kooktijden
//
//  Created by Tom Doesburg on 21/11/14.
//  Copyright (c) 2014 De appothekers. All rights reserved.
//

import UIKit

class CookerViewController: UIViewController, StartTimerDelegate {

    var foodListViewController: FoodListViewController = FoodListViewController(nibName: "FoodListViewController", bundle: nil)
    
    var itemIndex = 0
    
    var timer1: Timer?
    var timer2: Timer?
    
    @IBOutlet var foodItem1Label: UILabel!
    @IBOutlet var foodItem2Label: UILabel!
    @IBOutlet var timeRemaining1Label: UILabel!
    @IBOutlet var timeRemaining2Label: UILabel!
    
    @IBAction func cookerBtn(sender: AnyObject) {
        foodListViewController.timer = sender.restorationIdentifier
        foodListViewController.delegate = self
        self.navigationController?.pushViewController(foodListViewController, animated: true)
    }
    
    /****************************************************************************************
    *
    *   Timer Code
    *
    ****************************************************************************************/
    func handleTimer1(timeRemaining: String) {
        self.timeRemaining1Label.text = timeRemaining
    }
    func handleTimer2(timeRemaining: String) {
        self.timeRemaining2Label.text = timeRemaining
    }
    
    func startTimer(foodItem: FoodItem, timer: String) {
        NSLog("%@", timer)
        if (timer == "cooker1") {
            self.foodItem1Label.text = foodItem.nameEN
            if (timer1 != nil) { timer1!.stop() }
            timer1 = Timer(foodItem: foodItem, handler: handleTimer1)
            timer1!.start()
        }
        if (timer == "cooker2") {
            self.foodItem2Label.text = foodItem.nameEN
            if (timer2 != nil) { timer2!.stop() }
            timer2 = Timer(foodItem: foodItem, handler: handleTimer2)
            timer2!.start()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
