//
//  MoreViewController.swift
//  CardPlay_swift
//
//  Created by wudi on 1/8/16.
//  Copyright © 2016 wudi. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController {

    convenience init(){
        self.init(nibName:"MoreViewController", bundle:nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "更多"
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
