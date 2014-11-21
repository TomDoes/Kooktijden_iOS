//
//  CookerController.swift
//  Kooktijden
//
//  Created by Harm Brugge on 11-11-14.
//  Copyright (c) 2014 De appothekers. All rights reserved.
//

import UIKit

class CookerController: UIViewController, StartTimerDelegate, UIPageViewControllerDataSource {
    
    var timer1: Timer?
    var timer2: Timer?
    
    private var pageViewController: UIPageViewController?
    
    var cooker1Controller: CookerViewController?
    var cooker2Controller: CookerViewController?
    
    var cookerControllers: NSMutableArray? = NSMutableArray()
    
    @IBOutlet var foodItem1Label: UILabel!
    @IBOutlet var foodItem2Label: UILabel!
    @IBOutlet var timeRemaining1Label: UILabel!
    @IBOutlet var timeRemaining2Label: UILabel!
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController as FoodListViewController
        vc.delegate = self
        vc.timer = segue.identifier
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Cooking times"
        createPageViewController()
        
        setupPageControl()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /****************************************************************************************
    *
    *   Timer Code
    *
    ****************************************************************************************/
    func handleTimer1(timeRemaining: String) {
        self.timeRemaining1Label.text = timeRemaining
    }
    func handleTimer2(timeRemaining: String) {
        self.timeRemaining2Label.text = timeRemaining
    }
    
    func startTimer(foodItem: FoodItem, timer: String) {
        if (timer == "timer1") {
            self.foodItem1Label.text = foodItem.nameEN
            if (timer1 != nil) { timer1!.stop() }
            timer1 = Timer(duration: foodItem.cookingTimeMax, handler: handleTimer1)
            timer1!.start()
        }
        if (timer == "timer2") {
            self.foodItem2Label.text = foodItem.nameEN
            if (timer2 != nil) { timer2!.stop() }
            timer2 = Timer(duration: foodItem.cookingTimeMax, handler: handleTimer2)
            timer2!.start()
        }
    }
    
    /****************************************************************************************
    *
    *   PageViewController Code
    *
    ****************************************************************************************/
    
    private func createPageViewController() {
        
        initializeControllers()
        
        let pageController = self.storyboard!.instantiateViewControllerWithIdentifier("PageController") as UIPageViewController
        pageController.dataSource = self
        let startingViewControllers: NSArray = [cooker1Controller!]
        
        pageController.setViewControllers(startingViewControllers, direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        
        pageViewController = pageController
        addChildViewController(pageViewController!)
        self.view.addSubview(pageViewController!.view)
        pageViewController!.didMoveToParentViewController(self)
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        let itemViewController = viewController as CookerViewController
        
        if itemViewController.itemIndex > 0 {
            return cookerControllers?.objectAtIndex(itemViewController.itemIndex - 1) as CookerViewController
        }
        
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        let itemViewController = viewController as CookerViewController

        if itemViewController.itemIndex < cookerControllers!.count - 1 {
            return cookerControllers?.objectAtIndex(itemViewController.itemIndex + 1) as CookerViewController
        }
        
        return nil
    }
    
    private func setupPageControl() {
        let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = UIColor.grayColor()
        appearance.currentPageIndicatorTintColor = UIColor.whiteColor()
        appearance.backgroundColor = UIColor.darkGrayColor()
    }
    
    private func initializeControllers(){
        cooker1Controller = CookerViewController(nibName: "Cooker1ViewController", bundle: nil)
        cooker2Controller = CookerViewController(nibName: "Cooker2ViewController", bundle: nil)
        
        cooker1Controller?.itemIndex = 0
        cooker2Controller?.itemIndex = 1
        
        cookerControllers!.addObject(cooker1Controller!)
        cookerControllers!.addObject(cooker2Controller!)
    }
    
    
}