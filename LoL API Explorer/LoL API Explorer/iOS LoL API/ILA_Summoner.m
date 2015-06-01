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
    NSMutableArray *standardizedNames = [NSMutableArray new];
    for (NSString *summonerName in array) {
        [standardizedNames addObject:[[summonerName stringByReplacingOccurrencesOfString:@" " withString:@""] lowercaseString]];
    }
    return standardizedNames;
}

#pragma mark - Public Methods

/**
 @warning This method takes a max of 40 summoners. If you provide more than 40 in @p summonerNames it will only process the first 40.
 */
+ (void)getSummonersForSummonerNames:(NSArray *)summonerNames :(void (^)(NSDictionary *))completionBlock :(void (^)(NSInteger))errorBlock {
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
                [ILA_Connection connectToServer:[components URL] withFilename:[NSString stringWithFormat:@"summonerNames_%@", [[standardizedSummonerNames valueForKey:@"description"] componentsJoinedByString:@"-"]] inFolder:@"summoner" :^(id json, NSInteger responseCode, BOOL fromCache) {
                    if (responseCode == SUCCEEDED) {
                        @autoreleasepool {
                            NSMutableDictionary *summonerMap = [NSMutableDictionary new];
                            for (NSString *standardizedSummonerName in [json allKeys]) {
                                @autoreleasepool {
                                    NSDictionary *tempJSON = json[standardizedSummonerName];
                                    
                                    ILA_SummonerDto *summonerMapNew = [ILA_SummonerDto new];
                                    summonerMapNew.summonerId = [tempJSON[@"id"] longValue];
                                    summonerMapNew.summonerName = tempJSON[@"name"];
                                    summonerMapNew.profileIconId = [tempJSON[@"profileIconId"] intValue];
                                    summonerMapNew.revisionDate = [NSDate dateWithTimeIntervalSince1970:[tempJSON[@"revisionDate"] longValue] / 1000];
                                    summonerMapNew.summonerLevel = [tempJSON[@"summonerLevel"] longValue];
                                    
                                    [summonerMap setObject:summonerMapNew forKey:standardizedSummonerName];
                                }
                            }
                            
                            completionBlock([NSDictionary dictionaryWithDictionary:summonerMap]);
                        }
                    } else {
                        errorBlock(responseCode);
                    }
                }];
            }];
        }];
    }];
}

/**
 @warning This method takes a max of 40 summoners. If you provide more than 40 in @p summonerIds it will only process the first 40.
 */
+ (void)getSummonersForSummonerIds:(NSArray *)summonerIds :(void (^)(NSDictionary *))completionBlock :(void (^)(NSInteger))errorBlock {
    // Trim array of summonerIds to 40.
    NSMutableArray *trimmedSummonerIds;
    if (summonerIds.count > 40) {
        trimmedSummonerIds = [NSMutableArray arrayWithArray:[summonerIds subarrayWithRange:NSMakeRange(0, 40)]];
    } else {
        trimmedSummonerIds = [NSMutableArray arrayWithArray:summonerIds];
    }
    
    NSURLComponents *components = [NSURLComponents new];
    [components setScheme:@"https"];
    [ILA_Connection getRegionHost:^(NSString *host) {
        [components setHost:host];
        
        [ILA_Connection getRegionCode:^(NSString *regionCode) {
            @autoreleasepool {
                NSArray *endpoints = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Endpoints" ofType:@"plist"]];
                NSDictionary *endpointSection = endpoints[10];
                NSArray *subEndpoints = endpointSection[@"subEndpoints"];
                NSDictionary *endpoint = subEndpoints[1];
                
                [components setPath:[[endpoint[@"relativePath"] stringByReplacingOccurrencesOfString:@"{region}" withString:regionCode] stringByReplacingOccurrencesOfString:@"{summonerIds}" withString:[[trimmedSummonerIds valueForKey:@"description"] componentsJoinedByString:@","]]];
            }
            
            [ILA_Setup getAPIkey:^(NSString *apiKey) {
                [components setQuery:[NSString stringWithFormat:@"api_key=%@", apiKey]];
                [ILA_Connection connectToServer:[components URL] withFilename:[NSString stringWithFormat:@"summonerIds_%@", [[trimmedSummonerIds valueForKey:@"description"] componentsJoinedByString:@"-"]] inFolder:@"summoner" :^(id json, NSInteger responseCode, BOOL fromCache) {
                    if (responseCode == SUCCEEDED) {
                        @autoreleasepool {
                            NSMutableDictionary *summonerMap = [NSMutableDictionary new];
                            for (NSString *summonerId in [json allKeys]) {
                                @autoreleasepool {
                                    NSDictionary *tempJSON = json[summonerId];
                                    
                                    ILA_SummonerDto *summonerMapNew = [ILA_SummonerDto new];
                                    summonerMapNew.summonerId = [tempJSON[@"id"] longValue];
                                    summonerMapNew.summonerName = tempJSON[@"name"];
                                    summonerMapNew.profileIconId = [tempJSON[@"profileIconId"] intValue];
                                    summonerMapNew.revisionDate = [NSDate dateWithTimeIntervalSince1970:[tempJSON[@"revisionDate"] longValue] / 1000];
                                    summonerMapNew.summonerLevel = [tempJSON[@"summonerLevel"] longValue];
                                    
                                    [summonerMap setObject:summonerMapNew forKey:summonerId];
                                }
                            }
                            
                            completionBlock([NSDictionary dictionaryWithDictionary:summonerMap]);
                        }
                    } else {
                        errorBlock(responseCode);
                    }
                }];
            }];
        }];
    }];
}

