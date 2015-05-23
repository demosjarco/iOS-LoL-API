//
//  ILA_Game.m
//  LoL API Explorer
//
//  Created by Victor Ilisei on 5/23/15.
//  Copyright (c) 2015 Tech Genius. All rights reserved.
//

#import "ILA_Connection.h"
#import "ILA_Setup.h"
#import "ILA_Game.h"

@implementation ILA_Game

/**
 */
+ (void)getRecentGamesOfSummoner:(long)summonerID :(void (^)(NSDictionary *))completionBlock {
    NSURLComponents *components = [NSURLComponents new];
    [components setScheme:@"https"];
    [ILA_Connection getRegionHost:^(NSString *host) {
        [components setHost:host];
        
        [ILA_Connection getRegionCode:^(NSString *regionCode) {
            @autoreleasepool {
                NSArray *endpoints = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Endpoints" ofType:@"plist"]];
                NSDictionary *endpointSection = endpoints[3];
                NSArray *subEndpoints = endpointSection[@"subEndpoints"];
                NSDictionary *endpoint = subEndpoints[0];
                
                [components setPath:[[endpoint[@"relativePath"] stringByReplacingOccurrencesOfString:@"{region}" withString:regionCode] stringByReplacingOccurrencesOfString:@"{summonerId}" withString:[NSString stringWithFormat:@"%ld", summonerID]]];
            }
            
            [ILA_Setup getAPIkey:^(NSString *apiKey) {
                [components setQuery:[NSString stringWithFormat:@"api_key=%@", apiKey]];
                [ILA_Connection connectToServer:[components URL] withFilename:[NSString stringWithFormat:@"recentGames_%ld", summonerID] inFolder:@"game" :^(id json, BOOL fromCache) {
                    completionBlock(json);
                }];
            }];
        }];
    }];
}

@end