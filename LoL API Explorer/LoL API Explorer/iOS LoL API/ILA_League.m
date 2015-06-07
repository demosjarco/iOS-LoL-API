//
//  ILA_League.m
//  LoL API Explorer
//
//  Created by Victor Ilisei on 5/23/15.
//  Copyright (c) 2015 Tech Genius. All rights reserved.
//

#import "ILA_Connection.h"
#import "ILA_Setup.h"
#import "ILA_League.h"

@implementation ILA_League

/**
 @note A 404 error from this can also mean the summoner is not currently ranked
 @warning This method takes a max of 10 summoners. If you provide more than 10 in @p summonerIds it will only process the first 10.
 */
+ (void)getLeagueForSummonerIDs:(NSArray *)summonerIds :(void (^)(NSDictionary *))completionBlock {
    // Trim array of summonerIds to 10.
    NSArray *trimmedSummonerIds;
    if (summonerIds.count > 10) {
        trimmedSummonerIds = [summonerIds subarrayWithRange:NSMakeRange(0, 10)];
    } else {
        trimmedSummonerIds = [NSArray arrayWithArray:summonerIds];
    }
    
    NSURLComponents *components = [NSURLComponents new];
    [components setScheme:@"https"];
    [ILA_Connection getRegionHost:^(NSString *host) {
        [components setHost:host];
        
        [ILA_Connection getRegionCode:^(NSString *regionCode) {
            @autoreleasepool {
                NSArray *endpoints = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Endpoints" ofType:@"plist"]];
                NSDictionary *endpointSection = endpoints[4];
                NSArray *subEndpoints = endpointSection[@"subEndpoints"];
                NSDictionary *endpoint = subEndpoints[0];
                
                [components setPath:[[endpoint[@"relativePath"] stringByReplacingOccurrencesOfString:@"{region}" withString:regionCode] stringByReplacingOccurrencesOfString:@"{summonerIds}" withString:[[trimmedSummonerIds valueForKey:@"description"] componentsJoinedByString:@","]]];
            }
            
            [ILA_Setup getAPIkey:^(NSString *apiKey) {
                [components setQuery:[NSString stringWithFormat:@"api_key=%@", apiKey]];
                [ILA_Connection connectToServer:[components URL] withFilename:[NSString stringWithFormat:@"league_%@", [[trimmedSummonerIds valueForKey:@"description"] componentsJoinedByString:@"-"]] inFolder:@"league" :^(id json, NSInteger responseCode, BOOL fromCache) {
                    completionBlock(json);
                }];
            }];
        }];
    }];
}

/**
 @note A 404 error from this can also mean the summoner is not currently ranked
 @warning This method takes a max of 10 summoners. If you provide more than 10 in @p summonerIds it will only process the first 10.
 */
+ (void)getLeagueEntryForSummonerIDs:(NSArray *)summonerIds :(void (^)(NSDictionary *))completionBlock :(void (^)())unrankedBlock {
    // Trim array of summonerIds to 10.
    NSArray *trimmedSummonerIds;
    if (summonerIds.count > 10) {
        trimmedSummonerIds = [summonerIds subarrayWithRange:NSMakeRange(0, 10)];
    } else {
        trimmedSummonerIds = [NSArray arrayWithArray:summonerIds];
    }
    
    NSURLComponents *components = [NSURLComponents new];
    [components setScheme:@"https"];
    [ILA_Connection getRegionHost:^(NSString *host) {
        [components setHost:host];
        
        [ILA_Connection getRegionCode:^(NSString *regionCode) {
            @autoreleasepool {
                NSArray *endpoints = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Endpoints" ofType:@"plist"]];
                NSDictionary *endpointSection = endpoints[4];
                NSArray *subEndpoints = endpointSection[@"subEndpoints"];
                NSDictionary *endpoint = subEndpoints[1];
                
                [components setPath:[[endpoint[@"relativePath"] stringByReplacingOccurrencesOfString:@"{region}" withString:regionCode] stringByReplacingOccurrencesOfString:@"{summonerIds}" withString:[[trimmedSummonerIds valueForKey:@"description"] componentsJoinedByString:@","]]];
            }
            
            [ILA_Setup getAPIkey:^(NSString *apiKey) {
                [components setQuery:[NSString stringWithFormat:@"api_key=%@", apiKey]];
                [ILA_Connection connectToServer:[components URL] withFilename:[NSString stringWithFormat:@"leagueEntry_%@", [[trimmedSummonerIds valueForKey:@"description"] componentsJoinedByString:@"-"]] inFolder:@"league" :^(id json, NSInteger responseCode, BOOL fromCache) {
                    if (responseCode == 404) {
                        unrankedBlock();
                    } else {
                        completionBlock(json);
                    }
                }];
            }];
        }];
    }];
}

