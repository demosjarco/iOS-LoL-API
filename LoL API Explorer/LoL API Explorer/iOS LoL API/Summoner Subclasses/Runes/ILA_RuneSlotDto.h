//
//  ILA_RuneSlotDto.h
//  LoL API Explorer
//
//  Created by Victor Ilisei on 6/3/15.
//  Copyright (c) 2015 Tech Genius. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ILA_RuneSlotDto : NSObject

/**
 @brief Rune ID associated with the rune slot. For static information correlating to rune IDs, please refer to the LoL Static Data API.
 */
@property (nonatomic) int runeId;

/**
 @brief Rune slot ID.
 */
@property (nonatomic) int runeSlotId;

@end