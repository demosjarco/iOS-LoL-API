//
//  ILA_CurrentGame.m
//  LoL API Explorer
//
//  Created by Victor Ilisei on 5/23/15.
//  Copyright (c) 2015 Tech Genius. All rights reserved.
//

#import "ILA_Connection.h"
#import "ILA_Setup.h"
#import "ILA_CurrentGame.h"

@implementation ILA_CurrentGame

/**
 */
+ (void)getSpectatorGameInfoOfSummoner:(long)summonerID :(void (^)(NSDictionary *))completionBlock {
    NSURLComponents *components = [NSURLComponents new];
    [components setScheme:@"https"];
    [ILA_Connection getRegionHost:^(NSString *host) {
        [components setHost:host];
        
        [ILA_Connection getRegionPlatformID:^(NSString *regionPlatformID) {
            @autoreleasepool {
                NSArray *endpoints = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Endpoints" ofType:@"plist"]];
                NSDictionary *endpointSection = endpoints[1];
                NSArray *subEndpoints = endpointSection[@"subEndpoints"];
                NSDictionary *endpoint = subEndpoints[0];
                
                [components setPath:[[endpoint[@"relativePath"] stringByReplacingOccurrencesOfString:@"{platformId}" withString:regionPlatformID] stringByReplacingOccurrencesOfString:@"{summonerId}" withString:[NSString stringWithFormat:@"%ld", summonerID]]];
            }
            
            [ILA_Setup getAPIkey:^(NSString *apiKey) {
                [components setQuery:[NSString stringWithFormat:@"api_key=%@", apiKey]];
                NSLog(@"%@", [components URL].absoluteString);
                [ILA_Connection connectToServer:[components URL] withFilename:[NSString stringWithFormat:@"currentGame_%ld", summonerID] inFolder:@"currentGame" :^(id json, BOOL fromCache) {
                    completionBlock(json);
                }];
            }];
        }];
    }];
}

@end