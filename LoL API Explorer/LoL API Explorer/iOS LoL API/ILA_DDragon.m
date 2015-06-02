//
//  ILA_DDragon.m
//  LoL API Explorer
//
//  Created by Victor Ilisei on 5/31/15.
//  Copyright (c) 2015 Tech Genius. All rights reserved.
//

#import "ILA_DDragon.h"
#import "ILA_StaticData.h"

@implementation ILA_DDragon

#pragma mark - Private Methods

+ (void)getCDNurl:(void (^)(NSString *cdnUrl))completionBlock {
    [ILA_StaticData getRealmInfo:^(NSDictionary *realmInfo) {
        completionBlock(realmInfo[@"cdn"]);
    }];
}

+ (void)getLatestDDragonVersionFor:(NSString *)dataType :(void (^)(NSString *version))completionBlock {
    [ILA_StaticData getRealmInfo:^(NSDictionary *realmInfo) {
        NSDictionary *n = realmInfo[@"n"];
        completionBlock(n[dataType]);
    }];
}

+ (void)optimalRegionCode:(void (^)(NSString *localeCode))completionBlock {
    [ILA_StaticData getRegionValidLocales:^(NSArray *validLocales) {
        if ([validLocales containsObject:[[NSLocale autoupdatingCurrentLocale] localeIdentifier]]) {
            completionBlock([[NSLocale autoupdatingCurrentLocale] localeIdentifier]);
        } else {
            [ILA_StaticData getRealmInfo:^(NSDictionary *realmInfo) {
                completionBlock(realmInfo[@"l"]);
            }];
        }
    }];
}

#pragma mark - Public Methods

+ (void)getProfileIcon:(int)profileIconId :(void (^)(UIImage *))completionBlock {
    [self getCDNurl:^(NSString *cdnUrl) {
        [self getLatestDDragonVersionFor:@"profileicon" :^(NSString *version) {
            NSString *url = [[[[[cdnUrl stringByAppendingPathComponent:version] stringByAppendingPathComponent:@"img"] stringByAppendingPathComponent:@"profileicon"] stringByAppendingPathComponent:[NSString stringWithFormat:@"%d", profileIconId]] stringByAppendingPathExtension:@"png"];
            
            [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                NSHTTPURLResponse *correctResponse = (NSHTTPURLResponse *)response;
                if (correctResponse.statusCode == 200 && data && !connectionError) {
                    completionBlock([UIImage imageWithData:data]);
                }
            }];
        }];
    }];
}

@end