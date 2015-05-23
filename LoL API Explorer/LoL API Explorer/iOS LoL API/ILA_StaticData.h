//
//  ILA_StaticData.h
//  LoL API Explorer
//
//  Created by Victor Ilisei on 5/23/15.
//  Copyright (c) 2015 Tech Genius. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ILA_StaticData : NSObject

typedef enum {
    standard,
    all,
    allytips,
    altimages,
    blurb,
    enemytips,
    image,
    info,
    lore,
    partype,
    passive,
    recommended,
    skins,
    spells,
    stats,
    tags
} champData;

+ (void)getChampionList:(champData)champDataSelected :(void (^)(NSDictionary *championList))completionBlock;
+ (void)getChampionInfoFor:(int)champId withData:(champData)champDataSelected :(void (^)(NSDictionary *championList))completionBlock;
+ (void) :(void (^)())completionBlock;
+ (void) :(void (^)())completionBlock;
+ (void) :(void (^)())completionBlock;
+ (void) :(void (^)())completionBlock;
+ (void) :(void (^)())completionBlock;
+ (void) :(void (^)())completionBlock;
+ (void) :(void (^)())completionBlock;
+ (void) :(void (^)())completionBlock;
+ (void) :(void (^)())completionBlock;
+ (void) :(void (^)())completionBlock;
+ (void) :(void (^)())completionBlock;
+ (void) :(void (^)())completionBlock;
+ (void) :(void (^)())completionBlock;

@end