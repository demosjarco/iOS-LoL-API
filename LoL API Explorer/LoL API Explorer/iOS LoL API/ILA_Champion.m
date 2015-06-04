//
//  ILA_Champion.m
//  LoL API Explorer
//
//  Created by Victor Ilisei on 1/20/15.
//  Copyright (c) 2015 Tech Genius. All rights reserved.
//

#import "ILA_Connection.h"
#import "ILA_Setup.h"
#import "ILA_Champion.h"

@implementation ILA_Champion

/**
 Retrieve all champions. (REST)
 @return @p champions - This object contains a collection of champion information.
 */
+ (void)getAllChampionsWithOnlyFreeChamps:(BOOL)onlyFreeToPlayChamps :(void (^)(NSArray *))completionBlock {
    NSURLComponents *components = [NSURLComponents new];
    [components setScheme:@"https"];
    [ILA_Connection getRegionHost:^(NSString *host) {
        [components setHost:host];
        
        [ILA_Connection getRegionCode:^(NSString *regionCode) {
            @autoreleasepool {
                NSArray *endpoints = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Endpoints" ofType:@"plist"]];
                NSDictionary *endpointSection = endpoints[0];
                NSArray *subEndpoints = endpointSection[@"subEndpoints"];
                NSDictionary *endpoint = subEndpoints[0];
                
                [components setPath:[endpoint[@"relativePath"] stringByReplacingOccurrencesOfString:@"{region}" withString:regionCode]];
            }
            
            [ILA_Setup getAPIkey:^(NSString *apiKey) {
                [components setQuery:[NSString stringWithFormat:@"freeToPlay=%@&api_key=%@", onlyFreeToPlayChamps ? @"true" : @"false", apiKey]];
                [ILA_Connection connectToServer:[components URL] withFilename:[NSString stringWithFormat:@"allChamps_%@", onlyFreeToPlayChamps ? @"true" : @"false"] inFolder:@"champion" :^(id json, NSInteger responseCode, BOOL fromCache) {
                    completionBlock(json[@"champions"]);
                }];
            }];
        }];
    }];
}

+ (void)getChampionByID:(int)champID :(void (^)(NSDictionary *))completionBlock {
    NSURLComponents *components = [NSURLComponents new];
    [components setScheme:@"https"];
    [ILA_Connection getRegionHost:^(NSString *host) {
        [components setHost:host];
        
        [ILA_Connection getRegionCode:^(NSString *regionCode) {
            @autoreleasepool {
                NSArray *endpoints = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Endpoints" ofType:@"plist"]];
                NSDictionary *endpointSection = endpoints[0];
                NSArray *subEndpoints = endpointSection[@"subEndpoints"];
                NSDictionary *endpoint = subEndpoints[1];
                
                [components setPath:[[endpoint[@"relativePath"] stringByReplacingOccurrencesOfString:@"{region}" withString:regionCode] stringByReplacingOccurrencesOfString:@"{id}" withString:[NSString stringWithFormat:@"%d", champID]]];
            }
            
            [ILA_Setup getAPIkey:^(NSString *apiKey) {
                [components setQuery:[NSString stringWithFormat:@"api_key=%@", apiKey]];
                [ILA_Connection connectToServer:[components URL] withFilename:[NSString stringWithFormat:@"champ_%d", champID] inFolder:@"champion" :^(id json, NSInteger responseCode, BOOL fromCache) {
                    completionBlock(json);
                }];
            }];
        }];
    }];
}

@end