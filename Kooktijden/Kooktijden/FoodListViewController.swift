//
//  FoodListViewController.swift
//  Kooktijden
//
//  Created by Harm Brugge on 07-11-14.
//  Copyright (c) 2014 De appothekers. All rights reserved.
//

import UIKit

class FoodListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var foodListTableView: UITableView!
    
    var dataSource = DataSource()
    var tableData = []
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableData = dataSource.getFoods()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "MyTestCell")
        
        cell.textLabel.text = String(indexPath.item)
        
        return cell
    }
    
    
}

