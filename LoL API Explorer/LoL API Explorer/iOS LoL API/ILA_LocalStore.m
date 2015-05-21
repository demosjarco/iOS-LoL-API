//
//  ILA_LocalStore.m
//  LoL API Explorer
//
//  Created by Victor Ilisei on 1/20/15.
//  Copyright (c) 2015 Tech Genius. All rights reserved.
//

#import "ILA_LocalStore.h"

@implementation ILA_LocalStore

+ (void)saveCacheOf:(id)json withName:(NSString *)fileName inFolder:(NSString *)folder :(void (^)(BOOL))completionBlock {
    @autoreleasepool {
        NSString *filePath = [[[[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"Riot_API_Cache"] stringByAppendingPathComponent:folder] stringByAppendingPathComponent:fileName] stringByAppendingPathExtension:@"plist"];
        NSLog(@"%@", filePath);
        
        // Create directory if needed
        @autoreleasepool {
            NSFileManager *filemgr = [NSFileManager defaultManager];
            if (![filemgr fileExistsAtPath:[[filePath stringByDeletingLastPathComponent] stringByDeletingLastPathComponent]]) {
                [filemgr createDirectoryAtPath:[[filePath stringByDeletingLastPathComponent] stringByDeletingLastPathComponent] withIntermediateDirectories:NO attributes:nil error:nil];
            }
            if (![filemgr fileExistsAtPath:[filePath stringByDeletingLastPathComponent]]) {
                [filemgr createDirectoryAtPath:[filePath stringByDeletingLastPathComponent] withIntermediateDirectories:NO attributes:nil error:nil];
            }
        }
        
        completionBlock([json writeToFile:filePath atomically:YES]);
    }
}

+ (void)getCacheOfFilename:(NSString *)fileName inFolder:(NSString *)folder :(void (^)(NSDictionary *, NSArray *))completionBlock {
    // Path
    @autoreleasepool {
        NSString *filePath = [[[[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"Riot_API_Cache"] stringByAppendingPathComponent:folder] stringByAppendingPathComponent:fileName] stringByAppendingPathExtension:@"plist"];
        // NSLog(@"%@", filePath);
        
        completionBlock([NSDictionary dictionaryWithContentsOfFile:filePath], [NSArray arrayWithContentsOfFile:filePath]);
    }
}

@end