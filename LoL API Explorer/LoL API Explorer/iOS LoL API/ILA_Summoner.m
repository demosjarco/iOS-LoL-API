//
//  ILA_Summoner.m
//  LoL API Explorer
//
//  Created by Victor Ilisei on 5/31/15.
//  Copyright (c) 2015 Tech Genius. All rights reserved.
//

#import "ILA_Connection.h"
#import "ILA_Setup.h"
#import "ILA_Summoner.h"

@implementation ILA_Summoner

#pragma mark - Private Methods

+ (NSMutableArray *)standardizeNamesInMutableArray:(NSMutableArray *)array {
    NSMutableArray *standardizedNames = [[NSMutableArray alloc] init];
    for (NSString *summonerName in array) {
        [standardizedNames addObject:[[summonerName stringByReplacingOccurrencesOfString:@" " withString:@""] lowercaseString]];
    }
    return standardizedNames;
}

#pragma mark - Public Methods

/**
 @note A 404 error from this can also mean the summoner is not currently ranked
 @warning This method takes a max of 40 summoners. If you provide more than 40 in @p summonerNames it will only process the first 40.
 */
+ (void)getSummonersForSummonerNames:(NSArray *)summonerNames :(void (^)())completionBlock {
    // Trim array of summonerIds to 40.
    NSMutableArray *trimmedSummonerNames;
    if (summonerNames.count > 40) {
        trimmedSummonerNames = [NSMutableArray arrayWithArray:[summonerNames subarrayWithRange:NSMakeRange(0, 40)]];
    } else {
        trimmedSummonerNames = [NSMutableArray arrayWithArray:summonerNames];
    }
    
    // Standardize names
    NSMutableArray *standardizedSummonerNames = [self standardizeNamesInMutableArray:trimmedSummonerNames];
    
    NSURLComponents *components = [NSURLComponents new];
    [components setScheme:@"https"];
    [ILA_Connection getRegionHost:^(NSString *host) {
        [components setHost:host];
        
        [ILA_Connection getRegionCode:^(NSString *regionCode) {
            @autoreleasepool {
                NSArray *endpoints = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Endpoints" ofType:@"plist"]];
                NSDictionary *endpointSection = endpoints[10];
                NSArray *subEndpoints = endpointSection[@"subEndpoints"];
                NSDictionary *endpoint = subEndpoints[0];
                
                [components setPath:[[endpoint[@"relativePath"] stringByReplacingOccurrencesOfString:@"{region}" withString:regionCode] stringByReplacingOccurrencesOfString:@"{summonerNames}" withString:[[standardizedSummonerNames valueForKey:@"description"] componentsJoinedByString:@","]]];
            }
            
            [ILA_Setup getAPIkey:^(NSString *apiKey) {
                [components setQuery:[NSString stringWithFormat:@"api_key=%@", apiKey]];
                [ILA_Connection connectToServer:[components URL] withFilename:[NSString stringWithFormat:@"summonerNames_%@", [[standardizedSummonerNames valueForKey:@"description"] componentsJoinedByString:@"-"]] inFolder:@"summoner" :^(id json, BOOL fromCache) {
                    completionBlock(json);
                }];
            }];
        }];
    }];
}

@end