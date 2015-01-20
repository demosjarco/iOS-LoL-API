//
//  ILA_Setup.m
//  LoL API Explorer
//
//  Created by Victor Ilisei on 1/20/15.
//  Copyright (c) 2015 Tech Genius. All rights reserved.
//

#import "ILA_Setup.h"

@implementation ILA_Setup

#pragma mark - Private methods

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

#pragma mark - Public methods

/**
 Saves API key to disk for later use and offline access.
 @warning Call this method before any other API request to avoid 401 (Unauthorized) response.
 @note This method can be called as many times as wanted to change region. All future API calls will use new region passed.
 @todo Encrypt stored API key.
 @see https://developer.riotgames.com for API key.
 @param apiKey
        The 32 character key (including hyphens) that you got from Riot.
 @param region
        @p NSUInteger of region apiRegion enumeration.
 @return @p BOOL whether saving succeded or not.
 */
+ (BOOL)setupAPIwithKey:(NSString *)apiKey region:(apiRegion)region {
    @autoreleasepool {
        // Create directory if needed
        NSString *filePath = [[[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"API DB"] stringByAppendingPathComponent:@"main"] stringByAppendingPathExtension:@"plist"];
        
        @autoreleasepool {
            NSFileManager *filemgr = [NSFileManager defaultManager];
            if (![filemgr fileExistsAtPath:[filePath stringByDeletingLastPathComponent]]) {
                [filemgr createDirectoryAtPath:[filePath stringByDeletingLastPathComponent] withIntermediateDirectories:NO attributes:nil error:nil];
            }
        }
        
        NSMutableDictionary *dict = @{@"apiKey": apiKey}.mutableCopy;
        switch (region) {
            case 0:
                [dict setObject:@"BR" forKey:@"endpoint"];
                break;
            case 1:
                [dict setObject:@"EUNE" forKey:@"endpoint"];
                break;
            case 2:
                [dict setObject:@"EUW" forKey:@"endpoint"];
                break;
            case 3:
                [dict setObject:@"KR" forKey:@"endpoint"];
                break;
            case 4:
                [dict setObject:@"LAN" forKey:@"endpoint"];
                break;
            case 5:
                [dict setObject:@"LAS" forKey:@"endpoint"];
                break;
            case 6:
                [dict setObject:@"NA" forKey:@"endpoint"];
                break;
            case 7:
                [dict setObject:@"OCE" forKey:@"endpoint"];
                break;
            case 8:
                [dict setObject:@"RU" forKey:@"endpoint"];
                break;
            case 9:
                [dict setObject:@"TR" forKey:@"endpoint"];
                break;
                
            default:
                break;
        }
        return [dict writeToFile:filePath atomically:YES];
    }
}

@end