/**
 @warning This method takes a max of 10 summoners. If you provide more than 10 in @p teamIds it will only process the first 10.
 */
+ (void)getLeagueTeamForSummonerIDs:(NSArray *)teamIds :(void (^)(NSDictionary *))completionBlock {
    // Trim array of summonerIds to 10.
    NSArray *trimmedTeamIds;
    if (teamIds.count > 10) {
        trimmedTeamIds = [teamIds subarrayWithRange:NSMakeRange(0, 10)];
    } else {
        trimmedTeamIds = [NSArray arrayWithArray:teamIds];
    }
    
    NSURLComponents *components = [NSURLComponents new];
    [components setScheme:@"https"];
    [ILA_Connection getRegionHost:^(NSString *host) {
        [components setHost:host];
        
        [ILA_Connection getRegionCode:^(NSString *regionCode) {
            @autoreleasepool {
                NSArray *endpoints = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Endpoints" ofType:@"plist"]];
                NSDictionary *endpointSection = endpoints[4];
                NSArray *subEndpoints = endpointSection[@"subEndpoints"];
                NSDictionary *endpoint = subEndpoints[2];
                
                [components setPath:[[endpoint[@"relativePath"] stringByReplacingOccurrencesOfString:@"{region}" withString:regionCode] stringByReplacingOccurrencesOfString:@"{teamIds}" withString:[[trimmedTeamIds valueForKey:@"description"] componentsJoinedByString:@","]]];
            }
            
            [ILA_Setup getAPIkey:^(NSString *apiKey) {
                [components setQuery:[NSString stringWithFormat:@"api_key=%@", apiKey]];
                [ILA_Connection connectToServer:[components URL] withFilename:[NSString stringWithFormat:@"leagueTeam_%@", [[trimmedTeamIds valueForKey:@"description"] componentsJoinedByString:@"-"]] inFolder:@"league" :^(id json, NSInteger responseCode, BOOL fromCache) {
                    completionBlock(json);
                }];
            }];
        }];
    }];
}

/**
 @warning This method takes a max of 10 summoners. If you provide more than 10 in @p teamIds it will only process the first 10.
 */
