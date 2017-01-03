//
//  ViewController.swift
//  Facebook-Pop
//
//  Created by yueyeqi on 8/13/16.
//  Copyright © 2016 yueyeqi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var dataArray: [String]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createData()
    }

    ///创建数据源
    func createData() {
        dataArray = ["基础动画：移动", "基础动画：旋转", "弹性动画：移动", "弹性动画：放大", "衰减动画：移动", "自定义动画"]
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let vc = segue.destinationViewController as? AnimationViewController {
            vc.animationType = sender?.integerValue
        }
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let CellID = "Normal"
        
        let cell = UITableViewCell(style: .Default, reuseIdentifier: CellID)
        cell.textLabel?.text = dataArray[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        performSegueWithIdentifier("animation", sender: indexPath.row)
        
    }

}

