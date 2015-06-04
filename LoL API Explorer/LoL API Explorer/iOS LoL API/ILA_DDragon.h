//
//  ILA_DDragon.h
//  LoL API Explorer
//
//  Created by Victor Ilisei on 5/31/15.
//  Copyright (c) 2015 Tech Genius. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ILA_DDragon : NSObject

+ (void)getImageFromRect:(CGRect)imageRectInSprite fromSprite:(UIImage *)sprite :(void (^)(UIImage *imageFromSprite))completionBlock;

+ (void)getProfileIcon:(int)profileIconId :(void (^)(UIImage *profileIconImage))completionBlock;

+ (void)getSplashArtForChampion:(NSString *)fileName withSkinNumber:(int)skinNumber :(void(^)(UIImage *championSplash))completionBlock;
+ (void)getLoadingArtForChampion:(NSString *)fileName withSkinNumber:(int)skinNumber :(void(^)(UIImage *championLoading))completionBlock;
+ (void)getSquareArtForChampion:(NSString *)fileName :(void(^)(UIImage *championSquare))completionBlock;

+ (void)getPassiveAbilityIcon:(NSString *)fileName :(void(^)(UIImage *passiveAbilityIcon))completionBlock;
+ (void)getAbilityIcon:(NSString *)fileName :(void(^)(UIImage *abilityIcon))completionBlock;

+ (void)getSummonerSpell:(NSString *)fileName :(void(^)(UIImage *summonerSpellIcon))completionBlock;

+ (void)getItem:(NSString *)fileName :(void(^)(UIImage *itemIcon))completionBlock;

+ (void)getMasteryIcon:(NSString *)fileName hasRank:(BOOL)hasRank :(void(^)(UIImage *masteryIcon))completionBlock;

+ (void)getRuneIcon:(NSString *)fileName :(void(^)(UIImage *runeIcon))completionBlock;

+ (void)getSpriteSheet:(NSString *)fileName :(void(^)(UIImage *spriteSheet))completionBlock;

+ (void)getMinimap:(NSString *)fileName :(void(^)(UIImage *minimapImage))completionBlock;

+ (void)getScoreboardIcon:(NSString *)icon :(void(^)(UIImage *scoreboardIcon))completionBlock;

@end