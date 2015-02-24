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
    
    
    var cookerControllers: [CookerViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = NSLocalizedString("CookerController.title",comment:"Cooking Times")
        self.navigationItem.setRightBarButtonItem(UIBarButtonItem(image: UIImage(named: "cog"), style: UIBarButtonItemStyle.Plain, target: self, action: "settingsBtnClicked"),animated:true)
        
        initializeControllers()
        
        // Starting cookerController
        self.view.addSubview(cookerControllers[2].view)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func initializeControllers(){
        cookerControllers.append(CookerViewController(nibName: "Cooker1ViewController", bundle: nil))
        cookerControllers.append(CookerViewController(nibName: "Cooker2ViewController", bundle: nil))
        cookerControllers.append(CookerViewController(nibName: "Cooker3ViewController", bundle: nil))
        cookerControllers.append(CookerViewController(nibName: "Cooker4ViewController", bundle: nil))
        
        addControllersAsChild(cookerControllers)
    }
    
    private func addControllersAsChild(controllers: [CookerViewController]) {
        for controller in controllers {
            self.addChildViewController(controller)
            controller.view.frame.size = self.view.frame.size
        }
    }
    
    func selectCooker(index: Int) {
        self.view.addSubview(cookerControllers[index].view)
    }
    
    func settingsBtnClicked() {
        var settingsController: SettingsController = SettingsController(nibName: "SettingsController", bundle: nil)
        settingsController.delegate = self;
        self.presentViewController(settingsController, animated: true, completion: nil)
    }
    
    
}