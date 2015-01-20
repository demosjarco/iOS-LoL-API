//
//  AppDelegate.h
//  LoL API Explorer
//
//  Created by Victor Ilisei on 1/20/15.
//  Copyright (c) 2015 Tech Genius. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "API_Setup.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) API_Setup *viewController;

@end