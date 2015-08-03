//
//  StoveViewController.swift
//  Kooktijden
//
//  Created by Harm Brugge on 08-01-15.
//  Copyright (c) 2015 De appothekers. All rights reserved.
//

protocol TimerDelegate {
    func startTimer(foodItem:FoodItem)
    func deleteTimer()
}

import UIKit

class StoveViewController: UIViewController, TimerDelegate {
    
    var foodListViewController: FoodListViewController = FoodListViewController(nibName: "FoodListViewController", bundle: nil)
    var cookerDetailViewController: CookerDetailViewController = CookerDetailViewController(nibName: "CookerDetailViewController", bundle: nil)
    
    var timer: Timer?
    
    var stove: String?
    
    @IBOutlet var foodItemLabel: UILabel!
    @IBOutlet var timeRemainingLabel: UILabel!
    
    @IBOutlet var timerProgessView: CircularProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayout()
    }
    
    // Op dit moment is de frame.width pas beschikbaar
    override func viewDidLayoutSubviews() {
        setUpScalableLayout()
    }
    
    override func viewWillAppear(animated: Bool) {
        if (timer != nil) {
            if(timer!.timer.valid || timer!.elapsedTime > 0) {
                self.timeRemainingLabel.text = makeTimeLabel(self.timer!.timeRemaining)
                self.timerProgessView.progress = Double(timer!.timeRemaining) / Double(timer!.duration)
                self.timer!.handler = self.handleTimer
            } else if (timer!.finished) {
                deleteTimer()
                timeRemainingLabel.text = NSLocalizedString("StoveViewController.timeRemainingLabel",comment:"Choose")
                timerProgessView.progress = 1
            } else {
                self.timeRemainingLabel.text = NSLocalizedString("StoveViewController.timeRemainingLabel.start",comment:"Start")
            }
        }
        else {
            timeRemainingLabel.text = NSLocalizedString("StoveViewController.timeRemainingLabel",comment:"Choose")
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
        timerProgessView.progress = Double(timeRemaining) / Double(timer!.duration)
        if (timeRemaining == 0) {
            shakeView(timerProgessView)
        }
    }
    
    func makeTimeLabel(timeRemaining: Int) -> String {
        var secondsRemaining = timeRemaining
        let minutes = secondsRemaining / 60
        secondsRemaining -= (minutes * 60)
        
        let seconds = secondsRemaining > 9 ? String(secondsRemaining):"0" + String(secondsRemaining)
        
        return "\(minutes):\(seconds)"
    }
    
    func startTimer(foodItem: FoodItem) {
        if (timer != nil) { timer!.stop() }
        
        self.foodItemLabel.text = foodItem.name[0]
        self.timerProgessView.trackFillColor = UIColor(white:0.4, alpha:1.0)
        self.timerProgessView.centerFillColor = UIColor(white:0.9, alpha:1.0)
        self.timerProgessView.trackBackgroundColor = foodItem.letterColor!
        timer = Timer(foodItem: foodItem, handler: handleTimer, stove: self.stove!)
        
        self.view.superview?.superview?.bringSubviewToFront(self.view.superview!)
    }
    
    func deleteTimer() {
        self.foodItemLabel.text = ""
        timerProgessView.trackBackgroundColor = UIColor(white:0.4, alpha:1.0)
        timerProgessView.centerFillColor = UIColor.whiteColor()
        timerProgessView.trackFillColor = UIColor.kooktijdenGreenColor()
        
        self.timer!.stop()
        self.timer = nil
        
        self.view.superview?.superview?.sendSubviewToBack(self.view.superview!)
    }
    
    func cookerTap(sender: UITapGestureRecognizer) {
        if (timer != nil) {
            if (timer!.timer.valid || timer!.elapsedTime > 0) {
                cookerDetailViewController.timerDelegate = self
                cookerDetailViewController.timer = timer
                self.navigationController?.pushViewController(cookerDetailViewController, animated: true)
            } else if (timer!.finished){
                self.navigationController?.pushViewController(foodListViewController, animated: true)
            } else {
                timer!.start()
            }
            
        }
        else {
            foodListViewController.delegate = self
            self.navigationController?.pushViewController(foodListViewController, animated: true)
        }
        
    }
    
    func setUpLayout() {
        self.foodItemLabel.text = ""
        self.foodItemLabel.textColor = UIColor(white:0.95, alpha:1.0)
        
        timerProgessView.progress = 1
        timerProgessView.clockwise = false
        timerProgessView.trackBackgroundColor = UIColor(white:0.4, alpha:1.0)
        timerProgessView.centerFillColor = UIColor.whiteColor()
        timerProgessView.trackFillColor = UIColor.kooktijdenGreenColor()
        
        timerProgessView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "cookerTap:"))
        timerProgessView.userInteractionEnabled = true
    }
    
    // Buiten setUpLayout omdat deze als de timer actief steeds wordt aangeroepen
    func setUpScalableLayout() {
        timerProgessView.trackWidth = self.view.frame.width / 13
        
        self.foodItemLabel.font = UIFont(name: "Roboto-Light", size: (self.view.frame.width / 1.5) )
        self.timeRemainingLabel.font = UIFont(name: "Roboto-Light", size: (self.view.frame.width / 7) )
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
