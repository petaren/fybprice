//
//  priceGraphAppDelegate.m
//  fybse
//
//  Created by Petar Mataic on 2013-12-05.
//  Copyright (c) 2013 Petar Mataic. All rights reserved.
//

#import "PriceGraphAppDelegate.h"
#import "PriceGraphViewController.h"
#import <Crashlytics/Crashlytics.h>

@implementation PriceGraphAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    NSLog(@"%s", __PRETTY_FUNCTION__);


    NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:100 * 1024 diskCapacity:100 * 1024 diskPath:nil];
    [NSURLCache setSharedURLCache:cache];

    [Crashlytics startWithAPIKey:@"214d389f61b37ab7b33987b206e5d938ae031ee1"];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    NSLog(@"%s", __PRETTY_FUNCTION__);

    PriceGraphViewController *rootVC = (PriceGraphViewController*)self.window.rootViewController;
    [rootVC stopUpdatingTimeSince];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    NSLog(@"%s", __PRETTY_FUNCTION__);

    PriceGraphViewController *rootVC = (PriceGraphViewController*)self.window.rootViewController;
    [rootVC refreshData];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

@end
