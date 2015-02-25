//
//  SettingsController.swift
//  Kooktijden
//
//  Created by Harm Brugge on 24-02-15.
//  Copyright (c) 2015 De appothekers. All rights reserved.
//

import UIKit

class SettingsController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet var headerView: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var setBtn: UIButton!
    @IBOutlet var closeBtn: UIButton!
    @IBOutlet var stovePicker: UIPickerView!
    
    @IBAction func closeBtn(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil )
    }
    
    @IBAction func setBtn(sender: AnyObject) {
        self.delegate?.selectCooker(stovePicker.selectedRowInComponent(0))
        self.dismissViewControllerAnimated(true, completion: nil )
    }
    
    var delegate : SettingsDelegate? = nil
    
    let numberOfStoves = [1,2,4,5]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpLayout()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func setUpLayout() {
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.text = NSLocalizedString("SettingsController.titleLabel", comment: "Set custom timer")
        closeBtn.setTitle(NSLocalizedString("SettingsController.closeBtnTitle", comment: "Close"), forState: UIControlState.Normal)
        headerView.backgroundColor = UIColor.kooktijdenGreenColor()
        setBtn.backgroundColor = UIColor.kooktijdenPinkColor()
        setBtn.setTitle(NSLocalizedString("SettingsController.setBtnTitle", comment: "Set"), forState: UIControlState.Normal)
        setBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        setBtn.layer.cornerRadius = setBtn.frame.size.width / 2.0
        
        //Fonts
        titleLabel.font = UIFont(name: "Roboto-Light", size: 24)!
        
        setBtn.titleLabel?.font = UIFont(name: "Roboto-Light", size: 20)!
        closeBtn.titleLabel?.font = UIFont(name: "Roboto-Light", size: 20)!
        
        stovePicker.selectRow(NSUserDefaults.standardUserDefaults().integerForKey("stoveIndex"), inComponent: 0, animated: true)
        
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 4
    }
    
    /*
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 20
    }
    */
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView {
        let pickerLabel = UILabel()
        var titleData = "\(numberOfStoves[row])"
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Roboto-Light", size: 20)!,NSForegroundColorAttributeName:UIColor.blackColor()])
        pickerLabel.attributedText = myTitle
        pickerLabel.textAlignment = .Center
        return pickerLabel
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
