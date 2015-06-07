//
//  ILA_Stats.m
//  LoL API Explorer
//
//  Created by Victor Ilisei on 5/31/15.
//  Copyright (c) 2015 Tech Genius. All rights reserved.
//

#import "ILA_Setup.h"
#import "ILA_Connection.h"

#import "ILA_Stats.h"

@implementation ILA_Stats

+ (void)getStatSummaryFor:(long)summID :(void (^)(ILA_PlayerStatsSummaryDto *, ILA_PlayerStatsSummaryDto *, ILA_PlayerStatsSummaryDto *, ILA_PlayerStatsSummaryDto *, ILA_PlayerStatsSummaryDto *, ILA_PlayerStatsSummaryDto *, ILA_PlayerStatsSummaryDto *, ILA_PlayerStatsSummaryDto *, ILA_PlayerStatsSummaryDto *, ILA_PlayerStatsSummaryDto *, ILA_PlayerStatsSummaryDto *, ILA_PlayerStatsSummaryDto *, ILA_PlayerStatsSummaryDto *, ILA_PlayerStatsSummaryDto *, ILA_PlayerStatsSummaryDto *, ILA_PlayerStatsSummaryDto *, ILA_PlayerStatsSummaryDto *, ILA_PlayerStatsSummaryDto *, ILA_PlayerStatsSummaryDto *, ILA_PlayerStatsSummaryDto *, ILA_PlayerStatsSummaryDto *, ILA_PlayerStatsSummaryDto *, ILA_PlayerStatsSummaryDto *))completionBlock {
    NSURLComponents *components = [NSURLComponents new];
    [components setScheme:@"https"];
    [ILA_Connection getRegionHost:^(NSString *host) {
        [components setHost:host];
        
        [ILA_Connection getRegionCode:^(NSString *regionCode) {
            @autoreleasepool {
                NSArray *endpoints = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Endpoints" ofType:@"plist"]];
                NSDictionary *endpointSection = endpoints[9];
                NSArray *subEndpoints = endpointSection[@"subEndpoints"];
                NSDictionary *endpoint = subEndpoints[1];
                
                [components setPath:[[endpoint[@"relativePath"] stringByReplacingOccurrencesOfString:@"{region}" withString:regionCode] stringByReplacingOccurrencesOfString:@"{summonerId}" withString:[NSString stringWithFormat:@"%ld", summID]]];
            }
            
            [ILA_Setup getAPIkey:^(NSString *apiKey) {
                [components setQuery:[NSString stringWithFormat:@"api_key=%@", apiKey]];
                [ILA_Connection connectToServer:[components URL] withFilename:[NSString stringWithFormat:@"statSummary_%ld", summID] inFolder:@"stats" :^(id json, NSInteger responseCode, BOOL fromCache) {
                    ILA_PlayerStatsSummaryDto *AramUnranked5x5, *Ascension, *CAP5x5, *CoopVsAI, *CoopVsAI3x3, *CounterPick, *FirstBlood1x1, *FirstBlood2x2, *Hexakill, *KingPoro, *NightmareBot, *OdinUnranked, *OneForAll5x5, *RankedPremade3x3, *RankedPremade5x5, *RankedSolo5x5, *RankedTeam3x3, *RankedTeam5x5, *SummonersRift6x6, *Unranked, *Unranked3x3, *URF, *URFBots;
                    
                    NSArray *playerStatSummaries = json[@"playerStatSummaries"];
                    for (NSDictionary *statSummary in playerStatSummaries) {
                        NSDictionary *aggregatedStats = statSummary[@"aggregatedStats"];
                        
                        if ([statSummary[@"playerStatSummaryType"] isEqualToString:@"AramUnranked5x5"]) {
                            AramUnranked5x5 = [ILA_PlayerStatsSummaryDto new];
                            
                            AramUnranked5x5.aggregatedStats = [ILA_AggregatedStatsDto new];
                            AramUnranked5x5.aggregatedStats.totalChampionKills = [aggregatedStats[@"totalChampionKills"] intValue];
                            AramUnranked5x5.aggregatedStats.totalTurretsKilled = [aggregatedStats[@"totalTurretsKilled"] intValue];
                            AramUnranked5x5.aggregatedStats.totalAssists = [aggregatedStats[@"totalAssists"] intValue];
                            
                            AramUnranked5x5.losses = [statSummary[@"losses"] intValue];
                            @autoreleasepool {
                                long milliseconds = [statSummary[@"modifyDate"] longValue];
                                AramUnranked5x5.modifyDate = [NSDate dateWithTimeIntervalSinceReferenceDate:milliseconds / 1000];
                            }
                            AramUnranked5x5.playerStatSummaryType = statSummary[@"playerStatSummaryType"];
                            AramUnranked5x5.wins = [statSummary[@"wins"] intValue];
                        } else if ([statSummary[@"playerStatSummaryType"] isEqualToString:@"Ascension"]) {
                            Ascension = [ILA_PlayerStatsSummaryDto new];
                            
                            Ascension.aggregatedStats = [ILA_AggregatedStatsDto new];
                            
                            Ascension.losses = [statSummary[@"losses"] intValue];
                            @autoreleasepool {
                                long milliseconds = [statSummary[@"modifyDate"] longValue];
                                Ascension.modifyDate = [NSDate dateWithTimeIntervalSinceReferenceDate:milliseconds / 1000];
                            }
                            Ascension.playerStatSummaryType = statSummary[@"playerStatSummaryType"];
                            Ascension.wins = [statSummary[@"wins"] intValue];
                        } else if ([statSummary[@"playerStatSummaryType"] isEqualToString:@"CAP5x5"]) {
                            CAP5x5 = [ILA_PlayerStatsSummaryDto new];
                            
                            CAP5x5.aggregatedStats = [ILA_AggregatedStatsDto new];
                            
                            CAP5x5.losses = [statSummary[@"losses"] intValue];
                            @autoreleasepool {
                                long milliseconds = [statSummary[@"modifyDate"] longValue];
                                CAP5x5.modifyDate = [NSDate dateWithTimeIntervalSinceReferenceDate:milliseconds / 1000];
                            }
                            CAP5x5.playerStatSummaryType = statSummary[@"playerStatSummaryType"];
                            CAP5x5.wins = [statSummary[@"wins"] intValue];
                        } else if ([statSummary[@"playerStatSummaryType"] isEqualToString:@"CoopVsAI"]) {
                            CoopVsAI = [ILA_PlayerStatsSummaryDto new];
                            
                            CoopVsAI.aggregatedStats = [ILA_AggregatedStatsDto new];
                            
                            CoopVsAI.losses = [statSummary[@"losses"] intValue];
                            @autoreleasepool {
                                long milliseconds = [statSummary[@"modifyDate"] longValue];
                                CoopVsAI.modifyDate = [NSDate dateWithTimeIntervalSinceReferenceDate:milliseconds / 1000];
                            }
                            CoopVsAI.playerStatSummaryType = statSummary[@"playerStatSummaryType"];
                            CoopVsAI.wins = [statSummary[@"wins"] intValue];
                        } else if ([statSummary[@"playerStatSummaryType"] isEqualToString:@"CoopVsAI3x3"]) {
                            CoopVsAI3x3 = [ILA_PlayerStatsSummaryDto new];
                            
                            CoopVsAI3x3.aggregatedStats = [ILA_AggregatedStatsDto new];
                            
                            CoopVsAI3x3.losses = [statSummary[@"losses"] intValue];
                            @autoreleasepool {
                                long milliseconds = [statSummary[@"modifyDate"] longValue];
                                CoopVsAI3x3.modifyDate = [NSDate dateWithTimeIntervalSinceReferenceDate:milliseconds / 1000];
                            }
                            CoopVsAI3x3.playerStatSummaryType = statSummary[@"playerStatSummaryType"];
                            CoopVsAI3x3.wins = [statSummary[@"wins"] intValue];
                        } else if ([statSummary[@"playerStatSummaryType"] isEqualToString:@"CounterPick"]) {
                            CounterPick = [ILA_PlayerStatsSummaryDto new];
                            
                            CounterPick.aggregatedStats = [ILA_AggregatedStatsDto new];
                            
                            CounterPick.losses = [statSummary[@"losses"] intValue];
                            @autoreleasepool {
                                long milliseconds = [statSummary[@"modifyDate"] longValue];
                                CounterPick.modifyDate = [NSDate dateWithTimeIntervalSinceReferenceDate:milliseconds / 1000];
                            }
                            CounterPick.playerStatSummaryType = statSummary[@"playerStatSummaryType"];
                            CounterPick.wins = [statSummary[@"wins"] intValue];
                        } else if ([statSummary[@"playerStatSummaryType"] isEqualToString:@"FirstBlood1x1"]) {
                            FirstBlood1x1 = [ILA_PlayerStatsSummaryDto new];
                            
                            FirstBlood1x1.aggregatedStats = [ILA_AggregatedStatsDto new];
                            
                            FirstBlood1x1.losses = [statSummary[@"losses"] intValue];
                            @autoreleasepool {
                                long milliseconds = [statSummary[@"modifyDate"] longValue];
                                FirstBlood1x1.modifyDate = [NSDate dateWithTimeIntervalSinceReferenceDate:milliseconds / 1000];
                            }
                            FirstBlood1x1.playerStatSummaryType = statSummary[@"playerStatSummaryType"];
                            FirstBlood1x1.wins = [statSummary[@"wins"] intValue];
                        } else if ([statSummary[@"playerStatSummaryType"] isEqualToString:@"FirstBlood2x2"]) {
                            FirstBlood2x2 = [ILA_PlayerStatsSummaryDto new];
                            
                            FirstBlood2x2.aggregatedStats = [ILA_AggregatedStatsDto new];
                            
                            FirstBlood2x2.losses = [statSummary[@"losses"] intValue];
                            @autoreleasepool {
                                long milliseconds = [statSummary[@"modifyDate"] longValue];
                                FirstBlood2x2.modifyDate = [NSDate dateWithTimeIntervalSinceReferenceDate:milliseconds / 1000];
                            }
                            FirstBlood2x2.playerStatSummaryType = statSummary[@"playerStatSummaryType"];
                            FirstBlood2x2.wins = [statSummary[@"wins"] intValue];
                        } else if ([statSummary[@"playerStatSummaryType"] isEqualToString:@"Hexakill"]) {
                            Hexakill = [ILA_PlayerStatsSummaryDto new];
                            
                            Hexakill.aggregatedStats = [ILA_AggregatedStatsDto new];
                            
                            Hexakill.losses = [statSummary[@"losses"] intValue];
                            @autoreleasepool {
                                long milliseconds = [statSummary[@"modifyDate"] longValue];
                                Hexakill.modifyDate = [NSDate dateWithTimeIntervalSinceReferenceDate:milliseconds / 1000];
                            }
                            Hexakill.playerStatSummaryType = statSummary[@"playerStatSummaryType"];
                            Hexakill.wins = [statSummary[@"wins"] intValue];
                        } else if ([statSummary[@"playerStatSummaryType"] isEqualToString:@"KingPoro"]) {
                            KingPoro = [ILA_PlayerStatsSummaryDto new];
                            
                            KingPoro.aggregatedStats = [ILA_AggregatedStatsDto new];
                            
                            KingPoro.losses = [statSummary[@"losses"] intValue];
                            @autoreleasepool {
                                long milliseconds = [statSummary[@"modifyDate"] longValue];
                                KingPoro.modifyDate = [NSDate dateWithTimeIntervalSinceReferenceDate:milliseconds / 1000];
                            }
                            KingPoro.playerStatSummaryType = statSummary[@"playerStatSummaryType"];
                            KingPoro.wins = [statSummary[@"wins"] intValue];
                        } else if ([statSummary[@"playerStatSummaryType"] isEqualToString:@"NightmareBot"]) {
                            NightmareBot = [ILA_PlayerStatsSummaryDto new];
                            
                            NightmareBot.aggregatedStats = [ILA_AggregatedStatsDto new];
                            
                            NightmareBot.losses = [statSummary[@"losses"] intValue];
                            @autoreleasepool {
                                long milliseconds = [statSummary[@"modifyDate"] longValue];
                                NightmareBot.modifyDate = [NSDate dateWithTimeIntervalSinceReferenceDate:milliseconds / 1000];
                            }
                            NightmareBot.playerStatSummaryType = statSummary[@"playerStatSummaryType"];
                            NightmareBot.wins = [statSummary[@"wins"] intValue];
                        } else if ([statSummary[@"playerStatSummaryType"] isEqualToString:@"OdinUnranked"]) {
                            OdinUnranked = [ILA_PlayerStatsSummaryDto new];
                            
                            OdinUnranked.aggregatedStats = [ILA_AggregatedStatsDto new];
                            OdinUnranked.aggregatedStats.totalChampionKills = [aggregatedStats[@"totalChampionKills"] intValue];
                            OdinUnranked.aggregatedStats.totalAssists = [aggregatedStats[@"totalAssists"] intValue];
                            OdinUnranked.aggregatedStats.maxChampionsKilled = [aggregatedStats[@"maxChampionsKilled"] intValue];
                            OdinUnranked.aggregatedStats.averageNodeCapture = [aggregatedStats[@"averageNodeCapture"] intValue];
                            OdinUnranked.aggregatedStats.averageNodeNeutralize = [aggregatedStats[@"averageNodeNeutralize"] intValue];
                            OdinUnranked.aggregatedStats.averageTeamObjective = [aggregatedStats[@"averageTeamObjective"] intValue];
                            OdinUnranked.aggregatedStats.averageTotalPlayerScore = [aggregatedStats[@"averageTotalPlayerScore"] intValue];
                            OdinUnranked.aggregatedStats.averageCombatPlayerScore = [aggregatedStats[@"averageCombatPlayerScore"] intValue];
                            OdinUnranked.aggregatedStats.averageObjectivePlayerScore = [aggregatedStats[@"averageObjectivePlayerScore"] intValue];
                            OdinUnranked.aggregatedStats.averageNodeCaptureAssist = [aggregatedStats[@"averageNodeCaptureAssist"] intValue];
                            OdinUnranked.aggregatedStats.averageNodeNeutralizeAssist = [aggregatedStats[@"averageNodeNeutralizeAssist"] intValue];
                            OdinUnranked.aggregatedStats.maxNodeCapture = [aggregatedStats[@"maxNodeCapture"] intValue];
                            OdinUnranked.aggregatedStats.maxNodeNeutralize = [aggregatedStats[@"maxNodeNeutralize"] intValue];
                            OdinUnranked.aggregatedStats.maxTeamObjective = [aggregatedStats[@"maxTeamObjective"] intValue];
                            OdinUnranked.aggregatedStats.maxTotalPlayerScore = [aggregatedStats[@"maxTotalPlayerScore"] intValue];
                            OdinUnranked.aggregatedStats.maxCombatPlayerScore = [aggregatedStats[@"maxCombatPlayerScore"] intValue];
                            OdinUnranked.aggregatedStats.maxObjectivePlayerScore = [aggregatedStats[@"maxObjectivePlayerScore"] intValue];
                            OdinUnranked.aggregatedStats.maxNodeCaptureAssist = [aggregatedStats[@"maxNodeCaptureAssist"] intValue];
                            OdinUnranked.aggregatedStats.maxNodeNeutralizeAssist = [aggregatedStats[@"maxNodeNeutralizeAssist"] intValue];
                            OdinUnranked.aggregatedStats.totalNodeNeutralize = [aggregatedStats[@"totalNodeNeutralize"] intValue];
                            OdinUnranked.aggregatedStats.totalNodeCapture = [aggregatedStats[@"totalNodeCapture"] intValue];
                            OdinUnranked.aggregatedStats.averageChampionsKilled = [aggregatedStats[@"averageChampionsKilled"] intValue];
                            OdinUnranked.aggregatedStats.averageNumDeaths = [aggregatedStats[@"averageNumDeaths"] intValue];
                            OdinUnranked.aggregatedStats.averageAssists = [aggregatedStats[@"averageAssists"] intValue];
                            OdinUnranked.aggregatedStats.maxAssists = [aggregatedStats[@"maxAssists"] intValue];
                            
                            OdinUnranked.losses = [statSummary[@"losses"] intValue];
                            @autoreleasepool {
                                long milliseconds = [statSummary[@"modifyDate"] longValue];
                                OdinUnranked.modifyDate = [NSDate dateWithTimeIntervalSinceReferenceDate:milliseconds / 1000];
                            }
                            OdinUnranked.playerStatSummaryType = statSummary[@"playerStatSummaryType"];
                            OdinUnranked.wins = [statSummary[@"wins"] intValue];
                        } else if ([statSummary [@"playerStatSummaryType"] isEqualToString:@"OneForAll5x5"]) {
                            OneForAll5x5 = [ILA_PlayerStatsSummaryDto new];
                            
                            OneForAll5x5.aggregatedStats = [ILA_AggregatedStatsDto new];
                            
                            OneForAll5x5.losses = [statSummary[@"losses"] intValue];
                            @autoreleasepool {
                                long milliseconds = [statSummary[@"modifyDate"] longValue];
                                OneForAll5x5.modifyDate = [NSDate dateWithTimeIntervalSinceReferenceDate:milliseconds / 1000];
                            }
                            OneForAll5x5.playerStatSummaryType = statSummary[@"playerStatSummaryType"];
                            OneForAll5x5.wins = [statSummary[@"wins"] intValue];
                        } else if ([statSummary[@"playerStatSummaryType"] isEqualToString:@"RankedPremade3x3"]) {
                            RankedPremade3x3 = [ILA_PlayerStatsSummaryDto new];
                            
                            RankedPremade3x3.aggregatedStats = [ILA_AggregatedStatsDto new];
                            
                            RankedPremade3x3.losses = [statSummary[@"losses"] intValue];
                            @autoreleasepool {
                                long milliseconds = [statSummary[@"modifyDate"] longValue];
                                RankedPremade3x3.modifyDate = [NSDate dateWithTimeIntervalSinceReferenceDate:milliseconds / 1000];
                            }
                            RankedPremade3x3.playerStatSummaryType = statSummary[@"playerStatSummaryType"];
                            RankedPremade3x3.wins = [statSummary[@"wins"] intValue];
                        } else if ([statSummary[@"playerStatSummaryType"] isEqualToString:@"RankedPremade5x5"]) {
                            RankedPremade5x5 = [ILA_PlayerStatsSummaryDto new];
                            
                            RankedPremade5x5.aggregatedStats = [ILA_AggregatedStatsDto new];
                            
                            RankedPremade5x5.losses = [statSummary[@"losses"] intValue];
                            @autoreleasepool {
                                long milliseconds = [statSummary[@"modifyDate"] longValue];
                                RankedPremade5x5.modifyDate = [NSDate dateWithTimeIntervalSinceReferenceDate:milliseconds / 1000];
                            }
                            RankedPremade5x5.playerStatSummaryType = statSummary[@"playerStatSummaryType"];
                            RankedPremade5x5.wins = [statSummary[@"wins"] intValue];
                        } else if ([statSummary[@"playerStatSummaryType"] isEqualToString:@"RankedSolo5x5"]) {
                            RankedSolo5x5 = [ILA_PlayerStatsSummaryDto new];
                            
                            RankedSolo5x5.aggregatedStats = [ILA_AggregatedStatsDto new];
                            
                            RankedSolo5x5.losses = [statSummary[@"losses"] intValue];
                            @autoreleasepool {
                                long milliseconds = [statSummary[@"modifyDate"] longValue];
                                RankedSolo5x5.modifyDate = [NSDate dateWithTimeIntervalSinceReferenceDate:milliseconds / 1000];
                            }
                            RankedSolo5x5.playerStatSummaryType = statSummary[@"playerStatSummaryType"];
                            RankedSolo5x5.wins = [statSummary[@"wins"] intValue];
                        } else if ([statSummary[@"playerStatSummaryType"] isEqualToString:@"RankedTeam3x3"]) {
                            RankedTeam3x3 = [ILA_PlayerStatsSummaryDto new];
                            
                            RankedTeam3x3.aggregatedStats = [ILA_AggregatedStatsDto new];
                            
                            RankedTeam3x3.losses = [statSummary[@"losses"] intValue];
                            @autoreleasepool {
                                long milliseconds = [statSummary[@"modifyDate"] longValue];
                                RankedTeam3x3.modifyDate = [NSDate dateWithTimeIntervalSinceReferenceDate:milliseconds / 1000];
                            }
                            RankedTeam3x3.playerStatSummaryType = statSummary[@"playerStatSummaryType"];
                            RankedTeam3x3.wins = [statSummary[@"wins"] intValue];
                        } else if ([statSummary[@"playerStatSummaryType"] isEqualToString:@"RankedTeam5x5"]) {
                            RankedTeam5x5 = [ILA_PlayerStatsSummaryDto new];
                            
                            RankedTeam5x5.aggregatedStats = [ILA_AggregatedStatsDto new];
                            
                            RankedTeam5x5.losses = [statSummary[@"losses"] intValue];
                            @autoreleasepool {
                                long milliseconds = [statSummary[@"modifyDate"] longValue];
                                RankedTeam5x5.modifyDate = [NSDate dateWithTimeIntervalSinceReferenceDate:milliseconds / 1000];
                            }
                            RankedTeam5x5.playerStatSummaryType = statSummary[@"playerStatSummaryType"];
                            RankedTeam5x5.wins = [statSummary[@"wins"] intValue];
                        } else if ([statSummary[@"playerStatSummaryType"] isEqualToString:@"SummonersRift6x6"]) {
                            SummonersRift6x6 = [ILA_PlayerStatsSummaryDto new];
                            
                            SummonersRift6x6.aggregatedStats = [ILA_AggregatedStatsDto new];
                            
                            SummonersRift6x6.losses = [statSummary[@"losses"] intValue];
                            @autoreleasepool {
                                long milliseconds = [statSummary[@"modifyDate"] longValue];
                                SummonersRift6x6.modifyDate = [NSDate dateWithTimeIntervalSinceReferenceDate:milliseconds / 1000];
                            }
                            SummonersRift6x6.playerStatSummaryType = statSummary[@"playerStatSummaryType"];
                            SummonersRift6x6.wins = [statSummary[@"wins"] intValue];
                        } else if ([statSummary[@"playerStatSummaryType"] isEqualToString:@"Unranked"]) {
                            Unranked = [ILA_PlayerStatsSummaryDto new];
                            
                            Unranked.aggregatedStats = [ILA_AggregatedStatsDto new];
                            Unranked.aggregatedStats.totalChampionKills = [aggregatedStats[@"totalChampionKills"] intValue];
                            Unranked.aggregatedStats.totalMinionKills = [aggregatedStats[@"totalMinionKills"] intValue];
                            Unranked.aggregatedStats.totalTurretsKilled = [aggregatedStats[@"totalTurretsKilled"] intValue];
                            Unranked.aggregatedStats.totalNeutralMinionsKilled = [aggregatedStats[@"totalNeutralMinionsKilled"] intValue];
                            Unranked.aggregatedStats.totalAssists = [aggregatedStats[@"totalAssists"] intValue];
                            
                            Unranked.losses = [statSummary[@"losses"] intValue];
                            @autoreleasepool {
                                long milliseconds = [statSummary[@"modifyDate"] longValue];
                                Unranked.modifyDate = [NSDate dateWithTimeIntervalSinceReferenceDate:milliseconds / 1000];
                            }
                            Unranked.playerStatSummaryType = statSummary[@"playerStatSummaryType"];
                            Unranked.wins = [statSummary[@"wins"] intValue];
                        } else if ([statSummary[@"playerStatSummaryType"] isEqualToString:@"Unranked3x3"]) {
                            Unranked3x3 = [ILA_PlayerStatsSummaryDto new];
                            
                            Unranked3x3.aggregatedStats = [ILA_AggregatedStatsDto new];
                            
                            Unranked3x3.losses = [statSummary[@"losses"] intValue];
                            @autoreleasepool {
                                long milliseconds = [statSummary[@"modifyDate"] longValue];
                                Unranked3x3.modifyDate = [NSDate dateWithTimeIntervalSinceReferenceDate:milliseconds / 1000];
                            }
                            Unranked3x3.playerStatSummaryType = statSummary[@"playerStatSummaryType"];
                            Unranked3x3.wins = [statSummary[@"wins"] intValue];
                        } else if ([statSummary[@"playerStatSummaryType"] isEqualToString:@"URF"]) {
                            URF = [ILA_PlayerStatsSummaryDto new];
                            
                            URF.aggregatedStats = [ILA_AggregatedStatsDto new];
                            
                            URF.losses = [statSummary[@"losses"] intValue];
                            @autoreleasepool {
                                long milliseconds = [statSummary[@"modifyDate"] longValue];
                                URF.modifyDate = [NSDate dateWithTimeIntervalSinceReferenceDate:milliseconds / 1000];
                            }
                            URF.playerStatSummaryType = statSummary[@"playerStatSummaryType"];
                            URF.wins = [statSummary[@"wins"] intValue];
                        } else if ([statSummary[@"playerStatSummaryType"] isEqualToString:@"URFBots"]) {
                            URFBots = [ILA_PlayerStatsSummaryDto new];
                            
                            URFBots.aggregatedStats = [ILA_AggregatedStatsDto new];
                            
                            URFBots.losses = [statSummary[@"losses"] intValue];
                            @autoreleasepool {
                                long milliseconds = [statSummary[@"modifyDate"] longValue];
                                URFBots.modifyDate = [NSDate dateWithTimeIntervalSinceReferenceDate:milliseconds / 1000];
                            }
                            URFBots.playerStatSummaryType = statSummary[@"playerStatSummaryType"];
                            URFBots.wins = [statSummary[@"wins"] intValue];
                        }
                    }
                    
                    completionBlock(AramUnranked5x5, Ascension, CAP5x5, CoopVsAI, CoopVsAI3x3, CounterPick, FirstBlood1x1, FirstBlood2x2, Hexakill, KingPoro, NightmareBot, OdinUnranked, OneForAll5x5, RankedPremade3x3, RankedPremade5x5, RankedSolo5x5, RankedTeam3x3, RankedTeam5x5, SummonersRift6x6, Unranked, Unranked3x3, URF, URFBots);
                }];
            }];
        }];
    }];
}

@end