//
//  AppDelegate.m
//  JiongJiongYouShen
//
//  Created by deng on 15/4/27.
//  Copyright (c) 2015年 deng. All rights reserved.
//

#import "AppDelegate.h"
#import "JJNavigationController.h"
#import "JJTabBarController.h"
#import "JJFirstViewController.h"
#import "JJSecondViewController.h"
#import "JJThirdViewController.h"
#import "JJProfileTableViewController.h"
//#import "SDWebImage/SDImageCache.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //Add a custom read-only cache path
   // NSString *bundledPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"CustomPathImages"];
   // [[SDImageCache sharedImageCache] addReadOnlyCachePath:bundledPath];
    
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    // 纯文
    JJFirstViewController *messageRootViewController = [[JJFirstViewController alloc] init];
    messageRootViewController.title = @"纯文";
    messageRootViewController.tabBarItem.image = [[UIImage imageNamed:@"Document_N"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
     messageRootViewController.tabBarItem.selectedImage=[[UIImage imageNamed:@"Document"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
   
    JJNavigationController *messageNavigationController = [[JJNavigationController alloc] initWithRootViewController:messageRootViewController];
    
    //图片
    JJSecondViewController *contactTableViewController = [[JJSecondViewController alloc] init];
    contactTableViewController.title = @"图片";
    contactTableViewController.tabBarItem.image = [[UIImage imageNamed:@"Photos_N"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    contactTableViewController.tabBarItem.selectedImage = [[UIImage imageNamed:@"Photos"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    JJNavigationController *contactNavigationController = [[JJNavigationController alloc] initWithRootViewController:contactTableViewController];
    
    //视频
    JJThirdViewController *discoverTableViewController = [[JJThirdViewController alloc] init];
    discoverTableViewController.title =@"视频";
    discoverTableViewController.tabBarItem.image = [[UIImage imageNamed:@"Play_N"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    discoverTableViewController.tabBarItem.selectedImage = [[UIImage imageNamed:@"Play"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    JJNavigationController *discoverNavigationController = [[JJNavigationController alloc] initWithRootViewController:discoverTableViewController];
    
    // 我
    JJProfileTableViewController *profileTableViewController = [[JJProfileTableViewController alloc] init];
    profileTableViewController.title =@"我";
    profileTableViewController.tabBarItem.image =[[UIImage imageNamed:@"User_N"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    profileTableViewController.tabBarItem.selectedImage =[[UIImage imageNamed:@"User"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    JJNavigationController *profileNavigationController = [[JJNavigationController alloc] initWithRootViewController:profileTableViewController];
    
    // tab bar
    JJTabBarController *rootTabBarController = [[JJTabBarController alloc] init];
    rootTabBarController.viewControllers = [NSArray arrayWithObjects:messageNavigationController, contactNavigationController, discoverNavigationController, profileNavigationController, nil];
    
    // setup UI Image
    UIColor *color = [UIColor colorWithRed:0.176 green:0.576 blue:0.980 alpha:1.000];
   // [rootTabBarController.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbarBkg"]];
    [rootTabBarController.tabBar setSelectedImageTintColor:color];
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:1.000 green:0.287 blue:0.967 alpha:0.5]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor whiteColor], NSForegroundColorAttributeName, [UIFont boldSystemFontOfSize:17], NSFontAttributeName, nil]];
    
     self.window.rootViewController = rootTabBarController;
    [self.window makeKeyAndVisible];
    
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

@end
