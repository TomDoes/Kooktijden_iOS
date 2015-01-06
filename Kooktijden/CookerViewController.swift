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
    var tappedTimer = 0
    
    var timer1: Timer?
    var timer2: Timer?
    var timer3: Timer?
    var timer4: Timer?
    
    @IBOutlet var cooker: UIView!
    
    @IBOutlet var foodItem1Label: UILabel!
    @IBOutlet var foodItem2Label: UILabel!
    @IBOutlet var timeRemaining1Label: UILabel!
    @IBOutlet var timeRemaining2Label: UILabel!
    
    @IBOutlet var timer1ProgessView: CircularProgressView!
    @IBOutlet var timer2ProgessView: CircularProgressView!
    @IBOutlet var timer3ProgessView: CircularProgressView!
    @IBOutlet var timer4ProgessView: CircularProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpLayout()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /****************************************************************************************
    *
    *   Timer Code
    *
    ****************************************************************************************/
    func handleTimer1(timeRemaining: Int) {
        self.timeRemaining1Label.text = makeTimeLabel(timeRemaining)
        timer1ProgessView.progress = Double(timeRemaining) / Double(timer1!.foodItem.cookingTimeMax * 60)
    }
    
    func handleTimer2(timeRemaining: Int) {
        self.timeRemaining2Label.text = makeTimeLabel(timeRemaining)
        timer2ProgessView.progress = Double(timeRemaining) / Double(timer2!.foodItem.cookingTimeMax * 60)
    }
    
    func makeTimeLabel(timeRemaining: Int) -> NSString {
        var secondsRemaining = timeRemaining
        let minutes = secondsRemaining / 60
        secondsRemaining -= (minutes * 60)
        
        let seconds = secondsRemaining > 9 ? String(secondsRemaining):"0" + String(secondsRemaining)

        return "\(minutes):\(seconds)"
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
    
    func tappedCooker(sender: UITapGestureRecognizer){
        foodListViewController.timer = sender.view!.restorationIdentifier
        foodListViewController.delegate = self
        self.navigationController?.pushViewController(foodListViewController, animated: true)
    }
    
    func setUpLayout(){
        self.cooker.layer.borderWidth = 2
        self.cooker.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.cooker.layer.cornerRadius = 5
        
        setUpCircleProgressView(self.timer1ProgessView)
        setUpCircleProgressView(self.timer2ProgessView)
        setUpCircleProgressView(self.timer3ProgessView)
        setUpCircleProgressView(self.timer4ProgessView)
        
        setFont(self.foodItem1Label)
        setFont(self.foodItem2Label)
        setFont(self.timeRemaining1Label)
        setFont(self.timeRemaining2Label)


    }
    
    func setFont(label: UILabel?) {
        if label != nil {
            label!.font = UIFont(name: "Roboto-Light", size: 20)!
        }
    }
    
    func setUpCircleProgressView(circleProgessView: CircularProgressView?) {
        if circleProgessView != nil {
            circleProgessView!.progress = 1
            circleProgessView!.clockwise = false
            circleProgessView!.trackWidth = 5
            circleProgessView!.trackBackgroundColor = UIColor.lightGrayColor()
            circleProgessView!.trackFillColor = UIColor.kooktijdenGreenColor()
            circleProgessView!.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "tappedCooker:"))
            circleProgessView!.userInteractionEnabled = true
        }

    }
    
}
