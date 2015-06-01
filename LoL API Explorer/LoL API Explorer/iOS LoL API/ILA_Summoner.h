//
//  ILA_Summoner.h
//  LoL API Explorer
//
//  Created by Victor Ilisei on 5/31/15.
//  Copyright (c) 2015 Tech Genius. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ILA_SummonerDto.h"
#import "ILA_MasteryPagesDto.h"

@interface ILA_Summoner : NSObject

+ (void)getSummonersForSummonerNames:(NSArray *)summonerNames :(void (^)(NSDictionary *summonerMap))completionBlock :(void (^)(NSInteger httpResponseCode))errorBlock;
+ (void)getSummonersForSummonerIds:(NSArray *)summonerIds :(void (^)(NSDictionary *summonerMap))completionBlock :(void (^)(NSInteger httpResponseCode))errorBlock;
+ (void)getSummonerMasteriesForSummonerIds:(NSArray *)summonerIds :(void (^)(NSDictionary *summonerMap))completionBlock;

@end