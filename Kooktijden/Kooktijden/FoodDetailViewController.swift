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
    @IBOutlet weak var timerBtn: UIButton!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBAction func setTimer(sender: AnyObject) {
        delegate!.startTimer(self.foodItem)
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    var contentView: UIView = UIView()
    var descriptionTitleLabel: UILabel = UILabel()
    var descriptionTextLabel: UILabel = UILabel()
    var timeLabel: UILabel = UILabel()
        
    var delegate: TimerDelegate? = nil
    
    var foodItem: FoodItem!
    var timerId: String?
    
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
        foodTitleLabel.text = foodItem.name
        foodTitleLabel.textColor = UIColor.whiteColor()
        descriptionTitleLabel.text = NSLocalizedString("FoodDetailViewController.descriptionTitle", comment: "Description")
        timeLabel.text = String(format: NSLocalizedString("FoodDetailViewController.cookingTimeLabel", comment: "Cookingtime: xx minutes"), foodItem.cookingTimeMax/60)
        descriptionTextLabel.text = foodItem.descriptionText
        headerView.backgroundColor = UIColor.kooktijdenGreenColor()
        timerBtn.backgroundColor = UIColor.kooktijdenPinkColor()
        timerBtn.layer.cornerRadius = timerBtn.frame.size.width / 2.0
        
        //Fonts
        foodTitleLabel.font = UIFont(name: "Roboto-Light", size: 24)!
        timeLabel.font = UIFont(name: "Roboto-Light", size: 18)!
        descriptionTitleLabel.font = UIFont(name: "Roboto-Light", size: 20)!
        descriptionTextLabel.font = UIFont(name: "Roboto-Light", size: 18)!
        
        // Add content view to scrollview
        scrollView.addSubview(contentView)
        contentView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addConstraint(NSLayoutConstraint(
            item: contentView,
            attribute: NSLayoutAttribute.LeadingMargin,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.view,
            attribute: NSLayoutAttribute.Leading,
            multiplier: 1,
            constant: 0))
        self.view.addConstraint(NSLayoutConstraint(
            item: contentView,
            attribute: NSLayoutAttribute.TrailingMargin,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.view,
            attribute: NSLayoutAttribute.Trailing,
            multiplier: 1,
            constant: 0))
        self.view.addConstraint(NSLayoutConstraint(
            item: contentView,
            attribute: NSLayoutAttribute.TopMargin,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.scrollView,
            attribute: NSLayoutAttribute.Top,
            multiplier: 1,
            constant: 0))
        self.view.addConstraint(NSLayoutConstraint(
            item: contentView,
            attribute: NSLayoutAttribute.BottomMargin,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.scrollView,
            attribute: NSLayoutAttribute.Bottom,
            multiplier: 1,
            constant: -30))

        
        // Add timelabel to contentview
        contentView.addSubview(timeLabel)
        timeLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addConstraint(NSLayoutConstraint(
            item: self.timeLabel,
            attribute: NSLayoutAttribute.LeadingMargin,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.contentView,
            attribute: NSLayoutAttribute.Leading,
            multiplier: 1,
            constant: 30))
        self.view.addConstraint(NSLayoutConstraint(
            item: self.timeLabel,
            attribute: NSLayoutAttribute.TopMargin,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.contentView,
            attribute: NSLayoutAttribute.Top,
            multiplier: 1,
            constant: 30))
        
        // Add description title to contentview
        contentView.addSubview(descriptionTitleLabel)
        descriptionTitleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addConstraint(NSLayoutConstraint(
            item: self.descriptionTitleLabel,
            attribute: NSLayoutAttribute.LeadingMargin,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.contentView,
            attribute: NSLayoutAttribute.Leading,
            multiplier: 1,
            constant: 30))
        self.view.addConstraint(NSLayoutConstraint(
            item: self.descriptionTitleLabel,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.timeLabel,
            attribute: NSLayoutAttribute.Bottom,
            multiplier: 1,
            constant: 10))
        
        // Add description to contentview
        contentView.addSubview(descriptionTextLabel)
        self.descriptionTextLabel.numberOfLines = 0
        self.descriptionTextLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addConstraint(NSLayoutConstraint(
            item: descriptionTextLabel,
            attribute: NSLayoutAttribute.LeadingMargin,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.contentView,
            attribute: NSLayoutAttribute.Leading,
            multiplier: 1,
            constant: 30))
        self.view.addConstraint(NSLayoutConstraint(
            item: descriptionTextLabel,
            attribute: NSLayoutAttribute.TrailingMargin,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.contentView,
            attribute: NSLayoutAttribute.Trailing,
            multiplier: 1,
            constant: -30))
        self.view.addConstraint(NSLayoutConstraint(
            item: descriptionTextLabel,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.descriptionTitleLabel,
            attribute: NSLayoutAttribute.Bottom,
            multiplier: 1,
            constant: 20))
        self.view.addConstraint(NSLayoutConstraint(
            item: descriptionTextLabel,
            attribute: NSLayoutAttribute.BottomMargin,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.contentView,
            attribute: NSLayoutAttribute.Bottom,
            multiplier: 1,
            constant: 0))
        
        // Zodat text niet over timerbutton loopt
        self.view.bringSubviewToFront(self.timerBtn)
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
