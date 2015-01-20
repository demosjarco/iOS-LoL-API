//
//  ILA_Connection.h
//  LoL API Explorer
//
//  Created by Victor Ilisei on 1/20/15.
//  Copyright (c) 2015 Tech Genius. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ILA_LocalStore.h"

@interface ILA_Connection : NSObject

+ (void)connectWithURL:(NSString *)url completion:(void(^)(NSDictionary *json, NSDate *dateOfLocalStore, NSInteger statusCode, NSError *connectionError))completionBlock;

@end