//
//  L_contants.swift
//  LearningSwift
//
//  Created by AEF-RD-1 on 16/1/15.
//  Copyright © 2016年 yim. All rights reserved.
//

import Foundation
import UIKit

let IS_IOS7 = (UIDevice.currentDevice().systemVersion as NSString).doubleValue >= 7.0
let IS_IOS8 = (UIDevice.currentDevice().systemVersion as NSString).doubleValue >= 8.0
let kDEVICE_W = UIScreen.mainScreen().bounds.size.width
let kDEVICE_H = UIScreen.mainScreen().bounds.size.height
let kSBNAME_L0115 = "L_0115Storyboard"

var debug = false;


/**
 颜色值
 
 - parameter r: red
 - parameter g: green
 - parameter b: blue
 - parameter a: alpha
 */
func RGBA(r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor { return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a) }

func MMPrint(format: NSObject) {
    
    if debug {
        print(format)
    }
}


func MMLog(funcc:String,cName:String,line:String,items: Any...) {
    
    let date:NSDate = NSDate.init()
    let formater:NSDateFormatter = NSDateFormatter.init()
    formater.setLocalizedDateFormatFromTemplate("yyyy-MM-dd HH:mm:ss:sss")
    let timeString = formater.stringFromDate(date)
    
    //let line = __LINE__;
    //print("\(date.description) \(items[1]) L:\(line) \(__FUNCTION__)")
    print("\(timeString) LearningSwift L:\(line) [\(cName) \(funcc)] \(items)")

}
