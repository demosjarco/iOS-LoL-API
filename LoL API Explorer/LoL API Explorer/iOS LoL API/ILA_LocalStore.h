//
//  ILA_LocalStore.h
//  LoL API Explorer
//
//  Created by Victor Ilisei on 1/20/15.
//  Copyright (c) 2015 Tech Genius. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ILA_LocalStore : NSObject

+ (void)saveCacheOf:(id)json withName:(NSString *)fileName inFolder:(NSString *)folder :(void (^)(BOOL succeeded))completionBlock;
+ (void)getCacheOfFilename:(NSString *)fileName inFolder:(NSString *)folder :(void (^)(NSDictionary *dictJson, NSArray *arrJson))completionBlock;

@end