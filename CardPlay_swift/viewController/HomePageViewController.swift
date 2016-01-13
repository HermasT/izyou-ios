//
//  HomePageViewController.swift
//  CardPlay_swift
//
//  Created by wudi on 1/8/16.
//  Copyright © 2016 wudi. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    convenience init(){
        self.init(nibName:"HomePageViewController", bundle:nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "首页"
        imageView.setImageWithURL(NSURL.init(string: "http://www.uimaker.com/uploads/allimg/120801/1_120801005405_1.png"))
         let client = CTHTTPClient.init()
         let request = CTHttpClientUtil.URLRequestForSOAGet(NSURL.init(string: "http://im.ctrip.com:5280/api/archive/13207174729"), parameters: nil)

        client.asyncJSONRequest(request, timeout: 5, success: {
            (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) -> Void in
            if(responseObject.isKindOfClass(NSDictionary)){
                let error :NSInteger = responseObject["error"] as! NSInteger
                if(error == 0){
                    let message = responseObject["message"] as! NSArray
                    if(message.isKindOfClass(NSArray)){
                       // print(message)
                    }
                }
            }
            }, faild: { (operation: AFHTTPRequestOperation!,error: NSError!) in
              //  print(error)
                
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonclicked(sender: AnyObject) {
        let  subVC = SubViewController.init()
        self.navigationController?.pushViewController(subVC, animated:true)
    }

}
