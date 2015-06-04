//
//  ILA_ChampionDto.h
//  LoL API Explorer
//
//  Created by Victor Ilisei on 6/3/15.
//  Copyright (c) 2015 Tech Genius. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ILA_ChampionDto : NSObject

@property (nonatomic, strong) NSArray *allytips;

@property (nonatomic, strong) NSString *blurb;

@property (nonatomic, strong) NSArray *enemytips;

@property (nonatomic) int champId;

@property (nonatomic, strong) NSDictionary *image;

@property (nonatomic, strong) NSDictionary *info;

@property (nonatomic, strong) NSString *key;

@property (nonatomic, strong) NSString *lore;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *partype;

@property (nonatomic, strong) NSDictionary *passive;

@property (nonatomic, strong) NSArray *recommended;

@property (nonatomic, strong) NSArray *skins;

@property (nonatomic, strong) NSArray *spells;

@property (nonatomic, strong) NSDictionary *stats;

@property (nonatomic, strong) NSArray *tags;

@property (nonatomic, strong) NSString *title;

@end