//
//  CookerViewController.swift
//  Kooktijden
//
//  Created by Tom Doesburg on 21/11/14.
//  Copyright (c) 2014 De appothekers. All rights reserved.
//

import UIKit

class CookerViewController: UIViewController, StartTimerDelegate {

    var foodListViewController: FoodListViewController = FoodListViewController(nibName: "FoodListViewController", bundle: nil)
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var label2: UILabel!
    
    @IBAction func cookerBtn(sender: AnyObject) {
        
        foodListViewController.timer = sender.restorationIdentifier
        foodListViewController.delegate = self
        self.navigationController?.pushViewController(foodListViewController, animated: true)
    }
    
    func startTimer(foodItem: FoodItem, timer: String) {
        NSLog("%@", timer)
    }
    
    var itemIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
