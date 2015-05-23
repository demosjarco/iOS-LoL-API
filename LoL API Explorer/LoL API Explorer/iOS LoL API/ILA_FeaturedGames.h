//
//  ILA_FeaturedGames.h
//  LoL API Explorer
//
//  Created by Victor Ilisei on 5/23/15.
//  Copyright (c) 2015 Tech Genius. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ILA_FeaturedGames : NSObject

+ (void)getFeaturedGames :(void (^)(NSDictionary *featuredGames))completionBlock;

@end