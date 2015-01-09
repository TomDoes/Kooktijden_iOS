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
    @IBOutlet weak var headerView: UIView!
    
    @IBAction func setTimer(sender: AnyObject) {
        delegate!.startTimer(self.foodItem)
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    var delegate:StartTimerDelegate? = nil
    
    var foodItem: FoodItem!
    var timer: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayout()
        headerView.hidden = true
        timerBtn.hidden = true
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        animateViews()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func animateViews() {
        UIView.animateWithDuration(0.5, delay: 0.0, options: .CurveEaseOut, animations: {
            var header = self.headerView.frame
            header.origin.y += header.size.height
            self.headerView.hidden = false
            
            self.headerView.frame = header
            }, completion: { finished in
                println("header background animation finished")
        })
        
        UIView.animateWithDuration(0.5, delay: 0.5, options: .CurveEaseOut, animations: {
            var button = self.timerBtn.frame
            button.origin.x -= button.size.width + 100
            self.timerBtn.hidden = false
            
            self.timerBtn.frame = button
            }, completion: { finished in
                println("button animation finished")
        })
        
    }
    
    func setUpLayout() {
        foodTitleLabel.text = foodItem.nameEN
        foodTitleLabel.textColor = UIColor.whiteColor()
        descriptionTextView.text = foodItem.descriptionEN
        headerView.backgroundColor = UIColor.kooktijdenGreenColor()
        timerBtn.backgroundColor = UIColor.kooktijdenPinkColor()
        timerBtn.layer.cornerRadius = timerBtn.frame.size.width / 2.0
        
        //Fonts
        foodTitleLabel.font = UIFont(name: "Roboto-Light", size: 24)!
        timeLabel.font = UIFont(name: "Roboto-Light", size: 18)!
        descriptionTitleLabel.font = UIFont(name: "Roboto-Light", size: 20)!
        descriptionTextView.font = UIFont(name: "Roboto-Light", size: 18)!

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
