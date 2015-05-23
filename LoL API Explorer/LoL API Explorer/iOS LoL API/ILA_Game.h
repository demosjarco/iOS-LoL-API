//
//  ILA_Game.h
//  LoL API Explorer
//
//  Created by Victor Ilisei on 5/23/15.
//  Copyright (c) 2015 Tech Genius. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ILA_Game : NSObject

+ (void)getRecentGamesOfSummoner:(long)summonerID :(void (^)(NSDictionary *recentGames))completionBlock;

@end