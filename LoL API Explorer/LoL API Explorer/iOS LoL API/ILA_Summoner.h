//
//  ILA_Summoner.h
//  LoL API Explorer
//
//  Created by Victor Ilisei on 5/31/15.
//  Copyright (c) 2015 Tech Genius. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ILA_Summoner : NSObject

+ (void)getSummonersForSummonerNames:(NSArray *)summonerNames :(void (^)())completionBlock;
// + (void) :(void (^)())completionBlock;
// + (void) :(void (^)())completionBlock;
// + (void) :(void (^)())completionBlock;
// + (void) :(void (^)())completionBlock;
// + (void) :(void (^)())completionBlock;

@end