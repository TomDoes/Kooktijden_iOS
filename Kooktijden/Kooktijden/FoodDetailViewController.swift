//
//  FoodDetailViewController.swift
//  Kooktijden
//
//  Created by Tom Doesburg on 23/11/14.
//  Copyright (c) 2014 De appothekers. All rights reserved.
//

import UIKit

class FoodDetailViewController: UIViewController {

    @IBOutlet weak var foodTitleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var descriptionTitleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var timerBtn: UIButton!
    
    @IBAction func setTimer(sender: AnyObject) {
        
    }
    
    var foodItem: FoodItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        foodTitleLabel.text = foodItem.nameEN
        descriptionTextView.text = foodItem.descriptionEN
        
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
