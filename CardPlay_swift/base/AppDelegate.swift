//
//  AppDelegate.swift
//  CardPlay_swift
//
//  Created by wudi on 1/8/16.
//  Copyright © 2016 wudi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var viewController: UIViewController?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.

        window = UIWindow.init(frame: UIScreen.mainScreen().bounds)
        window?.backgroundColor = UIColor.whiteColor()
        self.setupViewControllers()
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        
        self.registPushNotification()
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func setupViewControllers(){
        let firstVC = HomePageViewController.init()
        let firstNavigationVC = UINavigationController.init(rootViewController: firstVC)
        let secondVC = CoursesViewController.init()
        let secondNaviVC = UINavigationController.init(rootViewController: secondVC)
        let thirdVC = QuestionsViewController.init()
        let thirdNaviVC = UINavigationController.init(rootViewController: thirdVC)
        let forthVC = MoreViewController.init()
        let forthNaviVC = UINavigationController.init(rootViewController: forthVC)
        
        let tabController = RDVTabBarController.init()
        tabController.viewControllers = [firstNavigationVC,secondNaviVC,thirdNaviVC,forthNaviVC]
        self.viewController = tabController
        self.customizeTabBarForController(tabController)
        
    }
    
    func customizeTabBarForController(tabBarController: RDVTabBarController){
        let finishedImage = UIImage.init(named: "tabbar_selected_background")
        let unfinishedImage = UIImage.init(named: "tabbar_normal_background")
        var tabBarItemImages = ["first","second","third","first"]
        for var i = 0 ;i < tabBarController.tabBar.items.count ; i++ {
            let item :RDVTabBarItem! = tabBarController.tabBar.items[i] as! RDVTabBarItem
            item.setBackgroundSelectedImage(finishedImage, withUnselectedImage: unfinishedImage)
            let selectedImage = UIImage.init(named: NSString(format: "%@_selected", tabBarItemImages[i]) as String)
            let unselectedImage = UIImage.init(named: NSString(format: "%@_normal", tabBarItemImages[i]) as String)         

            item.setFinishedSelectedImage(selectedImage, withFinishedUnselectedImage: unselectedImage)
        }
    }
    
    func registPushNotification(){
            if #available(iOS 8.0, *) {
                UIApplication.sharedApplication().registerUserNotificationSettings(
                    UIUserNotificationSettings(
                        forTypes: [.Alert, .Badge, .Sound],
                        categories: nil))
                UIApplication.sharedApplication().registerForRemoteNotifications()
            } else {
                // Fallback on earlier versions
            }
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        var token = NSString.init(data: deviceToken, encoding: 0)
        print(token)
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        print(error)
        
    }


}

