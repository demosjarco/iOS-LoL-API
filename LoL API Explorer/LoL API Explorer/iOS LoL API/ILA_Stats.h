//
//  ILA_Stats.h
//  LoL API Explorer
//
//  Created by Victor Ilisei on 5/31/15.
//  Copyright (c) 2015 Tech Genius. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ILA_PlayerStatsSummaryDto.h"

@interface ILA_Stats : NSObject

+ (void)getStatSummaryFor:(long)summID :(void (^)(ILA_PlayerStatsSummaryDto *AramUnranked5x5, ILA_PlayerStatsSummaryDto *Ascension, ILA_PlayerStatsSummaryDto *CAP5x5, ILA_PlayerStatsSummaryDto *CoopVsAI, ILA_PlayerStatsSummaryDto *CoopVsAI3x3, ILA_PlayerStatsSummaryDto *CounterPick, ILA_PlayerStatsSummaryDto *FirstBlood1x1, ILA_PlayerStatsSummaryDto *FirstBlood2x2, ILA_PlayerStatsSummaryDto *Hexakill, ILA_PlayerStatsSummaryDto *KingPoro, ILA_PlayerStatsSummaryDto *NightmareBot, ILA_PlayerStatsSummaryDto *OdinUnranked, ILA_PlayerStatsSummaryDto *OneForAll5x5, ILA_PlayerStatsSummaryDto *RankedPremade3x3, ILA_PlayerStatsSummaryDto *RankedPremade5x5, ILA_PlayerStatsSummaryDto *RankedSolo5x5, ILA_PlayerStatsSummaryDto *RankedTeam3x3, ILA_PlayerStatsSummaryDto *RankedTeam5x5, ILA_PlayerStatsSummaryDto *SummonersRift6x6, ILA_PlayerStatsSummaryDto *Unranked, ILA_PlayerStatsSummaryDto *Unranked3x3, ILA_PlayerStatsSummaryDto *URF, ILA_PlayerStatsSummaryDto *URFBots))completionBlock;

@end