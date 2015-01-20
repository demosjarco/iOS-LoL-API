//
//  ILA_Setup.h
//  LoL API Explorer
//
//  Created by Victor Ilisei on 1/20/15.
//  Copyright (c) 2015 Tech Genius. All rights reserved.
//

#import <Foundation/Foundation.h>

/** Possible regional endpoints of League of Legends API */
typedef enum apiRegion : NSUInteger {
    /** Brazil */
    BR,
    /** EU Nordic & East */
    EUNE,
    /** EU West */
    EUW,
    /** Korea */
    KR,
    /** Latin America North */
    LAN,
    /** Latin America South */
    LAS,
    /** North America */
    NA,
    /** Oceania */
    OCE,
    /** Russia */
    RU,
    /** Turkey */
    TR,
} apiRegion;

@interface ILA_Setup : NSObject

@end