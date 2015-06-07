//
//  ILA_PlayerStatsSummaryDto.h
//  LoL API Explorer
//
//  Created by Victor Ilisei on 6/6/15.
//  Copyright (c) 2015 Tech Genius. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ILA_AggregatedStatsDto.h"

@interface ILA_PlayerStatsSummaryDto : NSObject

@property (nonatomic, retain) ILA_AggregatedStatsDto *aggregatedStats;
@property (nonatomic) int losses;
@property (nonatomic, retain) NSDate *modifyDate;
@property (nonatomic, retain) NSString *playerStatSummaryType;
@property (nonatomic) int wins;

@end