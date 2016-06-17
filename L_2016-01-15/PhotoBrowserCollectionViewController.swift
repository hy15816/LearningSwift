//
//  PhotoBrowserCollectionViewController.swift
//  LearningSwift
//
//  Created by AEF-RD-1 on 16/1/15.
//  Copyright © 2016年 yim. All rights reserved.
//

import UIKit
import Alamofire


private let reuseIdentifier = "collectionCell"

/// consumerKey
private let consumerKey = "qObzhbVCNpbERy5s1fCTK7ZNqMJAPS5hyyaiZJmq"

class PhotoBrowserCollectionViewController: UICollectionViewController {
    
    var datasource = Set<PhotoInfo>();
    var populatingPhotos = false;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "photos"
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.registerClass(FirstCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView?.backgroundColor = UIColor.whiteColor();
        
        guard let collectionView = self.collectionView else { return }
        let layout = UICollectionViewFlowLayout()
        let itemWidth = (view.bounds.size.width - 2) / 3 //每行3个
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth + 15) // W = H+15
        layout.minimumInteritemSpacing = 1.0        //最小间距
        layout.minimumLineSpacing = 1.0             //最小线间距
        layout.footerReferenceSize = CGSize(width: collectionView.bounds.size.width, height: 100.0)
        collectionView.collectionViewLayout = layout
        
        
//        let funcc = __FUNCTION__
//        let cName =  classForCoder
//        let line = __LINE__;
//        MMLog(funcc, cName: String(cName),line: String(line + 1), items: "abc ")
//        NSLog("ancgshjgka", "m")
//        print(<#T##items: Any...##Any#>)
        //ShowsViewController().reqTest()
        
        // Do any additional setup after loading the view.
        //https://500px.com/signup 注册，
        //https://500px.com/settings/applications 创建应用
        //创建成功-->See application details 获取consumerKey
        let URLString = "https://api.500px.com/v1/photos"
        
        Alamofire.request(.GET, URLString, parameters: ["consumer_key":consumerKey]).responseJSON{ response in
            
            func failed() { self.populatingPhotos = false }
            
            let result = response.result.value
            //let error = response.result.error
            let photos = (result as! NSDictionary)["photos"]
//            let firstObj = (photos as! NSArray).firstObject
//            let id = (firstObj as! NSDictionary)["id"] as? Int
//            let url = (firstObj as! NSDictionary)["image_url"] as? String
            if response.result.error != nil{failed(); return}
            let p = photos as! [NSDictionary]
           
            p.forEach{
                
                guard let nsfw = $0["nsfw"] as? Bool,
                let id = $0["id"] as? Int,
                let url = $0["image_url"] as? String
                // 若nsfw的值为 false 则 return
                where nsfw == false else { return }
                
                self.datasource.insert(PhotoInfo(id: id,url: url));
            }
//            print("self.datasource:\(self.datasource)..........count:\(self.datasource.count)");
            MMPrint("count:\(self.datasource.count)")
            // 主线程刷新UI
            dispatch_async(dispatch_get_main_queue()) {
                // 向 collectionView 里插入(添加) item
                self.collectionView?.reloadData()
            }
            
//            print("id:\(id)   url:\(url)");
            
//            print("photos[0] :\(firstObj) ")
            
//            print("photos:\(photos)");
//            print("result:\(result)")
//            datasource = result["Optional"];
            
            
            
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), {
//                //
//                guard let JSONData = response.result.value else {return}
//                guard let photosJsons = JSONData.valueForKey("photos") as? [NSDictionary] else {return}
//                photosJsons.forEach{
//                    guard let nsfw = $0["nsfw"] as? Bool,
//                        let id = $0["id"] as? Int,
//                        let url = $0["image_url"] as? String
//                        // 若nsfw的值为 false 则 return
//                        where nsfw == false else { return }
//                    
//                }
//                
//                // 主线程刷新UI
//                dispatch_async(dispatch_get_main_queue()) {
//                    // 向 collectionView 里插入(添加) item
//                    self.collectionView?.reloadData()
//                }
//                
//            }
            
            
            
        }
        
    }

    @IBAction func goBLEAction(sender: UIBarButtonItem) {
        
        
        let blec = UIStoryboard.init(name: kSBNAME_L0115, bundle: nil).instantiateViewControllerWithIdentifier("BLETableViewController")
        
        self.navigationController?.pushViewController(blec, animated: true)
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.datasource.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)) as! PhotoCollectionViewCell
    
        // Configure the cell

        Alamofire.request(.GET,String(self.datasource[self.datasource.startIndex.advancedBy(indexPath.item)].url)).responseImage{ Response in
            guard let image = Response.result.value where Response.result.error == nil else {return}
            (cell.contentView.viewWithTag(1) as! UIImageView).image = image
        }
//        (cell.contentView.viewWithTag(2) as! UILabel).text = String(self.datasource[self.datasource.startIndex.advancedBy(indexPath.item)].id);
        
        cell.label.text = String(self.datasource[self.datasource.startIndex.advancedBy(indexPath.item)].id)
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    
    
    
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
 

    
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
 
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //
        
        let viewc = UIViewController.init()
        viewc.view.backgroundColor = UIColor.whiteColor();
        
        self.tabBarController?.hidesBottomBarWhenPushed = true;
//        viewc.tabBarController?.tabBar.hidden = true;
        
        self.navigationController?.pushViewController(viewc, animated: true)
        
        collectionView.deselectItemAtIndexPath(indexPath, animated: true);
        
    }
    

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imgv: UIImageView!
    @IBOutlet var label: UILabel!
}


class PhotoInfo: NSObject {
    
    let id: Int
    let url: String
    var name: String?
    
    
    init(id:Int,url:String) {
        self.id = id;
        self.url = url;
    }
    
}

extension Alamofire.Request {
    
    class func imageResponseSerializer() -> ResponseSerializer<UIImage?, NSError> {
        
        return ResponseSerializer { request, response, data, error in
            guard error == nil else { return .Failure(error!) }
            
            guard let validData = data else {
                let failureReason = "数据无法被序列化，因为接收到的数据为空"
                let error = Error.errorWithCode(.DataSerializationFailed, failureReason: failureReason)
                return .Failure(error)
            }
            
            let image = UIImage(data: validData, scale: UIScreen.mainScreen().scale)
            return .Success(image)
        }
    }
    
    // 网络请求返回的image数据
    public func responseImage(completionHandler: Response<UIImage?, NSError> -> Void) -> Self {
        return response(responseSerializer: Request.imageResponseSerializer(), completionHandler: completionHandler)
    }
}


