//
//  ViewController1.swift
//  PageMenu
//
//  Created by KentarOu on 2016/09/03.
//  Copyright © 2016年 KentarOu. All rights reserved.
//

import UIKit

class ViewController1: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 20
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView()
    }
    
    // Data Array
    var dataArray = ["複数行対応1、複数行対応1、複数行対応1、複数行対応1","複数行対応2、複数行対応2","複数行対応3、複数行対応3、複数行対応3、複数行対応3、複数行対応3、複数行対応3、複数行対応3","複数行対応4","複数行対応5、複数行対応5、複数行対応5、複数行対応5、","複数行対応1、複数行対応1、複数行対応1、複数行対応1","複数行対応2、複数行対応2","複数行対応3、複数行対応3、複数行対応3、複数行対応3、複数行対応3、複数行対応3、複数行対応3","複数行対応4","複数行対応5、複数行対応5、複数行対応5、複数行対応5、","複数行対応1、複数行対応1、複数行対応1、複数行対応1","複数行対応2、複数行対応2","複数行対応3、複数行対応3、複数行対応3、複数行対応3、複数行対応3、複数行対応3、複数行対応3","複数行対応4","複数行対応5、複数行対応5、複数行対応5、複数行対応5、"]
    
    // MARK: - TableView Delegate & DataSource
    
    // Row Count
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    // Generate Cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = dataArray[indexPath.row]
        cell.backgroundColor = UIColor ( red: 0.7822, green: 0.9389, blue: 0.993, alpha: 1.0 )
        return cell
    }
    
    // Select Cell
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        print("Cell Tap - ",indexPath.row)
    }
}