//
//  ILA_MasteryDto.h
//  LoL API Explorer
//
//  Created by Victor Ilisei on 6/1/15.
//  Copyright (c) 2015 Tech Genius. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ILA_MasteryDto : NSObject

/**
 @brief Mastery ID. For static information correlating to masteries, please refer to the LoL Static Data API.
 */
@property (nonatomic) int masteryId;

/**
 @brief Mastery rank (i.e., the number of points put into this mastery).
 */
@property (nonatomic) int rank;

@end