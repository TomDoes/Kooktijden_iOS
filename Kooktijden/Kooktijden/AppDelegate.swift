//
//  AppDelegate.swift
//  Kooktijden
//
//  Created by Tom Doesburg on 7/11/14.
//  Copyright (c) 2014 De appothekers. All rights reserved.
//  
//  Comment geplaatst!

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
        setUpNavigationBar()
        
        application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes: UIUserNotificationType.Sound | UIUserNotificationType.Alert |
            UIUserNotificationType.Badge, categories: nil))
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        //Add to notification center
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"showNotification:" , name:"com.deappothekers.Kooktijden.timerFinished" , object: nil)
        
        let stoves = ["stove1","stove2","stove3","stove4","stove5"]
        
        var keys = NSUserDefaults.standardUserDefaults().dictionaryWithValuesForKeys(stoves)
        for (stoveId, value) in keys {
            if let alertInfo = value as? NSDictionary {
                println(alertInfo)
                setNotification(alertInfo)
            }
        }
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        
        UIApplication.sharedApplication().cancelAllLocalNotifications()
        
        // Remove from notificationCenter
        // NSNotificationCenter.defaultCenter().removeObserver(self, name: "com.deappothekers.Kooktijden.timerFinished", object: nil)
        
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func setUpNavigationBar() {
        // Setup Navigation bar and status bar
        var navigationBarAppearance = UINavigationBar.appearance()
        var barButtonAppearance = UIBarButtonItem.appearance()
        
        navigationBarAppearance.tintColor = UIColor.whiteColor()
        navigationBarAppearance.barTintColor = UIColor.kooktijdenGreenColor()
            
        // Title color / Font
        navigationBarAppearance.titleTextAttributes =  [NSForegroundColorAttributeName:UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "Roboto-Medium", size: 20)!]
        barButtonAppearance.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "Roboto-Light", size: 18)!], forState: UIControlState.Normal)

        
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        
    }
    
    func setNotification(alertInfo: NSDictionary) {
        var localNotification:UILocalNotification = UILocalNotification()
        localNotification.alertAction = NSLocalizedString("AppDelegate.notification.alertAction", comment:"Open app")
        localNotification.alertBody = alertInfo["body"] as? String
        localNotification.fireDate = alertInfo["date"] as? NSDate
        localNotification.soundName = "alarm.wav"
        localNotification.category = "invite"
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }

}

