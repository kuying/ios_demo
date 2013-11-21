//
//  DemoAppDelegate.m
//  demo
//
//  Created by 库颖 on 13-11-20.
//  Copyright (c) 2013年 库颖. All rights reserved.
//

#import "DemoAppDelegate.h"

#import "ElementsTableViewController.h"

#import "ElementsSortedByNameDataSource.h"
#import "ElementsSortedByAtomicNumberDataSource.h"
#import "ElementsSortedBySymbolDataSource.h"
#import "ElementsSortedByStateDataSource.h"

@implementation DemoAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // for each tableview 'screen' we need to create a datasource instance
    // (the class that is passed in) we then need to create an instance of
    // ElementsTableViewController with that datasource instance finally we need to return
    // a UINaviationController for each screen, with the ElementsTableViewController as the
    // root view controller.
    //
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    
    // the class type for the datasource is not crucial, but that it implements the
	// ElementsDataSource protocol and the UITableViewDataSource Protocol
    //
    id<ElementsDataSource, UITableViewDataSource> dataSource;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NSMutableArray *viewControllers = [NSMutableArray arrayWithCapacity:4];
    
    // create our tabbar view controllers, since we already have one defined in our storyboard
    // we will create 3 more instances of it, and assign each it's own kind data source
    
    // by name
    UINavigationController *navController = [storyboard instantiateViewControllerWithIdentifier:@"navForTableView"];
    ElementsTableViewController *viewController = (ElementsTableViewController *)[navController topViewController];
    dataSource = [[ElementsSortedByNameDataSource alloc] init];
    viewController.dataSource = dataSource;
    [viewControllers addObject:navController];
    
    // by atomic number
    navController = [storyboard instantiateViewControllerWithIdentifier:@"navForTableView"];
    viewController = (ElementsTableViewController *)[navController topViewController];
    dataSource = [[ElementsSortedByAtomicNumberDataSource alloc] init];
    viewController.dataSource = dataSource;
    [viewControllers addObject:navController];
    
    // by symbol
    navController = [storyboard instantiateViewControllerWithIdentifier:@"navForTableView"];
    viewController = (ElementsTableViewController *)[navController topViewController];
    dataSource = [[ElementsSortedBySymbolDataSource alloc] init];
    viewController.dataSource = dataSource;
    [viewControllers addObject:navController];
    
    // by state
    navController = [storyboard instantiateViewControllerWithIdentifier:@"navForTableView"];
    viewController = (ElementsTableViewController *)[navController topViewController];
    dataSource = [[ElementsSortedByStateDataSource alloc] init];
    viewController.dataSource = dataSource;
    [viewControllers addObject:navController];
    
    tabBarController.viewControllers = viewControllers;
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
