//
//  AppDelegate.h
//  Cauction
//
//  Created by Stefan Lage on 08/11/2017.
//  Copyright © 2017 Stefan Lage. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

/**
 * Check whether the current environnement is unit test one
 */
+ (BOOL) isTesting;

@end

