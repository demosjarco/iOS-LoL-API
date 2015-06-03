//
//  ILA_RunePageDto.h
//  LoL API Explorer
//
//  Created by Victor Ilisei on 6/3/15.
//  Copyright (c) 2015 Tech Genius. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ILA_RuneSlotDto.h"

@interface ILA_RunePageDto : NSObject

/**
 @brief Indicates if the page is the current page.
 */
@property (nonatomic) BOOL current;

/**
 @brief Rune page ID.
 */
@property (nonatomic) long pageId;

/**
 @brief Rune page name.
 */
@property (nonatomic, retain) NSString *name;

/**
 @brief Collection of rune slots associated with the rune page.
 */
@property (nonatomic, retain) NSArray *slots;

@end