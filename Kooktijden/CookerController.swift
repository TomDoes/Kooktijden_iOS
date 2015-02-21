//
//  CookerController.swift
//  Kooktijden
//
//  Created by Harm Brugge on 11-11-14.
//  Copyright (c) 2014 De appothekers. All rights reserved.
//

import UIKit

class CookerController: UIViewController, UIPageViewControllerDataSource {
    
    private var pageViewController: UIPageViewController?
    
    var cookerControllers: [CookerViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = NSLocalizedString("CookerController.title",comment:"Cooking Times")
        createPageViewController()
        setupPageControl()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        let startingViewControllers: NSArray = [cookerControllers[0]]
        
        pageController.setViewControllers(startingViewControllers, direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        
        pageViewController = pageController
        addChildViewController(pageViewController!)
        self.view.addSubview(pageViewController!.view)
        pageViewController!.didMoveToParentViewController(self)
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        let itemViewController = viewController as CookerViewController
        
        if itemViewController.itemIndex > 0 {
            return cookerControllers[itemViewController.itemIndex - 1] as CookerViewController
        }
        
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        let itemViewController = viewController as CookerViewController

        if itemViewController.itemIndex < cookerControllers.count - 1 {
            return cookerControllers[itemViewController.itemIndex + 1] as CookerViewController
        }
        
        return nil
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return cookerControllers.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    private func setupPageControl() {
        let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = UIColor.grayColor()
        appearance.currentPageIndicatorTintColor = UIColor.whiteColor()
        appearance.backgroundColor = UIColor.darkGrayColor()
    }
    
    private func initializeControllers(){
        var cooker1Controller = CookerViewController(nibName: "Cooker1ViewController", bundle: nil)
        var cooker2Controller = CookerViewController(nibName: "Cooker2ViewController", bundle: nil)
        var cooker3Controller = CookerViewController(nibName: "Cooker3ViewController", bundle: nil)
        var cooker4Controller = CookerViewController(nibName: "Cooker4ViewController", bundle: nil)
        
        cooker1Controller.itemIndex = 0
        cooker2Controller.itemIndex = 1
        cooker3Controller.itemIndex = 2
        cooker4Controller.itemIndex = 3
        
        cookerControllers.append(cooker1Controller)
        cookerControllers.append(cooker2Controller)
        cookerControllers.append(cooker3Controller)
        cookerControllers.append(cooker4Controller)
    }
    
    
}