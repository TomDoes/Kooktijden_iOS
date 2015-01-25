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

    @IBAction func closeTimer(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil )
    }
    
    
    @IBAction func setTimer(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil )

        delegate!.setCustomTimer(getCustomFoodItem())

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(component == 0) {
            // hours
            return 5
        }
        else if(component == 1) {
            // minutes
            return 60
        }
        else {
            // seconds
            return 60
        }
        
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
            return row.description
    }
    
    func getCustomFoodItem() -> FoodItem {
        var foodItem = FoodItem()
        foodItem.id = -1
        foodItem.nameEN = "My timer"
        foodItem.nameNL = "Mijn timer"
        foodItem.descriptionEN = "My timer"
        foodItem.descriptionNL = "Mijn timer"
        foodItem.cookingTimeMin = getCustomTime()
        foodItem.cookingTimeMax = foodItem.cookingTimeMin
        
        return foodItem
    }
    
    func getCustomTime() -> Int {
        var hours = timerPicker.selectedRowInComponent(0)
        var minutes = timerPicker.selectedRowInComponent(1)
        var seconds = timerPicker.selectedRowInComponent(2)
        
        return hours * 60 * 60 + minutes * 60 + seconds
        
    }
    
}
