//
//  ILA_FeaturedGames.m
//  LoL API Explorer
//
//  Created by Victor Ilisei on 5/23/15.
//  Copyright (c) 2015 Tech Genius. All rights reserved.
//

#import "ILA_Connection.h"
#import "ILA_Setup.h"
#import "ILA_FeaturedGames.h"

@implementation ILA_FeaturedGames

/**
 @warning Don't refresh earlier than the interval (in seconds) specified in @p clientRefreshInterval in order to preserve server integrity and prevent a 429.
 */
+ (void)getFeaturedGames:(void (^)(NSDictionary *))completionBlock {
    NSURLComponents *components = [NSURLComponents new];
    [components setScheme:@"https"];
    [ILA_Connection getRegionHost:^(NSString *host) {
        [components setHost:host];
        @autoreleasepool {
            NSArray *endpoints = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Endpoints" ofType:@"plist"]];
            NSDictionary *endpointSection = endpoints[2];
            NSArray *subEndpoints = endpointSection[@"subEndpoints"];
            NSDictionary *endpoint = subEndpoints[0];
            
            [components setPath:endpoint[@"relativePath"]];
        }
        [ILA_Setup getAPIkey:^(NSString *apiKey) {
            [components setQuery:[NSString stringWithFormat:@"api_key=%@", apiKey]];
            [ILA_Connection connectToServer:[components URL] withFilename:@"featuresGames" inFolder:@"featuresGames" :^(id json, NSInteger responseCode, BOOL fromCache) {
                completionBlock(json);
            }];
        }];
    }];
}

@end