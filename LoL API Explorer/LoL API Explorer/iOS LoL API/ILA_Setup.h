//
//  ILA_Setup.h
//  LoL API Explorer
//
//  Created by Victor Ilisei on 1/20/15.
//  Copyright (c) 2015 Tech Genius. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum apiRegion : NSUInteger {
    /** Brazil */
    BR = 0,
    /** EU Nordic & East */
    EUNE = 1,
    /** EU West */
    EUW = 2,
    /** Korea */
    KR = 3,
    /** Latin America North */
    LAN = 4,
    /** Latin America South */
    LAS = 5,
    /** North America */
    NA = 6,
    /** Oceania */
    OCE = 7,
    /** Russia */
    RU = 8,
    /** Turkey */
    TR = 9,
} apiRegion;

@interface ILA_Setup : NSObject

+ (void)setupAPIwithKey:(NSString *)apiKey region:(apiRegion)region;

@end