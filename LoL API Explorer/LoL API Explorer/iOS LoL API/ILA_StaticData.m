//
//  ILA_StaticData.m
//  LoL API Explorer
//
//  Created by Victor Ilisei on 5/23/15.
//  Copyright (c) 2015 Tech Genius. All rights reserved.
//

#import "ILA_Connection.h"
#import "ILA_Setup.h"
#import "ILA_StaticData.h"

@implementation ILA_StaticData

#pragma mark Private Methods

+ (NSString *)champDataString:(champData)champDataSelected {
    NSString *result = nil;
    
    switch(champDataSelected) {
        case standard:
            result = @"";
            break;
        case all:
            result = @"all";
            break;
        case allytips:
            result = @"allytips";
            break;
        case altimages:
            result = @"altimages";
            break;
        case blurb:
            result = @"blurb";
            break;
        case enemytips:
            result = @"enemytips";
            break;
        case image:
            result = @"image";
            break;
        case info:
            result = @"info";
            break;
        case lore:
            result = @"lore";
            break;
        case partype:
            result = @"partype";
            break;
        case passive:
            result = @"passive";
            break;
        case recommended:
            result = @"recommended";
            break;
        case skins:
            result = @"skins";
            break;
        case spells:
            result = @"spells";
            break;
        case stats:
            result = @"stats";
            break;
        case tags:
            result = @"tags";
            break;
            
        default:
            result = @"";
    }
    
    return result;
}

/**
 @return if device locale is available to the current region, it returns that, otherwise default for current region
 */
+ (void)optimalLocaleForRegion :(void (^)(BOOL optimalLocale))completionBlock {
    [self getRegionValidLocales:^(NSArray *validLocales) {
        if ([validLocales containsObject:[[NSLocale autoupdatingCurrentLocale] localeIdentifier]]) {
            completionBlock(YES);
        } else {
            completionBlock(NO);
        }
    }];
}

#pragma mark Public Methods

/**
 @note Requests to this API will not be counted in your Rate Limit.
 */
+ (void)getChampionList:(champData)champDataSelected :(void (^)(NSDictionary *))completionBlock {
    NSURLComponents *components = [NSURLComponents new];
    [components setScheme:@"https"];
    [ILA_Connection getRegionHost:^(NSString *host) {
        [components setHost:host];
        
        [ILA_Connection getRegionCode:^(NSString *regionCode) {
            @autoreleasepool {
                NSArray *endpoints = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Endpoints" ofType:@"plist"]];
                NSDictionary *endpointSection = endpoints[5];
                NSArray *subEndpoints = endpointSection[@"subEndpoints"];
                NSDictionary *endpoint = subEndpoints[0];
                
                [components setPath:[endpoint[@"relativePath"] stringByReplacingOccurrencesOfString:@"{region}" withString:regionCode]];
            }
            
            [ILA_Setup getAPIkey:^(NSString *apiKey) {
                [self optimalLocaleForRegion:^(BOOL optimalLocale) {
                    if (optimalLocale) {
                        [components setQuery:[NSString stringWithFormat:@"locale=%@&champData=%@&api_key=%@", [[NSLocale autoupdatingCurrentLocale] localeIdentifier], [self champDataString:champDataSelected], apiKey]];
                    } else {
                        [components setQuery:[NSString stringWithFormat:@"champData=%@&api_key=%@", [self champDataString:champDataSelected], apiKey]];
                    }
                    
                    [ILA_Connection connectToServer:[components URL] withFilename:[NSString stringWithFormat:@"championList_%@", [self champDataString:champDataSelected]] inFolder:@"staticData" :^(id json, BOOL fromCache) {
                        completionBlock(json);
                    }];
                }];
            }];
        }];
    }];
}

/**
 @note Requests to this API will not be counted in your Rate Limit.
 */
