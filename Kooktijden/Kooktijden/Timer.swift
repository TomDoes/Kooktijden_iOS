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
    var handler: (String) -> ()
    
    let duration: Int
    let foodItem: FoodItem
    var elapsedTime: Int = 0
    var timeRemaining: Int = 0
    
    var sound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("sound", ofType: "wav")!)
    var audioPlayer = AVAudioPlayer()
    
    let notificationCenter = NSNotificationCenter.defaultCenter()
    
    init(foodItem: FoodItem, handler: (String) -> ()) {
        self.duration = foodItem.cookingTimeMax * 60
//        self.duration = 15 // Handig voor testen
        self.handler = handler
        self.foodItem = foodItem
    }
    
    func start() {
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1.0,
            target: self,
            selector: Selector("tick"),
            userInfo: nil,
            repeats: true)
    }
    
    func stop() {
        timer.invalidate()
    }
    
    @objc func tick() {
        self.elapsedTime++
        self.timeRemaining = self.duration - self.elapsedTime
        
        let minutes = timeRemaining / 60
        timeRemaining -= (minutes * 60)
        
        let seconds = timeRemaining > 9 ? String(timeRemaining):"0" + String(timeRemaining)
        
        self.handler("\(minutes):\(seconds)")
        
        if self.elapsedTime == self.duration {
            self.stop()
            
            let alert = UIAlertView()
            alert.title = "Food Cooked!"
            alert.message = "Here's a message"
            alert.addButtonWithTitle("Ok")
            alert.show()
            
            var alertInfo: [String: String] = ["FoodNameEN": foodItem.nameEN, "FoodNameNL": foodItem.nameNL]
            
            notificationCenter.postNotificationName("com.deappothekers.Kooktijden.timerFinished", object: nil, userInfo: alertInfo)
            //self.audioPlayer = AVAudioPlayer(contentsOfURL: self.sound, error: nil)
            //audioPlayer.numberOfLoops = -1
            //audioPlayer.play()
        }
    }
    
    deinit {
        self.timer.invalidate()
    }
}