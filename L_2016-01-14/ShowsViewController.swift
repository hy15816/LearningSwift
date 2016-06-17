//
//  ShowsViewController.swift
//  LearningSwift
//
//  Created by AEF-RD-1 on 16/1/14.
//  Copyright © 2016年 yim. All rights reserved.
//

import UIKit
import Alamofire

class ShowsViewController: UIViewController {

    
    private var charsString:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.whiteColor()//RGBA(100,g: 22,b: 33,a: 1)
        
        
        //alamofire.re
        reqTest()
        
        
//        let str:String = "abc"
//        Alamofire.upload(.POST, "", data: str.dataUsingEncoding(NSUTF8StringEncoding)!)
        
//        let thColor = RGBA(100,g: 22,b: 33,a: 1)
        
    }
    
    internal func reqTest (){
    
        Alamofire.request(.GET, "https://api.500px.com/v1/photos").responseJSON{ (response) ->Void in
            
            let result = response.result.value
            let error = response.result.error
            let errString = (result as! NSDictionary)["error"]
            let status = (result as! NSDictionary)["status"]
            print("errString:\(errString).....status:\(status)")
            print("result:\(result)")
            if result == nil {
                print("error:\(error)")
                return
            }
            
        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
