//
//  ILA_Champion.h
//  LoL API Explorer
//
//  Created by Victor Ilisei on 1/20/15.
//  Copyright (c) 2015 Tech Genius. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ILA_ChampionDto.h"

@interface ILA_Champion : NSObject

+ (void)getAllChampionsWithOnlyFreeChamps:(BOOL) onlyFreeToPlayChamps :(void (^)(NSArray *champions))completionBlock;
+ (void)getChampionByID:(int)champID :(void (^)(NSDictionary *champInfo))completionBlock;

@end