/**
 @warning This method takes a max of 40 summoners. If you provide more than 40 in @p summonerIds it will only process the first 40.
 */
+ (void)getSummonerMasteriesForSummonerIds:(NSArray *)summonerIds :(void (^)(NSDictionary *))completionBlock {
    // Trim array of summonerIds to 40.
    NSMutableArray *trimmedSummonerIds;
    if (summonerIds.count > 40) {
        trimmedSummonerIds = [NSMutableArray arrayWithArray:[summonerIds subarrayWithRange:NSMakeRange(0, 40)]];
    } else {
        trimmedSummonerIds = [NSMutableArray arrayWithArray:summonerIds];
    }
    
    NSURLComponents *components = [NSURLComponents new];
    [components setScheme:@"https"];
    [ILA_Connection getRegionHost:^(NSString *host) {
        [components setHost:host];
        
        [ILA_Connection getRegionCode:^(NSString *regionCode) {
            @autoreleasepool {
                NSArray *endpoints = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Endpoints" ofType:@"plist"]];
                NSDictionary *endpointSection = endpoints[10];
                NSArray *subEndpoints = endpointSection[@"subEndpoints"];
                NSDictionary *endpoint = subEndpoints[2];
                
                [components setPath:[[endpoint[@"relativePath"] stringByReplacingOccurrencesOfString:@"{region}" withString:regionCode] stringByReplacingOccurrencesOfString:@"{summonerIds}" withString:[[trimmedSummonerIds valueForKey:@"description"] componentsJoinedByString:@","]]];
            }
            
            [ILA_Setup getAPIkey:^(NSString *apiKey) {
                [components setQuery:[NSString stringWithFormat:@"api_key=%@", apiKey]];
                [ILA_Connection connectToServer:[components URL] withFilename:[NSString stringWithFormat:@"summonerMasteries_%@", [[trimmedSummonerIds valueForKey:@"description"] componentsJoinedByString:@"-"]] inFolder:@"summoner" :^(id json, NSInteger responseCode, BOOL fromCache) {
                    if (responseCode == SUCCEEDED) {
                        @autoreleasepool {
                            NSMutableDictionary *summonerMap = [NSMutableDictionary new];
                            for (NSString *summonerId in [json allKeys]) {
                                @autoreleasepool {
                                    NSDictionary *tempJSON = json[summonerId];
                                    
                                    ILA_MasteryPagesDto *summonerMapNew = [ILA_MasteryPagesDto new];
                                    summonerMapNew.summonerId = [tempJSON[@"summonerId"] longValue];
                                    @autoreleasepool {
                                        NSMutableArray *tempPages = [NSMutableArray new];
                                        for (NSDictionary *page in tempJSON[@"pages"]) {
                                            @autoreleasepool {
                                                ILA_MasteryPageDto *tempPage = [ILA_MasteryPageDto new];
                                                tempPage.pageId = [page[@"id"] longValue];
                                                tempPage.name = page[@"name"];
                                                tempPage.current = [page[@"current"] boolValue];
                                                
                                                @autoreleasepool {
                                                    NSMutableArray *tempMasteries = [NSMutableArray new];
                                                    for (NSDictionary *mastery in page[@"masteries"]) {
                                                        @autoreleasepool {
                                                            ILA_MasteryDto *masteryTemp = [ILA_MasteryDto new];
                                                            masteryTemp.masteryId = [mastery[@"id"] intValue];
                                                            masteryTemp.rank = [mastery[@"rank"] intValue];
                                                            
                                                            [tempMasteries addObject:masteryTemp];
                                                        }
                                                    }
                                                    
                                                    tempPage.masteries = [NSArray arrayWithArray:tempMasteries];
                                                }
                                            }
                                        }
                                        
                                        summonerMapNew.pages = [NSArray arrayWithArray:tempPages];
                                    }
                                    
                                    [summonerMap setObject:summonerMapNew forKey:summonerId];
                                }
                            }
                            
                            completionBlock([NSDictionary dictionaryWithDictionary:summonerMap]);
                        }
                    }
                }];
            }];
        }];
    }];
}

@end