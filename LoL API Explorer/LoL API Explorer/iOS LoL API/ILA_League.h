//
//  ILA_League.h
//  LoL API Explorer
//
//  Created by Victor Ilisei on 5/23/15.
//  Copyright (c) 2015 Tech Genius. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ILA_League : NSObject

+ (void)getLeagueForSummonerIDs:(NSArray *)summonerIds :(void (^)(NSDictionary *summonerMap))completionBlock;
+ (void)getLeagueEntryForSummonerIDs:(NSArray *)summonerIds :(void (^)(NSDictionary *summonerMap))completionBlock;
+ (void)getLeagueTeamForSummonerIDs:(NSArray *)teamIds :(void (^)(NSDictionary *teamMap))completionBlock;
+ (void)getLeagueTeamEntryForSummonerIDs:(NSArray *)teamIds :(void (^)(NSDictionary *teamMap))completionBlock;
+ (void)getLeagueChallenger:(NSString *)gameQueueType :(void (^)(NSDictionary *challengerMap))completionBlock;
+ (void)getLeagueMaster:(NSString *)gameQueueType :(void (^)(NSDictionary *masterMap))completionBlock;

@end