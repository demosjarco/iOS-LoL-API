//
//  AppDelegate.m
//  LoL API Explorer
//
//  Created by Victor Ilisei on 1/20/15.
//  Copyright (c) 2015 Tech Genius. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    API_Setup *apiSetup = [[API_Setup alloc] init];
    
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:apiSetup];
    [self.window makeKeyAndVisible];
    return YES;
}

@end