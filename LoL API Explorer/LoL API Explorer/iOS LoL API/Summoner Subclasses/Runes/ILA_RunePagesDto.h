//
//  ILA_RunePagesDto.h
//  LoL API Explorer
//
//  Created by Victor Ilisei on 6/3/15.
//  Copyright (c) 2015 Tech Genius. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ILA_RunePageDto.h"

@interface ILA_RunePagesDto : NSObject

/**
 @brief Collection of rune pages associated with the summoner.
 */
@property (nonatomic, retain) NSArray *pages;

/**
 @brief Summoner ID.
 */
@property (nonatomic) long summonerId;

@end