+ (void)getLeagueTeamEntryForSummonerIDs:(NSArray *)teamIds :(void (^)(NSDictionary *))completionBlock {
    // Trim array of summonerIds to 10.
    NSArray *trimmedTeamIds;
    if (teamIds.count > 10) {
        trimmedTeamIds = [teamIds subarrayWithRange:NSMakeRange(0, 10)];
    } else {
        trimmedTeamIds = [NSArray arrayWithArray:teamIds];
    }
    
    NSURLComponents *components = [NSURLComponents new];
    [components setScheme:@"https"];
    [ILA_Connection getRegionHost:^(NSString *host) {
        [components setHost:host];
        
        [ILA_Connection getRegionCode:^(NSString *regionCode) {
            @autoreleasepool {
                NSArray *endpoints = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Endpoints" ofType:@"plist"]];
                NSDictionary *endpointSection = endpoints[4];
                NSArray *subEndpoints = endpointSection[@"subEndpoints"];
                NSDictionary *endpoint = subEndpoints[3];
                
                [components setPath:[[endpoint[@"relativePath"] stringByReplacingOccurrencesOfString:@"{region}" withString:regionCode] stringByReplacingOccurrencesOfString:@"{teamIds}" withString:[[trimmedTeamIds valueForKey:@"description"] componentsJoinedByString:@","]]];
            }
            
            [ILA_Setup getAPIkey:^(NSString *apiKey) {
                [components setQuery:[NSString stringWithFormat:@"api_key=%@", apiKey]];
                [ILA_Connection connectToServer:[components URL] withFilename:[NSString stringWithFormat:@"leagueTeamEntry_%@", [[trimmedTeamIds valueForKey:@"description"] componentsJoinedByString:@"-"]] inFolder:@"league" :^(id json, NSInteger responseCode, BOOL fromCache) {
                    completionBlock(json);
                }];
            }];
        }];
    }];
}

/**
 @param gameQueueType Valid types: RANKED_SOLO_5x5, RANKED_TEAM_3x3, RANKED_TEAM_5x5
 */
+ (void)getLeagueChallenger:(NSString *)gameQueueType :(void (^)(NSDictionary *))completionBlock {
    NSURLComponents *components = [NSURLComponents new];
    [components setScheme:@"https"];
    [ILA_Connection getRegionHost:^(NSString *host) {
        [components setHost:host];
        
        [ILA_Connection getRegionCode:^(NSString *regionCode) {
            @autoreleasepool {
                NSArray *endpoints = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Endpoints" ofType:@"plist"]];
                NSDictionary *endpointSection = endpoints[4];
                NSArray *subEndpoints = endpointSection[@"subEndpoints"];
                NSDictionary *endpoint = subEndpoints[4];
                
                [components setPath:[endpoint[@"relativePath"] stringByReplacingOccurrencesOfString:@"{region}" withString:regionCode]];
            }
            
            [ILA_Setup getAPIkey:^(NSString *apiKey) {
                [components setQuery:[NSString stringWithFormat:@"type=%@&api_key=%@", gameQueueType, apiKey]];
                [ILA_Connection connectToServer:[components URL] withFilename:@"leagueChallenger" inFolder:@"league" :^(id json, NSInteger responseCode, BOOL fromCache) {
                    completionBlock(json);
                }];
            }];
        }];
    }];
}

/**
 @param gameQueueType Valid types: RANKED_SOLO_5x5, RANKED_TEAM_3x3, RANKED_TEAM_5x5
 */
+ (void)getLeagueMaster:(NSString *)gameQueueType :(void (^)(NSDictionary *))completionBlock {
    NSURLComponents *components = [NSURLComponents new];
    [components setScheme:@"https"];
    [ILA_Connection getRegionHost:^(NSString *host) {
        [components setHost:host];
        
        [ILA_Connection getRegionCode:^(NSString *regionCode) {
            @autoreleasepool {
                NSArray *endpoints = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Endpoints" ofType:@"plist"]];
                NSDictionary *endpointSection = endpoints[4];
                NSArray *subEndpoints = endpointSection[@"subEndpoints"];
                NSDictionary *endpoint = subEndpoints[5];
                
                [components setPath:[endpoint[@"relativePath"] stringByReplacingOccurrencesOfString:@"{region}" withString:regionCode]];
            }
            
            [ILA_Setup getAPIkey:^(NSString *apiKey) {
                [components setQuery:[NSString stringWithFormat:@"type=%@&api_key=%@", gameQueueType, apiKey]];
                [ILA_Connection connectToServer:[components URL] withFilename:@"leagueMaster" inFolder:@"league" :^(id json, NSInteger responseCode, BOOL fromCache) {
                    completionBlock(json);
                }];
            }];
        }];
    }];
}

@end