+ (void)getChampionInfoFor:(int)champId withData:(champData)champDataSelected :(void (^)(NSDictionary *))completionBlock {
    NSURLComponents *components = [NSURLComponents new];
    [components setScheme:@"https"];
    [ILA_Connection getRegionHost:^(NSString *host) {
        [components setHost:host];
        
        [ILA_Connection getRegionCode:^(NSString *regionCode) {
            @autoreleasepool {
                NSArray *endpoints = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Endpoints" ofType:@"plist"]];
                NSDictionary *endpointSection = endpoints[5];
                NSArray *subEndpoints = endpointSection[@"subEndpoints"];
                NSDictionary *endpoint = subEndpoints[1];
                
                [components setPath:[[endpoint[@"relativePath"] stringByReplacingOccurrencesOfString:@"{region}" withString:regionCode] stringByReplacingOccurrencesOfString:@"{id}" withString:[NSString stringWithFormat:@"%d", champId]]];
            }
            
            [ILA_Setup getAPIkey:^(NSString *apiKey) {
                [self optimalLocaleForRegion:^(BOOL optimalLocale) {
                    if (optimalLocale) {
                        [components setQuery:[NSString stringWithFormat:@"locale=%@&champData=%@&api_key=%@", [[NSLocale autoupdatingCurrentLocale] localeIdentifier], [self champDataString:champDataSelected], apiKey]];
                    } else {
                        [components setQuery:[NSString stringWithFormat:@"champData=%@&api_key=%@", [self champDataString:champDataSelected], apiKey]];
                    }
                    
                    [ILA_Connection connectToServer:[components URL] withFilename:[NSString stringWithFormat:@"championInfo_%@", [self champDataString:champDataSelected]] inFolder:@"staticData" :^(id json, BOOL fromCache) {
                        completionBlock(json);
                    }];
                }];
            }];
        }];
    }];
}

/**
 @note Requests to this API will not be counted in your Rate Limit.
 */
+ (void)getItemList:(NSString *)itemListDataSelected :(void (^)(NSDictionary *))completionBlock {
    NSURLComponents *components = [NSURLComponents new];
    [components setScheme:@"https"];
    [ILA_Connection getRegionHost:^(NSString *host) {
        [components setHost:host];
        
        [ILA_Connection getRegionCode:^(NSString *regionCode) {
            @autoreleasepool {
                NSArray *endpoints = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Endpoints" ofType:@"plist"]];
                NSDictionary *endpointSection = endpoints[5];
                NSArray *subEndpoints = endpointSection[@"subEndpoints"];
                NSDictionary *endpoint = subEndpoints[2];
                
                [components setPath:[endpoint[@"relativePath"] stringByReplacingOccurrencesOfString:@"{region}" withString:regionCode]];
            }
            
            [ILA_Setup getAPIkey:^(NSString *apiKey) {
                [self optimalLocaleForRegion:^(BOOL optimalLocale) {
                    if (optimalLocale) {
                        [components setQuery:[NSString stringWithFormat:@"locale=%@&itemListData=%@&api_key=%@", [[NSLocale autoupdatingCurrentLocale] localeIdentifier], itemListDataSelected, apiKey]];
                    } else {
                        [components setQuery:[NSString stringWithFormat:@"itemListData=%@&api_key=%@", itemListDataSelected, apiKey]];
                    }
                    
                    [ILA_Connection connectToServer:[components URL] withFilename:[NSString stringWithFormat:@"itemList_%@", itemListDataSelected] inFolder:@"staticData" :^(id json, BOOL fromCache) {
                        completionBlock(json);
                    }];
                }];
            }];
        }];
    }];
}

/**
 @note Requests to this API will not be counted in your Rate Limit.
 */
