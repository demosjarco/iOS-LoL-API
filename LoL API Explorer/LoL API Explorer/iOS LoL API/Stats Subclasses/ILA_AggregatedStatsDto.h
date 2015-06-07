//
//  ILA_AggregatedStatsDto.h
//  LoL API Explorer
//
//  Created by Victor Ilisei on 6/6/15.
//  Copyright (c) 2015 Tech Genius. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ILA_AggregatedStatsDto : NSObject

/**
 @note Dominion only.
 */
@property (nonatomic) int averageAssists;

/**
 @note Dominion only.
 */
@property (nonatomic) int averageChampionsKilled;

/**
 @note Dominion only.
 */
@property (nonatomic) int averageCombatPlayerScore;

/**
 @note Dominion only.
 */
@property (nonatomic) int averageNodeCapture;

/**
 @note Dominion only.
 */
@property (nonatomic) int averageNodeCaptureAssist;

/**
 @note Dominion only.
 */
@property (nonatomic) int averageNodeNeutralize;

/**
 @note Dominion only.
 */
@property (nonatomic) int averageNodeNeutralizeAssist;

/**
 @note Dominion only.
 */
@property (nonatomic) int averageNumDeaths;

/**
 @note Dominion only.
 */
@property (nonatomic) int averageObjectivePlayerScore;

/**
 @note Dominion only.
 */
@property (nonatomic) int averageTeamObjective;

/**
 @note Dominion only.
 */
@property (nonatomic) int averageTotalPlayerScore;

/**
 */
@property (nonatomic) int botGamesPlayed;

/**
 */
@property (nonatomic) int killingSpree;

/**
 @note Dominion only.
 */
@property (nonatomic) int maxAssists;

/**
 */
@property (nonatomic) int maxChampionsKilled;

/**
 @note Dominion only.
 */
@property (nonatomic) int maxCombatPlayerScore;

/**
 */
@property (nonatomic) int maxLargestCriticalStrike;

/**
 */
@property (nonatomic) int maxLargestKillingSpree;

/**
 @note Dominion only.
 */
@property (nonatomic) int maxNodeCapture;

/**
 @note Dominion only.
 */
@property (nonatomic) int maxNodeCaptureAssist;

/**
 @note Dominion only.
 */
@property (nonatomic) int maxNodeNeutralize;

/**
 @note Dominion only.
 */
@property (nonatomic) int maxNodeNeutralizeAssist;

/**
 @note Only returned for ranked statistics.
 */
@property (nonatomic) int maxNumDeaths;

/**
 @note Dominion only.
 */
@property (nonatomic) int maxObjectivePlayerScore;

/**
 @note Dominion only.
 */
@property (nonatomic) int maxTeamObjective;

/**
 */
@property (nonatomic) int maxTimePlayed;

/**
 */
@property (nonatomic) int maxTimeSpentLiving;

/**
 @note Dominion only.
 */
@property (nonatomic) int maxTotalPlayerScore;

/**
 */
@property (nonatomic) int mostChampionKillsPerSession;

/**
 */
@property (nonatomic) int mostSpellsCast;

/**
 */
@property (nonatomic) int normalGamesPlayed;

/**
 */
@property (nonatomic) int rankedPremadeGamesPlayed;

/**
 */
@property (nonatomic) int rankedSoloGamesPlayed;

/**
 */
@property (nonatomic) int totalAssists;

/**
 */
@property (nonatomic) int totalChampionKills;

/**
 */
@property (nonatomic) int totalDamageDealt;

/**
 */
@property (nonatomic) int totalDamageTaken;

/**
 @note Only returned for ranked statistics.
 */
@property (nonatomic) int totalDeathsPerSession;

/**
 */
@property (nonatomic) int totalDoubleKills;

/**
 */
@property (nonatomic) int totalFirstBlood;

/**
 */
@property (nonatomic) int totalGoldEarned;

/**
 */
@property (nonatomic) int totalHeal;

/**
 */
@property (nonatomic) int totalMagicDamageDealt;

/**
 */
@property (nonatomic) int totalMinionKills;

/**
 */
@property (nonatomic) int totalNeutralMinionsKilled;

/**
 @note Dominion only.
 */
@property (nonatomic) int totalNodeCapture;

/**
 @note Dominion only.
 */
@property (nonatomic) int totalNodeNeutralize;

/**
 */
@property (nonatomic) int totalPentaKills;

/**
 */
@property (nonatomic) int totalPhysicalDamageDealt;

/**
 */
@property (nonatomic) int totalQuadraKills;

/**
 */
@property (nonatomic) int totalSessionsLost;

/**
 */
@property (nonatomic) int totalSessionsPlayed;

/**
 */
@property (nonatomic) int totalSessionsWon;

/**
 */
@property (nonatomic) int totalTripleKills;

/**
 */
@property (nonatomic) int totalTurretsKilled;

/**
 */
@property (nonatomic) int totalUnrealKills;

@end