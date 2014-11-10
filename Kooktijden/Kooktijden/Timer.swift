//
//  Timer.swift
//  Kooktijden
//
//  Created by Harm Brugge on 09-11-14.
//  Copyright (c) 2014 De appothekers. All rights reserved.
//

import Foundation

class Timer {
    var timer = NSTimer()
    var handler: (String) -> ()
    
    let duration: Int
    var elapsedTime: Int = 0
    var timeRemaining: Int = 0
    
    init(duration: Int, handler: (String) -> ()) {
        self.duration = duration
        self.handler = handler
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
        }
    }
    
    deinit {
        self.timer.invalidate()
    }
}