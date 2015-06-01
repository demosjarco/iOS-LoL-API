//
//  ILA_MasteryPageDto.h
//  LoL API Explorer
//
//  Created by Victor Ilisei on 6/1/15.
//  Copyright (c) 2015 Tech Genius. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ILA_MasteryPageDto : NSObject

/**
 @brief Indicates if the mastery page is the current mastery page.
 */
@property (nonatomic) BOOL current;

/**
 @brief Mastery page ID.
 */
@property (nonatomic) long pageId;

/**
 @brief Collection of masteries associated with the mastery page.
 */
@property (nonatomic, retain) NSArray *masteries;

/**
 @brief Mastery page name.
 */
@property (nonatomic, retain) NSString *name;

@end