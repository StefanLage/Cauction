//
//  AppDelegate.m
//  Cauction
//
//  Created by Stefan Lage on 08/11/2017.
//  Copyright © 2017 Stefan Lage. All rights reserved.
//

#import "AppDelegate.h"
#import "CApiClient.h"
#import "CAuctionsViewModel.h"
#import "CAuctionsViewController.h"

@interface AppDelegate ()
@property (nonatomic, strong) UINavigationController *navigationController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    if ([AppDelegate isTesting]){
        // No need to create VM and VC while doing Unit Tests here
        // Would be different for UI Unit tests though
        self.navigationController = [[UINavigationController alloc] initWithRootViewController:[UIViewController new]];
    }
    else{
        // Create view model, injecting store
        CAuctionsViewModel *auctionsViewModel = [[CAuctionsViewModel alloc] initWithApiClient: [CApiClient new]];
        // Create view controller, injecting view model
        CAuctionsViewController *auctionsViewController = [[CAuctionsViewController alloc] initWithViewModel:auctionsViewModel];
        // Wrap it in navigation controller before setting it as root view
        self.navigationController = [[UINavigationController alloc] initWithRootViewController:auctionsViewController];
    }
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    return YES;
}

+ (BOOL) isTesting
{
    NSDictionary* environment = [[NSProcessInfo processInfo] environment];
    return [environment objectForKey:@"TEST"] != nil;
}

@end
