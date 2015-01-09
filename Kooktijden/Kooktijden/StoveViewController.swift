//
//  StoveViewController.swift
//  Kooktijden
//
//  Created by Harm Brugge on 08-01-15.
//  Copyright (c) 2015 De appothekers. All rights reserved.
//

import UIKit
import QuartzCore

class StoveViewController: UIViewController, StartTimerDelegate {
    
    var foodListViewController: FoodListViewController = FoodListViewController(nibName: "FoodListViewController", bundle: nil)
    var cookerDetailViewController: CookerDetailViewController = CookerDetailViewController(nibName: "CookerDetailViewController", bundle: nil)

    var timer: Timer?
    
    @IBOutlet var foodItemLabel: UILabel!
    @IBOutlet var timeRemainingLabel: UILabel!
    
    @IBOutlet var timerProgessView: CircularProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayout()
    }
    
    override func viewDidAppear(animated: Bool) {
        if timer != nil && timer?.timeRemaining != 0 {
            self.timeRemainingLabel.text = makeTimeLabel(self.timer!.timeRemaining)
            self.timer!.handler = self.handleTimer
        }
        else {
            timeRemainingLabel.text = "Choose"
            timerProgessView.progress = 1
        }
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
    func handleTimer(timeRemaining: Int) {
        self.timeRemainingLabel.text = makeTimeLabel(timeRemaining)
        timerProgessView.progress = Double(timeRemaining) / Double(timer!.foodItem.cookingTimeMax * 60)
        if timeRemaining == 0 {
            shakeView(timerProgessView)
        }
    }
    
    func makeTimeLabel(timeRemaining: Int) -> NSString {
        var secondsRemaining = timeRemaining
        let minutes = secondsRemaining / 60
        secondsRemaining -= (minutes * 60)
        
        let seconds = secondsRemaining > 9 ? String(secondsRemaining):"0" + String(secondsRemaining)
        
        return "\(minutes):\(seconds)"
    }
    
    func startTimer(foodItem: FoodItem) {
        if (timer != nil) { timer!.stop() }
        self.foodItemLabel.text = foodItem.nameEN
//        self.timerProgessView.centerFillColor = UIColor.listColor0()
        timer = Timer(foodItem: foodItem, handler: handleTimer)
        timer!.start()
    }
    
    func cookerTap(sender: UITapGestureRecognizer){
        if timer != nil && timer?.timeRemaining != 0 {
            cookerDetailViewController.timer = timer
            self.navigationController?.pushViewController(cookerDetailViewController, animated: true)
        }
        else {
            foodListViewController.delegate = self
            self.navigationController?.pushViewController(foodListViewController, animated: true)
        }
        
    }
    
    func setUpLayout(){
        setUpCircleProgressView(self.timerProgessView)
        
        self.foodItemLabel.font = UIFont(name: "Roboto-Light", size: 20)
        self.timeRemainingLabel.font = UIFont(name: "Roboto-Light", size: 20)

    }
    
    
    func setUpCircleProgressView(circleProgessView: CircularProgressView?) {
        circleProgessView!.progress = 1
        circleProgessView!.clockwise = false
        circleProgessView!.trackWidth = 5
        circleProgessView!.trackBackgroundColor = UIColor.lightGrayColor()
        circleProgessView!.trackFillColor = UIColor.kooktijdenGreenColor()
        circleProgessView!.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "cookerTap:"))
        circleProgessView!.userInteractionEnabled = true
    }
    
    func shakeView(view: UIView) {
        var shake:CABasicAnimation = CABasicAnimation(keyPath: "position")
        shake.duration = 0.05
        shake.repeatCount = 10
        shake.autoreverses = true
        
        shake.fromValue = NSValue(CGPoint: CGPointMake(view.center.x - 3, view.center.y))
        shake.toValue = NSValue(CGPoint: CGPointMake(view.center.x + 3, view.center.y))
        
        view.layer.addAnimation(shake, forKey: "position")
    }
    
    
    
}
