//
//  BLETableViewController.swift
//  LearningSwift
//
//  Created by AEF-RD-1 on 16/1/16.
//  Copyright © 2016年 yim. All rights reserved.
//

import UIKit


class BLETableViewController: UITableViewController,BLEManagerDelegate {

    var manager:LSBLEManager!
    
    var list = NSMutableArray()
    
    var rightItem : UIBarButtonItem!
    
    var dic = NSDictionary();
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        self.manager = LSBLEManager.init()
        self.manager.ls_delegate = self
        self.manager.setManager()
        
        // 8094502 / 3600 / 1000
        
        let f:Float = 8094502
        print("f-----:\(f/3600/1000)")
        
        
        var array = [String]();
        
        for i in 0...5 {
            array.insert(String(i), atIndex: 0)
        }
        print("array:\(array)")
        
    }
    
    
    
    
    /**
     url        = http://api.easou.com/api/bookapp/day_task.m
     cid        = eef
     version    = 002
     os         = ios
     udid       = 296653b7ba493d90f07797c0079d18489240bc3d
     appversion = 1024
     ch         = bnf1349_10388_001
     
     session_id = nEGUVegEvZNOn5LP3VOOzJ
     type       = 1
     cid        = eef
     
     */
    // 每日？
    // http://api.easou.com/api/bookapp/day_task.m?cid=eef_&session_id=-nEGUVegEvZNOn5LP3VOOzJ&type=1&cid=eef_&version=002&os=ios&udid=296653b7ba493d90f07797c0079d18489240bc3d&appverion=1024&ch=bnf1349_10388_001
    
    
    /**
     url        = http://api.easou.com/api/bookapp/add_bookcase.m
     cid        = eef
     version    = 002
     os         = ios
     udid       = 296653b7ba493d90f07797c0079d18489240bc3d
     appversion = 1024
     ch         = bnf1349_10388_001
     */
    // http://api.easou.com/api/bookapp/add_bookcase.m?cid=eef_&version=002&os=ios&udid=296653b7ba493d90f07797c0079d18489240bc3d&appverion=1024&ch=bnf1349_10388_001
    
    //
    
    
    /**
     url        = http://api.easou.com/api/bookapp/day_task.m
     os         = ios
     udid       = 296653b7ba493d90f07797c0079d18489240bc3d
     appversion = 1024
     ch         = bnf1349_10388_001
     session_id = -nEGUVegEvZNOn5LP3VOOzJ
     type       = 19
     cid        = eef

     */
    // http://api.easou.com/api/bookapp/day_task.m?os=ios&appverion=1024&udid=296653b7ba493d90f07797c0079d18489240bc3d&session_id=-nEGUVegEvZNOn5LP3VOOzJ&version=002&type=19&ch=bnf1349_10388_001&cid=eef_
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    // MARK: - BLEManagerDelegate
    // MARK: -
    func bleDidConnect(perip: CBPeripheral) {
        
        print("\(perip.name) did connecting")
        self.navigationItem.rightBarButtonItem = self.rightItem;
    }
    
    func bleDidDisConnect(perip: CBPeripheral) {
        
        print("\(perip.name) did dis connect")
        self.navigationItem.rightBarButtonItem =  nil;
        self.tableView.reloadData()
    }
    
    func bleStateDidChanged(state: String) {
        
    }

    func bleDidFindPeripheral(list: NSMutableArray) {
        self.list = list
        self.tableView.reloadData()
    }
    
    func bleDidReadRSSI(rssi: NSNumber) {
        print("-----------rssi:\(rssi)")
    }
    
    func bleDidUpdateValue(chc: CBCharacteristic) {
        print("chc.value:\(chc.value)")
    }

    
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.list.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellID", forIndexPath: indexPath)

        // Configure the cell...
        cell.textLabel?.text = (self.list .objectAtIndex(indexPath.row) as! CBPeripheral).name
        return cell
    }

    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
//        let control = UIViewController.init()
//        control.view.backgroundColor = UIColor.whiteColor()
//        control.title = "title\(indexPath.row)"
//        self.navigationController?.pushViewController(control, animated: true)

        self.manager .connectWithPeripheral((self.list .objectAtIndex(indexPath.row) as! CBPeripheral))
        
        
    }
    
    // MARK: - Private Method
    /**
     Setup View
     */
    func setupView() -> Void {
        
        self.tableView.tableFooterView = UIView();
        
        self.rightItem = UIBarButtonItem.init(title: "SendData", style: UIBarButtonItemStyle.Done, target: self, action: #selector(BLETableViewController.rightItemAction))
    }
    
    func rightItemAction() -> Void {
        self.manager.sendDatas()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
