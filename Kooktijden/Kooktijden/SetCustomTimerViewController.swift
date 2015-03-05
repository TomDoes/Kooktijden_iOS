//
//  SetCustomTimerViewController.swift
//  Kooktijden
//
//  Created by Tom Doesburg on 24/1/15.
//  Copyright (c) 2015 De appothekers. All rights reserved.
//

import UIKit

class SetCustomTimerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var delegate: SetCustomTimerDelegate? = nil

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timerPicker: UIPickerView!
    @IBOutlet weak var closeBtn: UIButton!

    @IBOutlet weak var timerBtn: UIButton!
    @IBOutlet weak var headerView: UIView!
    @IBAction func closeTimer(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil )
    }
    
    
    @IBAction func setTimer(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil )

        delegate!.setCustomTimer(getCustomFoodItem())

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayout()
        
    }
    
    func setUpLayout() {
        headerView.backgroundColor = UIColor.kooktijdenGreenColor()
        
        titleLabel.font = UIFont(name: "Roboto-Light", size: 24)!
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.text = NSLocalizedString("SetCustomTimerViewControler.titleLabel", comment: "Set custom timer")
        
        timerBtn.backgroundColor = UIColor.kooktijdenPinkColor()
        timerBtn.setTitle(NSLocalizedString("SetCustomTimerViewControler.timerBtnTitle", comment: "Set"), forState: UIControlState.Normal)
        timerBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        timerBtn.layer.cornerRadius = timerBtn.frame.size.width / 2.0

        timerBtn.titleLabel?.font = UIFont(name: "Roboto-Light", size: 20)!
        
        closeBtn.layer.borderWidth = 1.5
        closeBtn.layer.borderColor = UIColor(white:1.0, alpha:0.8).CGColor
    
    }
    
    override func viewDidLayoutSubviews() {
        closeBtn.layer.cornerRadius = closeBtn.bounds.width / 2.0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 6
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(component == 0) {
            // hours
            return 5
        }
        else if(component == 1) {
            // minutes
            return 1
        }
        else if(component == 2) {
            // minutes
            return 60
        }
        else if(component == 3) {
            // minutes
            return 1
        }
        else if(component == 4) {
            // minutes
            return 60
        }
        else {
            // seconds
            return 1
        }
        
    }
    

    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView {
        let pickerLabel = UILabel()
        var titleData = "";
        if(component == 1) {
            titleData = NSLocalizedString("SetCustomTimerViewControler.hourLabel",comment:"hour")
        } else if (component == 3) {
            titleData = NSLocalizedString("SetCustomTimerViewControler.minuteLabel",comment:"min.")
        } else if (component == 5) {
            titleData = NSLocalizedString("SetCustomTimerViewControler.secondLabel",comment:"sec.")
        } else {
            titleData = row.description
        }
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Roboto-Light", size: 20)!,NSForegroundColorAttributeName:UIColor.blackColor()])
        pickerLabel.attributedText = myTitle
        pickerLabel.textAlignment = .Center
        return pickerLabel
    }
    
    func getCustomFoodItem() -> FoodItem {
        var foodItem = FoodItem()
        foodItem.id = -1
        foodItem.name = NSLocalizedString("SetCustomTimerViewControler.myTimerName", comment: "My timer")
        foodItem.descriptionText = NSLocalizedString("SetCustomTimerViewControler.myTimerDescriptionText", comment: "My timer")
        foodItem.cookingTimeMin = getCustomTime()
        foodItem.cookingTimeMax = foodItem.cookingTimeMin
        foodItem.letterColor = UIColor.kooktijdenGreenColor()
        
        return foodItem
    }
    
    func getCustomTime() -> Int {
        var hours = timerPicker.selectedRowInComponent(0)
        var minutes = timerPicker.selectedRowInComponent(2)
        var seconds = timerPicker.selectedRowInComponent(4)
        
        var total = hours * 60 * 60 + minutes * 60 + seconds
        
        if total == 0 {
            total = 1
        }
        
        return total
    }
    
}
