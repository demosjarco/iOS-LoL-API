//
//  ILA_StaticData.h
//  LoL API Explorer
//
//  Created by Victor Ilisei on 5/23/15.
//  Copyright (c) 2015 Tech Genius. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ILA_StaticData : NSObject

+ (void)getChampionList:(NSString *)champDataSelected :(void (^)(NSDictionary *championList))completionBlock;
+ (void)getChampionInfoFor:(int)champId withData:(NSString *)champDataSelected :(void (^)(NSDictionary *championInfo))completionBlock;
+ (void)getItemList:(NSString *)itemListDataSelected :(void (^)(NSDictionary *itemList))completionBlock;
+ (void)getItemInfoFor:(int)itemId withData:(NSString *)itemListDataSelected :(void (^)(NSDictionary *itemInfo))completionBlock;
+ (void)getLocalizedStringForPlaceHolderText:(NSString *)originalText :(void (^)(NSString *localizedText))completionBlock;
+ (void)getRegionValidLocales :(void (^)(NSArray *validLocales))completionBlock;
+ (void)getMapData :(void (^)(NSDictionary *mapData))completionBlock;
+ (void)getMasteryList:(NSString *)masteryListDataSelected :(void (^)(NSDictionary *masteryList))completionBlock;
+ (void)getMasteryInfoFor:(int)masteryId withData:(NSString *)masteryListDataSelected :(void (^)(NSDictionary *masteryInfo))completionBlock;
+ (void)getRealmInfo :(void (^)(NSDictionary *realmInfo))completionBlock;
+ (void)getRuneList:(NSString *)runeListDataSelected :(void (^)(NSDictionary *runeList))completionBlock;
+ (void)getRuneInfoFor:(int)runeId withData:(NSString *)runeListDataSelected :(void (^)(NSDictionary *masteryInfo))completionBlock;
+ (void)getSummonerSpellList:(NSString *)summonerSpellDataSelected :(void (^)(NSDictionary *summonerSpellList))completionBlock;
+ (void)getSummonerSpellInfo:(int)summonerSpellId withData:(NSString *)summonerSpellDataSelected :(void (^)(NSDictionary *summonerSpellInfo))completionBlock;
+ (void)getLeagueVersion :(void (^)(NSArray *versionList))completionBlock;

@end