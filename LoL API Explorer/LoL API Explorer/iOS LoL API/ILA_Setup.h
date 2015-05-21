//
//  ILA_Setup.h
//  LoL API Explorer
//
//  Created by Victor Ilisei on 1/20/15.
//  Copyright (c) 2015 Tech Genius. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ILA_Setup : NSObject

+ (void)getAPIkey :(void (^)(NSString *apiKey))completionBlock;
+ (void)getLeagueRegion :(void (^)(NSString *regionCode))completionBlock;

@end