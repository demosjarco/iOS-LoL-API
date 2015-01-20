//
//  ILA_Champion.m
//  LoL API Explorer
//
//  Created by Victor Ilisei on 1/20/15.
//  Copyright (c) 2015 Tech Genius. All rights reserved.
//

#import "ILA_Connection.h"

#import "ILA_Champion.h"

@implementation ILA_Champion

+ (void)getChampionList:(BOOL)freeToPlayOnly result:(void(^)(NSArray *champions, BOOL usingLocalData))resultBlock error:(void(^)(NSError *userOffline, NSString *localizedStringForStatusCode))errorBlock {
    NSString *url = [NSString stringWithFormat:@"https://%@.api.pvp.net/api/lol/%@/v1.2/champion?freeToPlay=%@&api_key=%@", [[ILA_LocalStore readKeyAndRegion] objectForKey:@"endpoint"], [[ILA_LocalStore readKeyAndRegion] objectForKey:@"endpoint"], freeToPlayOnly ? @"YES" : @"NO", [[ILA_LocalStore readKeyAndRegion] objectForKey:@"apiKey"]];
    
    [ILA_Connection connectWithURL:url completion:^(NSDictionary *json, NSDate *dateOfLocalStore, NSInteger statusCode, NSError *connectionError) {
        if (json && dateOfLocalStore) {
            resultBlock(json[@"champions"], YES);
        } else if (json) {
            resultBlock(json[@"champions"], NO);
        } else if (connectionError) {
            errorBlock(connectionError, nil);
        } else {
            errorBlock(nil, [NSHTTPURLResponse localizedStringForStatusCode:statusCode]);
        }
    }];
}

+ (void)getChampionInfo:(int)champID result:(void(^)(NSDictionary *champion, BOOL usingLocalData))resultBlock error:(void(^)(NSString *localizedStringForStatusCode))errorBlock {
    
}

@end