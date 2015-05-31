//
//  ILA_Connection.m
//  LoL API Explorer
//
//  Created by Victor Ilisei on 1/20/15.
//  Copyright (c) 2015 Tech Genius. All rights reserved.
//

#import "ILA_Connection.h"
#import "ILA_Setup.h"
#import "ILA_Constants.h"
#import "ILA_LocalStore.h"

@implementation ILA_Connection

#pragma mark - Get Region Stuff for Riot API

+ (NSDictionary *)getRegionEndpointDictionary {
    return [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Regional Endpoints" ofType:@"plist"]];
}

+ (void)getRegionHost:(void (^)(NSString *))completionBlock {
    [ILA_Setup getLeagueRegion:^(NSString *regionCode) {
        completionBlock([[[self getRegionEndpointDictionary] objectForKey:regionCode.lowercaseString] objectForKey:@"Host"]);
    }];
}

+ (void)getRegionCode:(void (^)(NSString *))completionBlock {
    [ILA_Setup getLeagueRegion:^(NSString *regionCode) {
        completionBlock([[[[self getRegionEndpointDictionary] objectForKey:regionCode.lowercaseString] objectForKey:@"Region"] lowercaseString]);
    }];
}

+ (void)getRegionPlatformID:(void (^)(NSString *))completionBlock {
    [ILA_Setup getLeagueRegion:^(NSString *regionCode) {
        completionBlock([[[self getRegionEndpointDictionary] objectForKey:regionCode.lowercaseString] objectForKey:@"Platform ID"]);
    }];
}

+ (void)connectToServer:(NSURL *)url withFilename:(NSString *)cacheFilename inFolder:(NSString *)folder :(void (^)(id, NSInteger, BOOL))completionBlock {
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            // Error Log
            NSLog(@"Error (%@) while retrieving file from %@", connectionError, url.absoluteString);
            
            // Cache
            [ILA_LocalStore getCacheOfFilename:cacheFilename inFolder:folder :^(NSDictionary *dictJson, NSArray *arrJson) {
                if (dictJson) {
                    completionBlock(dictJson, 0, YES);
                } else if (arrJson) {
                    completionBlock(arrJson, 0, YES);
                }
            }];
        } else {
            // Check Response code
            NSHTTPURLResponse *correctResponse = (NSHTTPURLResponse *)response;
            
            if (correctResponse.statusCode == SUCCEEDED) {
                @autoreleasepool {
                    NSError *jsonError;
                    id json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
                    if (jsonError) {
                        NSLog(@"JSON Parse error (%@) when reading file from %@", jsonError, url.absoluteString);
                    } else {
                        [ILA_LocalStore saveCacheOf:json withName:cacheFilename inFolder:folder :^(BOOL succeeded) {
                            completionBlock(json, correctResponse.statusCode, NO);
                        }];
                    }
                }
            } else {
                // Error Log
                NSLog(@"Error (%ld) while retrieving file from %@", (long)correctResponse.statusCode, url.absoluteString);
                if (correctResponse.statusCode == NO_DATA_FOUND) {
                    completionBlock(nil, correctResponse.statusCode, NO);
                }
                
                // Cache
                [ILA_LocalStore getCacheOfFilename:cacheFilename inFolder:folder :^(NSDictionary *dictJson, NSArray *arrJson) {
                    if (dictJson) {
                        completionBlock(dictJson, correctResponse.statusCode, YES);
                    } else if (arrJson) {
                        completionBlock(arrJson, correctResponse.statusCode, YES);
                    }
                }];
            }
        }
    }];
}

@end