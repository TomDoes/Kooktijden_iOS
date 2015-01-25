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
    
    let duration: Int
    let foodItem: FoodItem
    var elapsedTime: Int = 0
    var timeRemaining: Int = 0
    
    var sound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("sound", ofType: "wav")!)
    var audioPlayer = AVAudioPlayer()
    
    let notificationCenter = NSNotificationCenter.defaultCenter()
    
    init(foodItem: FoodItem, handler: (Int) -> ()) {
        self.duration = foodItem.cookingTimeMax
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
        
        self.handler(timeRemaining)
        
        if self.elapsedTime == self.duration {
            self.stop()
            self.elapsedTime = 0
            
            let alert = UIAlertView()
            alert.title = foodItem.nameEN + " cooked!"
            alert.message = ""
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