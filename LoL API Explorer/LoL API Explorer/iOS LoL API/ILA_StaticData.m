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
+ (void)getChampionList:(NSString *)champDataSelected :(void (^)(NSDictionary *))completionBlock {
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
                        [components setQuery:[NSString stringWithFormat:@"locale=%@&champData=%@&api_key=%@", [[NSLocale autoupdatingCurrentLocale] localeIdentifier], champDataSelected, apiKey]];
                    } else {
                        [components setQuery:[NSString stringWithFormat:@"champData=%@&api_key=%@", champDataSelected, apiKey]];
                    }
                    
                    [ILA_Connection connectToServer:[components URL] withFilename:[NSString stringWithFormat:@"championList_%@", champDataSelected] inFolder:@"staticData" :^(id json, NSInteger responseCode, BOOL fromCache) {
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
+ (void)getChampionInfoFor:(int)champId withData:(NSString *)champDataSelected :(void (^)(ILA_StaticData_ChampionDto *))completionBlock {
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
                        [components setQuery:[NSString stringWithFormat:@"locale=%@&champData=%@&api_key=%@", [[NSLocale autoupdatingCurrentLocale] localeIdentifier], champDataSelected, apiKey]];
                    } else {
                        [components setQuery:[NSString stringWithFormat:@"champData=%@&api_key=%@", champDataSelected, apiKey]];
                    }
                    
                    [ILA_Connection connectToServer:[components URL] withFilename:[NSString stringWithFormat:@"championInfo_%d_%@", champId, champDataSelected] inFolder:@"staticData" :^(id json, NSInteger responseCode, BOOL fromCache) {
                        @autoreleasepool {
                            ILA_StaticData_ChampionDto *champInfo = [ILA_StaticData_ChampionDto new];
                            champInfo.allytips = json[@"allytips"];
                            champInfo.blurb = json[@"blurb"];
                            champInfo.enemytips = json[@"enemytips"];
                            champInfo.champId = [json[@"id"] intValue];
                            champInfo.image = json[@"image"];
                            champInfo.info = json[@"info"];
                            champInfo.key = json[@"key"];
                            champInfo.lore = json[@"lore"];
                            champInfo.name = json[@"name"];
                            champInfo.partype = json[@"partype"];
                            champInfo.passive = json[@"passive"];
                            champInfo.recommended = json[@"recommended"];
                            champInfo.skins = json[@"skins"];
                            champInfo.spells = json[@"spells"];
                            champInfo.stats = json[@"stats"];
                            champInfo.title = json[@"title"];
                            
                            completionBlock(champInfo);
                        }
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
                    
                    [ILA_Connection connectToServer:[components URL] withFilename:[NSString stringWithFormat:@"itemList_%@", itemListDataSelected] inFolder:@"staticData" :^(id json, NSInteger responseCode, BOOL fromCache) {
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
                    
                    [ILA_Connection connectToServer:[components URL] withFilename:[NSString stringWithFormat:@"itemInfo_%d_%@", itemId, itemListDataSelected] inFolder:@"staticData" :^(id json, NSInteger responseCode, BOOL fromCache) {
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
                    
                    [ILA_Connection connectToServer:[components URL] withFilename:[NSString stringWithFormat:@"localizedStrings_%@", [[NSLocale autoupdatingCurrentLocale] localeIdentifier]] inFolder:@"staticData" :^(id json, NSInteger responseCode, BOOL fromCache) {
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
                [ILA_Connection connectToServer:[components URL] withFilename:@"localesForRegion" inFolder:@"staticData" :^(id json, NSInteger responseCode, BOOL fromCache) {
                    completionBlock(json);
                }];
            }];
        }];
    }];
}

/**
 @note Requests to this API will not be counted in your Rate Limit.
 */
+ (void)getMapData:(void (^)(NSDictionary *))completionBlock {
    NSURLComponents *components = [NSURLComponents new];
    [components setScheme:@"https"];
    [ILA_Connection getRegionHost:^(NSString *host) {
        [components setHost:host];
        
        [ILA_Connection getRegionCode:^(NSString *regionCode) {
            @autoreleasepool {
                NSArray *endpoints = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Endpoints" ofType:@"plist"]];
                NSDictionary *endpointSection = endpoints[5];
                NSArray *subEndpoints = endpointSection[@"subEndpoints"];
                NSDictionary *endpoint = subEndpoints[6];
                
                [components setPath:[endpoint[@"relativePath"] stringByReplacingOccurrencesOfString:@"{region}" withString:regionCode]];
            }
            
            [ILA_Setup getAPIkey:^(NSString *apiKey) {
                [self optimalLocaleForRegion:^(BOOL optimalLocale) {
                    if (optimalLocale) {
                        [components setQuery:[NSString stringWithFormat:@"locale=%@&api_key=%@", [[NSLocale autoupdatingCurrentLocale] localeIdentifier], apiKey]];
                    } else {
                        [components setQuery:[NSString stringWithFormat:@"api_key=%@", apiKey]];
                    }
                    
                    [ILA_Connection connectToServer:[components URL] withFilename:@"map" inFolder:@"staticData" :^(id json, NSInteger responseCode, BOOL fromCache) {
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
+ (void)getMasteryList:(NSString *)masteryListDataSelected :(void (^)(NSDictionary *))completionBlock {
    NSURLComponents *components = [NSURLComponents new];
    [components setScheme:@"https"];
    [ILA_Connection getRegionHost:^(NSString *host) {
        [components setHost:host];
        
        [ILA_Connection getRegionCode:^(NSString *regionCode) {
            @autoreleasepool {
                NSArray *endpoints = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Endpoints" ofType:@"plist"]];
                NSDictionary *endpointSection = endpoints[5];
                NSArray *subEndpoints = endpointSection[@"subEndpoints"];
                NSDictionary *endpoint = subEndpoints[7];
                
                [components setPath:[endpoint[@"relativePath"] stringByReplacingOccurrencesOfString:@"{region}" withString:regionCode]];
            }
            
            [ILA_Setup getAPIkey:^(NSString *apiKey) {
                [self optimalLocaleForRegion:^(BOOL optimalLocale) {
                    if (optimalLocale) {
                        [components setQuery:[NSString stringWithFormat:@"locale=%@&masteryListData=%@&api_key=%@", [[NSLocale autoupdatingCurrentLocale] localeIdentifier], masteryListDataSelected, apiKey]];
                    } else {
                        [components setQuery:[NSString stringWithFormat:@"masteryListData=%@&api_key=%@", masteryListDataSelected, apiKey]];
                    }
                    
                    [ILA_Connection connectToServer:[components URL] withFilename:[NSString stringWithFormat:@"masteryList_%@", masteryListDataSelected] inFolder:@"staticData" :^(id json, NSInteger responseCode, BOOL fromCache) {
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
+ (void)getMasteryInfoFor:(int)masteryId withData:(NSString *)masteryListDataSelected :(void (^)(NSDictionary *))completionBlock {
    NSURLComponents *components = [NSURLComponents new];
    [components setScheme:@"https"];
    [ILA_Connection getRegionHost:^(NSString *host) {
        [components setHost:host];
        
        [ILA_Connection getRegionCode:^(NSString *regionCode) {
            @autoreleasepool {
                NSArray *endpoints = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Endpoints" ofType:@"plist"]];
                NSDictionary *endpointSection = endpoints[5];
                NSArray *subEndpoints = endpointSection[@"subEndpoints"];
                NSDictionary *endpoint = subEndpoints[8];
                
                [components setPath:[[endpoint[@"relativePath"] stringByReplacingOccurrencesOfString:@"{region}" withString:regionCode] stringByReplacingOccurrencesOfString:@"{id}" withString:[NSString stringWithFormat:@"%d", masteryId]]];
            }
            
            [ILA_Setup getAPIkey:^(NSString *apiKey) {
                [self optimalLocaleForRegion:^(BOOL optimalLocale) {
                    if (optimalLocale) {
                        [components setQuery:[NSString stringWithFormat:@"locale=%@&masteryListData=%@&api_key=%@", [[NSLocale autoupdatingCurrentLocale] localeIdentifier], masteryListDataSelected, apiKey]];
                    } else {
                        [components setQuery:[NSString stringWithFormat:@"masteryListData=%@&api_key=%@", masteryListDataSelected, apiKey]];
                    }
                    
                    [ILA_Connection connectToServer:[components URL] withFilename:[NSString stringWithFormat:@"masteryInfo_%d_%@", masteryId, masteryListDataSelected] inFolder:@"staticData" :^(id json, NSInteger responseCode, BOOL fromCache) {
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
+ (void)getRealmInfo:(void (^)(NSDictionary *))completionBlock {
    NSURLComponents *components = [NSURLComponents new];
    [components setScheme:@"https"];
    [ILA_Connection getRegionHost:^(NSString *host) {
        [components setHost:host];
        
        [ILA_Connection getRegionCode:^(NSString *regionCode) {
            @autoreleasepool {
                NSArray *endpoints = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Endpoints" ofType:@"plist"]];
                NSDictionary *endpointSection = endpoints[5];
                NSArray *subEndpoints = endpointSection[@"subEndpoints"];
                NSDictionary *endpoint = subEndpoints[9];
                
                [components setPath:[endpoint[@"relativePath"] stringByReplacingOccurrencesOfString:@"{region}" withString:regionCode]];
            }
            
            [ILA_Setup getAPIkey:^(NSString *apiKey) {
                [components setQuery:[NSString stringWithFormat:@"api_key=%@", apiKey]];
                [ILA_Connection connectToServer:[components URL] withFilename:@"realmInfo" inFolder:@"staticData" :^(id json, NSInteger responseCode, BOOL fromCache) {
                    completionBlock(json);
                }];
            }];
        }];
    }];
}

/**
 @note Requests to this API will not be counted in your Rate Limit.
 */
+ (void)getRuneList:(NSString *)runeListDataSelected :(void (^)(NSDictionary *))completionBlock {
    NSURLComponents *components = [NSURLComponents new];
    [components setScheme:@"https"];
    [ILA_Connection getRegionHost:^(NSString *host) {
        [components setHost:host];
        
        [ILA_Connection getRegionCode:^(NSString *regionCode) {
            @autoreleasepool {
                NSArray *endpoints = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Endpoints" ofType:@"plist"]];
                NSDictionary *endpointSection = endpoints[5];
                NSArray *subEndpoints = endpointSection[@"subEndpoints"];
                NSDictionary *endpoint = subEndpoints[10];
                
                [components setPath:[endpoint[@"relativePath"] stringByReplacingOccurrencesOfString:@"{region}" withString:regionCode]];
            }
            
            [ILA_Setup getAPIkey:^(NSString *apiKey) {
                [self optimalLocaleForRegion:^(BOOL optimalLocale) {
                    if (optimalLocale) {
                        [components setQuery:[NSString stringWithFormat:@"locale=%@&runeData=%@&api_key=%@", [[NSLocale autoupdatingCurrentLocale] localeIdentifier], runeListDataSelected, apiKey]];
                    } else {
                        [components setQuery:[NSString stringWithFormat:@"runeData=%@&api_key=%@", runeListDataSelected, apiKey]];
                    }
                    
                    [ILA_Connection connectToServer:[components URL] withFilename:[NSString stringWithFormat:@"runeList_%@", runeListDataSelected] inFolder:@"staticData" :^(id json, NSInteger responseCode, BOOL fromCache) {
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
+ (void)getRuneInfoFor:(int)runeId withData:(NSString *)runeListDataSelected :(void (^)(NSDictionary *))completionBlock {
    NSURLComponents *components = [NSURLComponents new];
    [components setScheme:@"https"];
    [ILA_Connection getRegionHost:^(NSString *host) {
        [components setHost:host];
        
        [ILA_Connection getRegionCode:^(NSString *regionCode) {
            @autoreleasepool {
                NSArray *endpoints = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Endpoints" ofType:@"plist"]];
                NSDictionary *endpointSection = endpoints[5];
                NSArray *subEndpoints = endpointSection[@"subEndpoints"];
                NSDictionary *endpoint = subEndpoints[11];
                
                [components setPath:[[endpoint[@"relativePath"] stringByReplacingOccurrencesOfString:@"{region}" withString:regionCode] stringByReplacingOccurrencesOfString:@"{id}" withString:[NSString stringWithFormat:@"%d", runeId]]];
            }
            
            [ILA_Setup getAPIkey:^(NSString *apiKey) {
                [self optimalLocaleForRegion:^(BOOL optimalLocale) {
                    if (optimalLocale) {
                        [components setQuery:[NSString stringWithFormat:@"locale=%@&runeData=%@&api_key=%@", [[NSLocale autoupdatingCurrentLocale] localeIdentifier], runeListDataSelected, apiKey]];
                    } else {
                        [components setQuery:[NSString stringWithFormat:@"runeData=%@&api_key=%@", runeListDataSelected, apiKey]];
                    }
                    
                    [ILA_Connection connectToServer:[components URL] withFilename:[NSString stringWithFormat:@"runeInfo_%d_%@", runeId, runeListDataSelected] inFolder:@"staticData" :^(id json, NSInteger responseCode, BOOL fromCache) {
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
+ (void)getSummonerSpellList:(NSString *)summonerSpellDataSelected :(void (^)(NSDictionary *))completionBlock {
    NSURLComponents *components = [NSURLComponents new];
    [components setScheme:@"https"];
    [ILA_Connection getRegionHost:^(NSString *host) {
        [components setHost:host];
        
        [ILA_Connection getRegionCode:^(NSString *regionCode) {
            @autoreleasepool {
                NSArray *endpoints = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Endpoints" ofType:@"plist"]];
                NSDictionary *endpointSection = endpoints[5];
                NSArray *subEndpoints = endpointSection[@"subEndpoints"];
                NSDictionary *endpoint = subEndpoints[12];
                
                [components setPath:[endpoint[@"relativePath"] stringByReplacingOccurrencesOfString:@"{region}" withString:regionCode]];
            }
            
            [ILA_Setup getAPIkey:^(NSString *apiKey) {
                [self optimalLocaleForRegion:^(BOOL optimalLocale) {
                    if (optimalLocale) {
                        [components setQuery:[NSString stringWithFormat:@"locale=%@&spellData=%@&api_key=%@", [[NSLocale autoupdatingCurrentLocale] localeIdentifier], summonerSpellDataSelected, apiKey]];
                    } else {
                        [components setQuery:[NSString stringWithFormat:@"spellData=%@&api_key=%@", summonerSpellDataSelected, apiKey]];
                    }
                    
                    [ILA_Connection connectToServer:[components URL] withFilename:[NSString stringWithFormat:@"summonerSpellList_%@", summonerSpellDataSelected] inFolder:@"staticData" :^(id json, NSInteger responseCode, BOOL fromCache) {
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
+ (void)getSummonerSpellInfo:(int)summonerSpellId withData:(NSString *)summonerSpellDataSelected :(void (^)(NSDictionary *))completionBlock {
    NSURLComponents *components = [NSURLComponents new];
    [components setScheme:@"https"];
    [ILA_Connection getRegionHost:^(NSString *host) {
        [components setHost:host];
        
        [ILA_Connection getRegionCode:^(NSString *regionCode) {
            @autoreleasepool {
                NSArray *endpoints = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Endpoints" ofType:@"plist"]];
                NSDictionary *endpointSection = endpoints[5];
                NSArray *subEndpoints = endpointSection[@"subEndpoints"];
                NSDictionary *endpoint = subEndpoints[13];
                
                [components setPath:[[endpoint[@"relativePath"] stringByReplacingOccurrencesOfString:@"{region}" withString:regionCode] stringByReplacingOccurrencesOfString:@"{id}" withString:[NSString stringWithFormat:@"%d", summonerSpellId]]];
            }
            
            [ILA_Setup getAPIkey:^(NSString *apiKey) {
                [self optimalLocaleForRegion:^(BOOL optimalLocale) {
                    if (optimalLocale) {
                        [components setQuery:[NSString stringWithFormat:@"locale=%@&spellData=%@&api_key=%@", [[NSLocale autoupdatingCurrentLocale] localeIdentifier], summonerSpellDataSelected, apiKey]];
                    } else {
                        [components setQuery:[NSString stringWithFormat:@"spellData=%@&api_key=%@", summonerSpellDataSelected, apiKey]];
                    }
                    
                    [ILA_Connection connectToServer:[components URL] withFilename:[NSString stringWithFormat:@"summonerSpellInfo_%d_%@", summonerSpellId, summonerSpellDataSelected] inFolder:@"staticData" :^(id json, NSInteger responseCode, BOOL fromCache) {
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
+ (void)getLeagueVersion:(void (^)(NSArray *))completionBlock {
    NSURLComponents *components = [NSURLComponents new];
    [components setScheme:@"https"];
    [ILA_Connection getRegionHost:^(NSString *host) {
        [components setHost:host];
        
        [ILA_Connection getRegionCode:^(NSString *regionCode) {
            @autoreleasepool {
                NSArray *endpoints = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Endpoints" ofType:@"plist"]];
                NSDictionary *endpointSection = endpoints[5];
                NSArray *subEndpoints = endpointSection[@"subEndpoints"];
                NSDictionary *endpoint = subEndpoints[14];
                
                [components setPath:[endpoint[@"relativePath"] stringByReplacingOccurrencesOfString:@"{region}" withString:regionCode]];
            }
            
            [ILA_Setup getAPIkey:^(NSString *apiKey) {
                [components setQuery:[NSString stringWithFormat:@"api_key=%@", apiKey]];
                [ILA_Connection connectToServer:[components URL] withFilename:@"versions" inFolder:@"staticData" :^(id json, NSInteger responseCode, BOOL fromCache) {
                    completionBlock(json);
                }];
            }];
        }];
    }];
}

@end