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
    @IBOutlet var deleteBtn: UIButton!
    @IBOutlet var plus30: UILabel!
    
    @IBAction func pauseBtn(sender: UIButton) {
        if timer!.timer.valid {
            self.timer!.pause()
            self.pauseBtn.setImage(UIImage(named: "ic_action_play.png"), forState: .Normal)
            //self.pauseBtn.setTitle(NSLocalizedString("CookerDetailViewController.startBtnTitle",comment:"Start"), forState: .Normal)
        }
        else {
            self.timer!.start()
            self.pauseBtn.setImage(UIImage(named: "ic_action_pause.png"), forState: .Normal)
            //self.pauseBtn.setTitle(NSLocalizedString("CookerDetailViewController.pauseBtnTitle",comment:"Pause"), forState: .Normal)
        }
    }
    
    @IBAction func deleteBtn(sender: UIButton) {
        let alertView = SCLAlertView()
        alertView.addButton(NSLocalizedString("CookerDetailViewController.alertYes",comment:"Yes"), target: self, selector: "deleteTimer")
        alertView.showKooktijden(NSLocalizedString("CookerDetailViewController.alertTitle",comment:"Delete timer"), subTitle: NSLocalizedString("CookerDetailViewController.alertSubTitle",comment:"Are you sure?"), closeButtonTitle: NSLocalizedString("CookerDetailViewController.alertNo",comment:"No"))
    }
    
    func deleteTimer() {
        self.timerDelegate?.deleteTimer()
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    var timerDelegate: TimerDelegate?
    
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    
    let pauseImage: UIImage? = UIImage(named: "ic_action_pause.png")
    let playImage: UIImage? = UIImage(named: "ic_action_play.png")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpLayout()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        setUpLayout()
        self.timer!.handler = handleTimer
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpLayout() {
        //self.pauseBtn.setTitle(NSLocalizedString("CookerDetailViewController.pauseBtnTitle",comment:"Pause"), forState: .Normal)
        
        if timer!.timer.valid { self.pauseBtn.setImage(pauseImage, forState: .Normal) }
        else { self.pauseBtn.setImage(playImage, forState: .Normal) }
        
        self.cooker.layer.borderWidth = 2
        self.cooker.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.cooker.layer.cornerRadius = 20

        self.foodItemLabel.textColor = UIColor(white:0.95, alpha:1.0)
        self.foodItemLabel.font = UIFont(name: "Roboto-Light", size: (screenSize.width / 2.2) )
        self.foodItemLabel.text = timer!.foodItem.name[0]

        self.timeRemainingLabel.font = UIFont(name: "Roboto-Thin", size: (screenSize.width / 4.5) )
        self.timeRemainingLabel.text = makeTimeLabel(timer!.timeRemaining)
        
        setUpCircleProgressView(circularProgessView)
        
        var removeImage = UIImage(named: "ic_action_delete")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        
        self.deleteBtn.setImage(removeImage, forState: .Normal)
        self.deleteBtn.tintColor = UIColor(white:0.5, alpha:1.0)
        
        self.plus30.font = UIFont(name: "Roboto-Thin", size: (screenSize.width / 13) )
        self.plus30.userInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: "add30Seconds:")
        self.plus30.addGestureRecognizer(tapGesture)
    }

    func setUpCircleProgressView(circleProgessView: CircularProgressView?) {
        circleProgessView!.clockwise = false
        circleProgessView!.trackWidth = screenSize.width / 20
        circleProgessView!.trackFillColor = UIColor(white:0.4, alpha:1.0)
        circleProgessView!.centerFillColor = UIColor(white:0.8, alpha:1.0)
        circleProgessView!.trackBackgroundColor = self.timer!.foodItem.letterColor!
        circleProgessView!.progress = Double(timer!.timeRemaining) / Double(timer!.duration)
    }
    
    func handleTimer(timeRemaining: Int) {
        self.timeRemainingLabel.text = makeTimeLabel(timeRemaining)
        circularProgessView.progress = Double(timeRemaining) / Double(timer!.duration)
        if timeRemaining == 0 {
            shakeView(circularProgessView)
            self.pauseBtn.setImage(playImage, forState: .Normal)
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
    
    func add30Seconds(sender:UITapGestureRecognizer) {
        self.timer!.add30Seconds()
    }
    

}
