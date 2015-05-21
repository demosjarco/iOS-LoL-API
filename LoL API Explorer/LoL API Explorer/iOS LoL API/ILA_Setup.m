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

/**
 This is the method that the API calls to get the api key. Use this method to supply this framework with your API Key.
 @note This is called every times any endpoint is used so make sure either this is saved to disk or on a server that has a decent rate limit.
 @see https://developer.riotgames.com for API key.
 @warning this method has no validation for your key so make sure its formatted correctly (no spaces, etc.)
 @return @p apiKey should be the NSString value of your key
 */
+ (void)getAPIkey :(void (^)(NSString *apiKey))completionBlock {
    completionBlock(@"2112a619-bd40-4f33-a086-cb41d67c3423");
}

/**
 This is the method where the API gets what region it's supposed to get data from.
 @note This is called every times any endpoint is used so make sure either this is saved to disk or on a server that has a decent rate limit.
 @return @p regionCode should be the NSString (lowercase) value of your region
 */
+ (void)getLeagueRegion :(void (^)(NSString *regionCode))completionBlock {
    @autoreleasepool {
        NSString *regionCode = @"NA";
        completionBlock([regionCode lowercaseString]);
    }
}

#pragma mark - Public methods

@end