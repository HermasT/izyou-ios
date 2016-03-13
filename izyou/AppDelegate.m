//
//  AppDelegate.m
//  CardPlay
//
//  Created by wudi on 1/8/16.
//  Copyright © 2016 wudi. All rights reserved.
//

#import "AppDelegate.h"
#import "RDVTabBarController.h"
#import "RDVTabBarItem.h"


#import "HomePageViewController.h"
#import "CoursesViewController.h"
#import "QuestionBankViewController.h"
#import "MoreViewController.h"
#import <SMS_SDK/SMSSDK.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self setupViewControllers];
    [self.window setRootViewController:self.viewController];
    [self.window makeKeyAndVisible];
    
     [self setupSMSService];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark 

- (void)setupViewControllers {
    UIViewController *firstVC = [[HomePageViewController  alloc] init];
    UIViewController *firstNavi = [[UINavigationController alloc]
                                                   initWithRootViewController:firstVC];
    
    UIViewController *secondVC = [[CoursesViewController alloc] init];
    UIViewController *secondNavi = [[UINavigationController alloc]
                                                    initWithRootViewController:secondVC];
    
    UIViewController *thirdVC = [[QuestionBankViewController alloc] init];
    UIViewController *thirdNavi = [[UINavigationController alloc]
                                                   initWithRootViewController:thirdVC];
    
    
    UIViewController *forthVC = [[MoreViewController alloc] init];
    UIViewController *forthNavi = [[UINavigationController alloc]
                                                   initWithRootViewController:forthVC];
    
    RDVTabBarController *tabBarController = [[RDVTabBarController alloc] init];
    [tabBarController setViewControllers:@[firstNavi, secondNavi,
                                           thirdNavi,forthNavi]];
    self.viewController = tabBarController;
    
    [self customizeTabBarForController:tabBarController];
}
- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController {
    UIImage *finishedImage = [UIImage imageNamed:@"tabbar_selected_background"];
    UIImage *unfinishedImage = [UIImage imageNamed:@"tabbar_normal_background"];
    NSArray *tabBarItemImages = @[@"first", @"second", @"third",@"third"];
    NSArray *tabBarItemTitle = @[@"首页",@"课程",@"题库",@"更多"];
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",
                                                        [tabBarItemImages objectAtIndex:index]]];
        
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        item.title = [tabBarItemTitle objectAtIndex:index];
        index++;
    }
}

- (void)setupSMSService{
//    [SMSSDK registerApp:appKey
//             withSecret:appSecret];
}

@end
