//
//  Timer.swift
//  Kooktijden
//
//  Created by Harm Brugge on 09-11-14.
//  Copyright (c) 2014 De appothekers. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class Timer {
    var timer = NSTimer()
    var handler: (Int) -> ()
    
    var duration: Int
    let foodItem: FoodItem
    let stove: String
    var startTime: NSDate
    
    var elapsedTime: Int = 0
    var timeRemaining: Int = 0
    var timeElapsedBeforePause: Int = 0
    
    var finished = false
    
    var userDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    var sound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("alarm", ofType: "wav")!)
    var audioPlayer = AVAudioPlayer()
    
    let notificationCenter = NSNotificationCenter.defaultCenter()
    
    init(foodItem: FoodItem, handler: (Int) -> (), stove: String) {
        self.duration = foodItem.cookingTimeMax
        self.handler = handler
        self.foodItem = foodItem
        self.stove = stove
        self.startTime = NSDate()
    }
    
    
    func start() {
        self.startTime = NSDate()
        self.tick()
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1.0,
            target: self,
            selector: Selector("tick"),
            userInfo: nil,
            repeats: true)
        self.setUserDefaults()
    }
    
    func pause() {
        self.timeElapsedBeforePause = self.elapsedTime
        timer.invalidate()
        NSUserDefaults().removeObjectForKey(stove)
    }
    
    func stop() {
        timer.invalidate()
        self.elapsedTime = 0
        self.finished = true
        self.userDefaults.removeObjectForKey(stove)
    }
    
    func add30Seconds() {
        self.duration += 30
    }
    
    @objc func tick() {
        self.elapsedTime = Int(NSDate().timeIntervalSinceDate(self.startTime)) + self.timeElapsedBeforePause
        self.timeRemaining = self.duration - self.elapsedTime
        
        if self.timeRemaining == 0 {
            self.stop()
            self.showAlert()
        }
        if (self.timeRemaining < 0) {
            self.timeRemaining = 0
            self.stop()
        }
        
        self.handler(timeRemaining)
    }
    
    func showAlert() {
        let alert = SCLAlertView();
        alert.showKooktijden(NSLocalizedString("Timer.alertView.title",comment:"Timer is finished!")
            , subTitle: String(format: NSLocalizedString("Timer.alertView.subtitle",comment:" is ready"), foodItem.name), closeButtonTitle: NSLocalizedString("Timer.alertView.close",comment:"Close"))
        
        self.audioPlayer = AVAudioPlayer(contentsOfURL: self.sound, error: nil)
        audioPlayer.numberOfLoops = 3
        audioPlayer.play()
    }
    
    func setUserDefaults() {
        let timeInterval = NSTimeInterval(self.timeRemaining)
        var alertInfo = [
            "date": NSDate(timeIntervalSinceNow: timeInterval),
            "foodName": foodItem.name,
            "title": NSLocalizedString("Timer.alertView.title",comment:"Timer is finished!"),
            "body": String(format: NSLocalizedString("Timer.alertView.subtitle",comment:" is ready"), foodItem.name)
        ]
        self.userDefaults.setObject(alertInfo, forKey: stove)
    }
    
    deinit {
        self.timer.invalidate()
    }
}