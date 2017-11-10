//
//  AppDelegate.m
//  Cauction
//
//  Created by Stefan Lage on 08/11/2017.
//  Copyright © 2017 Stefan Lage. All rights reserved.
//

#import "AppDelegate.h"
#import "CApiClient.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:[UIViewController new]];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
