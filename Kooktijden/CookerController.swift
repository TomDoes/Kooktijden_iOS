//
//  CookerController.swift
//  Kooktijden
//
//  Created by Harm Brugge on 11-11-14.
//  Copyright (c) 2014 De appothekers. All rights reserved.
//

protocol SettingsDelegate {
    func selectCooker(index: Int)
}

import UIKit

class CookerController: UIViewController, SettingsDelegate {
    
    var cookerXibs: [String] = [
        "Cooker1ViewController",
        "Cooker2ViewController",
        "Cooker3ViewController",
        "Cooker4ViewController",
    ]
    
    var cookerController = CookerViewController(nibName: "Cooker3ViewController", bundle: nil)
    
    var currentIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = NSLocalizedString("CookerController.title",comment:"Cooking Times")
        self.navigationItem.setRightBarButtonItem(UIBarButtonItem(image: UIImage(named: "cog"), style: UIBarButtonItemStyle.Plain, target: self, action: "settingsBtnClicked"),animated:true)
        
        // Starting cookerController
        let defaults = NSUserDefaults.standardUserDefaults()
        if let index: AnyObject = defaults.objectForKey("stoveIndex") {
            selectCooker(index as Int)
        }
        else {
            // First run only
            self.settingsBtnClicked()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func selectCooker(index: Int) {
        // If same cooker is selected do nothing
        if self.currentIndex != index {
            // Remove controller from view
            self.cookerController.view.removeFromSuperview()
            self.cookerController.removeFromParentViewController()
            
            // Add new controller to view
            self.cookerController = CookerViewController(nibName: cookerXibs[index], bundle: nil)
            self.addChildViewController(self.cookerController)
            cookerController.view.frame.size = self.view.frame.size
            self.view.addSubview(self.cookerController.view)
            
            // Add index to User Defaults
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setInteger(index, forKey: "stoveIndex")
            
            // Remove timers from user defaults
            removeTimersUserDefaults()
            
            self.currentIndex = index
        }
    }
    
    func removeTimersUserDefaults() {
        let stoves = ["stove1","stove2","stove3","stove4","stove5"]
        for stove in stoves {
            NSUserDefaults.standardUserDefaults().removeObjectForKey(stove)
        }
    }
    
    func settingsBtnClicked() {
        var settingsController: SettingsController = SettingsController(nibName: "SettingsController", bundle: nil)
        settingsController.delegate = self;
        self.presentViewController(settingsController, animated: true, completion: nil)
    }
    
    
}