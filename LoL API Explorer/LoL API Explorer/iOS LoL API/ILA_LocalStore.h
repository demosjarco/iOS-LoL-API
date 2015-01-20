//
//  ILA_LocalStore.h
//  LoL API Explorer
//
//  Created by Victor Ilisei on 1/20/15.
//  Copyright (c) 2015 Tech Genius. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ILA_LocalStore : NSObject

+ (NSDictionary *)readKeyAndRegion;
+ (BOOL)writeToLocalStore:(NSDictionary *)item inFolder:(NSString *)folderName withFilename:(NSString *)fileName;
+ (NSDictionary *)getItemFromLocalStoreForFilename:(NSString *)fileName inFolder:(NSString *)folderName;

@end