+ (void)getItemInfoFor:(int)itemId withData:(NSString *)itemListDataSelected :(void (^)(NSDictionary *))completionBlock {
    NSURLComponents *components = [NSURLComponents new];
    [components setScheme:@"https"];
    [ILA_Connection getRegionHost:^(NSString *host) {
        [components setHost:host];
        
        [ILA_Connection getRegionCode:^(NSString *regionCode) {
            @autoreleasepool {
                NSArray *endpoints = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Endpoints" ofType:@"plist"]];
                NSDictionary *endpointSection = endpoints[5];
                NSArray *subEndpoints = endpointSection[@"subEndpoints"];
                NSDictionary *endpoint = subEndpoints[3];
                
                [components setPath:[[endpoint[@"relativePath"] stringByReplacingOccurrencesOfString:@"{region}" withString:regionCode] stringByReplacingOccurrencesOfString:@"{id}" withString:[NSString stringWithFormat:@"%d", itemId]]];
            }
            
            [ILA_Setup getAPIkey:^(NSString *apiKey) {
                [self optimalLocaleForRegion:^(BOOL optimalLocale) {
                    if (optimalLocale) {
                        [components setQuery:[NSString stringWithFormat:@"locale=%@&itemListData=%@&api_key=%@", [[NSLocale autoupdatingCurrentLocale] localeIdentifier], itemListDataSelected, apiKey]];
                    } else {
                        [components setQuery:[NSString stringWithFormat:@"itemListData=%@&api_key=%@", itemListDataSelected, apiKey]];
                    }
                    
                    [ILA_Connection connectToServer:[components URL] withFilename:[NSString stringWithFormat:@"itemInfo_%@", itemListDataSelected] inFolder:@"staticData" :^(id json, BOOL fromCache) {
                        completionBlock(json);
                    }];
                }];
            }];
        }];
    }];
}

/**
 @note Requests to this API will not be counted in your Rate Limit.
 @return If a localized string is not available, this method will return the same text as original
 **/
+ (void)getLocalizedStringForPlaceHolderText:(NSString *)originalText :(void (^)(NSString *))completionBlock {
    NSURLComponents *components = [NSURLComponents new];
    [components setScheme:@"https"];
    [ILA_Connection getRegionHost:^(NSString *host) {
        [components setHost:host];
        
        [ILA_Connection getRegionCode:^(NSString *regionCode) {
            @autoreleasepool {
                NSArray *endpoints = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Endpoints" ofType:@"plist"]];
                NSDictionary *endpointSection = endpoints[5];
                NSArray *subEndpoints = endpointSection[@"subEndpoints"];
                NSDictionary *endpoint = subEndpoints[4];
                
                [components setPath:[endpoint[@"relativePath"] stringByReplacingOccurrencesOfString:@"{region}" withString:regionCode]];
            }
            
            [ILA_Setup getAPIkey:^(NSString *apiKey) {
                [self optimalLocaleForRegion:^(BOOL optimalLocale) {
                    if (optimalLocale) {
                        [components setQuery:[NSString stringWithFormat:@"locale=%@&api_key=%@", [[NSLocale autoupdatingCurrentLocale] localeIdentifier], apiKey]];
                    } else {
                        [components setQuery:[NSString stringWithFormat:@"api_key=%@", apiKey]];
                    }
                    
                    [ILA_Connection connectToServer:[components URL] withFilename:[NSString stringWithFormat:@"localizedStrings_%@", [[NSLocale autoupdatingCurrentLocale] localeIdentifier]] inFolder:@"staticData" :^(id json, BOOL fromCache) {
                        completionBlock(json);
                    }];
                }];
            }];
        }];
    }];
}

/**
 */
+ (void)getRegionValidLocales:(void (^)(NSArray *))completionBlock {
    NSURLComponents *components = [NSURLComponents new];
    [components setScheme:@"https"];
    [ILA_Connection getRegionHost:^(NSString *host) {
        [components setHost:host];
        
        [ILA_Connection getRegionCode:^(NSString *regionCode) {
            @autoreleasepool {
                NSArray *endpoints = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Endpoints" ofType:@"plist"]];
                NSDictionary *endpointSection = endpoints[5];
                NSArray *subEndpoints = endpointSection[@"subEndpoints"];
                NSDictionary *endpoint = subEndpoints[5];
                
                [components setPath:[endpoint[@"relativePath"] stringByReplacingOccurrencesOfString:@"{region}" withString:regionCode]];
            }
            
            [ILA_Setup getAPIkey:^(NSString *apiKey) {
                [components setQuery:[NSString stringWithFormat:@"api_key=%@", apiKey]];
                [ILA_Connection connectToServer:[components URL] withFilename:@"localesForRegion" inFolder:@"staticData" :^(id json, BOOL fromCache) {
                    completionBlock(json);
                }];
            }];
        }];
    }];
}

@end