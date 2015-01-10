//
//  CookerViewController.swift
//  Kooktijden
//
//  Created by Tom Doesburg on 21/11/14.
//  Copyright (c) 2014 De appothekers. All rights reserved.
//

import UIKit

class CookerViewController: UIViewController {
    
    var itemIndex = 0
    
    @IBOutlet var cooker: UIView!
    
    @IBOutlet var stove1: UIView!
    @IBOutlet var stove2: UIView!
    @IBOutlet var stove3: UIView!
    @IBOutlet var stove4: UIView!
    @IBOutlet var stove5: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpLayout()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpLayout() {
        self.cooker.layer.borderWidth = 2
        self.cooker.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.cooker.layer.cornerRadius = 5
        
        addViewToStove(stove1)
        addViewToStove(stove2)
        addViewToStove(stove3)
        addViewToStove(stove4)
        addViewToStove(stove5)

    }
    
    func addViewToStove(stove: UIView?) {
        if stove != nil {
            let viewController: StoveViewController = StoveViewController(nibName: "StoveViewController", bundle: nil)
            self.addChildViewController(viewController)
            stove!.addSubview(viewController.view)
            viewController.view.frame.size = stove!.frame.size
        }
    }
    
}
