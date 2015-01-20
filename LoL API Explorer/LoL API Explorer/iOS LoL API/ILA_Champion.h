//
//  ILA_Champion.h
//  LoL API Explorer
//
//  Created by Victor Ilisei on 1/20/15.
//  Copyright (c) 2015 Tech Genius. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ILA_Champion : NSObject

+ (void)getChampionList:(BOOL)freeToPlayOnly result:(void(^)(NSArray *champions, BOOL usingLocalData))resultBlock error:(void(^)(NSError *userOffline, NSString *localizedStringForStatusCode))errorBlock;
+ (void)getChampionInfo:(int)champID result:(void(^)(NSDictionary *champion, BOOL usingLocalData))resultBlock error:(void(^)(NSError *userOffline, NSString *localizedStringForStatusCode))errorBlock;

@end