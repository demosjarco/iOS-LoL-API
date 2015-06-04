//
//  ILA_ChampionDto.h
//  LoL API Explorer
//
//  Created by Victor Ilisei on 6/3/15.
//  Copyright (c) 2015 Tech Genius. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ILA_ChampionDto : NSObject

/**
 @brief Indicates if the champion is active.
 */
@property (nonatomic) BOOL active;

/**
 @brief Bot enabled flag (for custom games).
 */
@property (nonatomic) BOOL botEnabled;

/**
 @brief Bot Match Made enabled flag (for Co-op vs. AI games).
 */
@property (nonatomic) BOOL botMmEnabled;

/**
 @brief Indicates if the champion is free to play. Free to play champions are rotated periodically.
 */
@property (nonatomic) BOOL freeToPlay;

/**
 @brief Champion ID. For static information correlating to champion IDs, please refer to the LoL Static Data API.
 */
@property (nonatomic) long champId;

/**
 @brief Ranked play enabled flag.
 */
@property (nonatomic) BOOL rankedPlayEnabled;

@end