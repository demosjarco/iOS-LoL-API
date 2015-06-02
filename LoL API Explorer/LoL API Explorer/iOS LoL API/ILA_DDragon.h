//
//  ILA_DDragon.h
//  LoL API Explorer
//
//  Created by Victor Ilisei on 5/31/15.
//  Copyright (c) 2015 Tech Genius. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ILA_DDragon : NSObject

+ (void)getProfileIcon:(int)profileIconId :(void (^)(UIImage *profileIconImage))completionBlock;

@end