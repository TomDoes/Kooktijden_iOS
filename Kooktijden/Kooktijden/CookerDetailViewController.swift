//
//  CookerDetailViewController.swift
//  Kooktijden
//
//  Created by Harm Brugge on 06-01-15.
//  Copyright (c) 2015 De appothekers. All rights reserved.
//

import UIKit

class CookerDetailViewController: UIViewController {
    
    var timer: Timer?

    @IBOutlet var cooker: UIView!
    @IBOutlet var circularProgessView: CircularProgressView!
    @IBOutlet var timeRemainingLabel: UILabel!
    @IBOutlet var foodItemLabel: UILabel!
    
    @IBOutlet var pauseBtn: UIButton!
    
    @IBAction func pauseBtn(sender: UIButton) {
        if timer!.timer.valid {
            self.timer!.stop()
        }
        else {
            self.timer!.start()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.timer!.handler = handleTimer
        
        setUpLayout()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        self.timer!.handler = handleTimer
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpLayout() {
        self.cooker.layer.borderWidth = 2
        self.cooker.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.cooker.layer.cornerRadius = 15

        self.foodItemLabel.text = timer!.foodItem.nameEN
        self.foodItemLabel.font = UIFont(name: "Roboto-Light", size: 20)
        self.timeRemainingLabel.font = UIFont(name: "Roboto-Light", size: 20)
        
        
        setUpCircleProgressView(circularProgessView)
    }

    func setUpCircleProgressView(circleProgessView: CircularProgressView?) {
        circleProgessView!.progress = 1
        circleProgessView!.clockwise = false
        circleProgessView!.trackWidth = 10
        circleProgessView!.trackBackgroundColor = UIColor.lightGrayColor()
        circleProgessView!.trackFillColor = UIColor.kooktijdenGreenColor()
    }
    
    func handleTimer(timeRemaining: Int) {
        self.timeRemainingLabel.text = makeTimeLabel(timeRemaining)
        circularProgessView.progress = Double(timeRemaining) / Double(timer!.foodItem.cookingTimeMax * 60)
        if timeRemaining == 0 {
            shakeView(circularProgessView)
        }
    }
    
    func makeTimeLabel(timeRemaining: Int) -> NSString {
        var secondsRemaining = timeRemaining
        let minutes = secondsRemaining / 60
        secondsRemaining -= (minutes * 60)
        
        let seconds = secondsRemaining > 9 ? String(secondsRemaining):"0" + String(secondsRemaining)
        
        return "\(minutes):\(seconds)"
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