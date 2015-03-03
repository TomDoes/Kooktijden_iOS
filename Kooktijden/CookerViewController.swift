//
//  CookerViewController.swift
//  Kooktijden
//
//  Created by Tom Doesburg on 21/11/14.
//  Copyright (c) 2014 De appothekers. All rights reserved.
//

import UIKit

class CookerViewController: UIViewController {
        
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
        self.cooker.layer.borderColor = UIColor(white:0.8, alpha:1.0).CGColor
        self.cooker.layer.cornerRadius = 10
        
        addViewToStove(stove1, stoveIdentifier: "stove1")
        addViewToStove(stove2, stoveIdentifier: "stove2")
        addViewToStove(stove3, stoveIdentifier: "stove3")
        addViewToStove(stove4, stoveIdentifier: "stove4")
        addViewToStove(stove5, stoveIdentifier: "stove5")
    }
    
    func addViewToStove(stove: UIView?, stoveIdentifier: NSString?) {
        if stove != nil {
            let viewController: StoveViewController = StoveViewController(nibName: "StoveViewController", bundle: nil)
            self.addChildViewController(viewController)
            stove!.addSubview(viewController.view)
            viewController.stove = stoveIdentifier
            viewController.view.frame.size = stove!.frame.size
        }
    }
    
}
