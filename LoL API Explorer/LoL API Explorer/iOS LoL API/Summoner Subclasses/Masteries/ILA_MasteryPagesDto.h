//
//  ILA_MasteryPagesDto.h
//  LoL API Explorer
//
//  Created by Victor Ilisei on 6/1/15.
//  Copyright (c) 2015 Tech Genius. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ILA_MasteryPagesDto : NSObject

/**
 @brief Collection of mastery pages associated with the summoner.
 */
@property (nonatomic, retain) NSArray *pages;

/**
 @brief Summoner ID.
 */
@property (nonatomic) long summonerId;

@end