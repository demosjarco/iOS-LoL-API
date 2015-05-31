//
//  ILA_SummonerDto.h
//  League of Legends: Companion App
//
//  Created by Victor Ilisei on 5/31/15.
//  Copyright (c) 2015 Tech Genius. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ILA_SummonerDto : NSObject

@property (nonatomic) long summonerId;
@property (nonatomic, retain) NSString *summonerName;
@property (nonatomic) int profileIconId;
@property (nonatomic, retain) NSDate *revisionDate;
@property (nonatomic) long summonerLevel;

@end