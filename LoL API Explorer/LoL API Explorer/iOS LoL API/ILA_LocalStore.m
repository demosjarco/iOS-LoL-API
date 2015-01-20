//
//  ILA_LocalStore.m
//  LoL API Explorer
//
//  Created by Victor Ilisei on 1/20/15.
//  Copyright (c) 2015 Tech Genius. All rights reserved.
//

#import "ILA_LocalStore.h"

@implementation ILA_LocalStore

+ (NSDictionary *)readKeyAndRegion {
    @autoreleasepool {
        NSString *filePath = [[[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"API DB"] stringByAppendingPathComponent:@"main"] stringByAppendingPathExtension:@"plist"];
        return [NSDictionary dictionaryWithContentsOfFile:filePath];
    }
}

+ (BOOL)writeToLocalStore:(NSDictionary *)item inFolder:(NSString *)folderName withFilename:(NSString *)fileName {
    @autoreleasepool {
        NSString *filePath = [[[[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"API DB"] stringByAppendingPathComponent:folderName] stringByAppendingPathComponent:fileName] stringByAppendingPathExtension:@"plist"];
        
        @autoreleasepool {
            NSFileManager *filemgr = [NSFileManager defaultManager];
            if (![filemgr fileExistsAtPath:[filePath stringByDeletingLastPathComponent]]) {
                [filemgr createDirectoryAtPath:[filePath stringByDeletingLastPathComponent] withIntermediateDirectories:NO attributes:nil error:nil];
            }
        }
        
        return [item writeToFile:filePath atomically:YES];
    }
}

+ (NSDictionary *)getItemFromLocalStoreForFilename:(NSString *)fileName inFolder:(NSString *)folderName {
    @autoreleasepool {
        NSString *filePath = [[[[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"API DB"] stringByAppendingPathComponent:folderName] stringByAppendingPathComponent:fileName] stringByAppendingPathExtension:@"plist"];
        
        return [NSDictionary dictionaryWithContentsOfFile:filePath];
    }
}

@end