//
//  ILA_Connection.h
//  LoL API Explorer
//
//  Created by Victor Ilisei on 1/20/15.
//  Copyright (c) 2015 Tech Genius. All rights reserved.
//

#pragma mark - API RESPONSE ERROR CODES

/**
 Request succeeded and there were no issues.
 */
#define SUCCEEDED 200

/**
 This error indicates that there is a syntax error in the request and the request has therefore been denied. The client should not continue to make similar requests without modifying the syntax or the requests being made.
 
 Common Reasons
 - A provided parameter is in the wrong format (e.g., a string instead of an integer)
 - A required parameter was not provided
 */
#define BAD_REQUEST 400

/**
 This error indicates that the API request being made did not contain the necessary authentication credentials and therefore the client was denied access. If authentication credentials were already included then the Unauthorized response indicates that authorization has been refused for those credentials. In the case of the API, authorization credentials refer to your API key.
 
 Common Reasons
 - No API key was provided with the API request
 - An invalid API key was provided with the API request
 - The API request was for an incorrect or unsupported path
 */
#define UNAUTHORIZED 401

/**
 This error indicates that the server has not found a match for the API request being made. No indication is given whether the condition is temporary or permanent.
 
 Common Reasons
 - The ID or name provided does not match any existing resource (e.g., there is no summoner matching the specified ID)
 - The API request was for an incorrect or unsupported path
 */
#define NO_DATA_FOUND 404

/**
 This error indicates that the application has exhausted its maximum number of allotted API calls allowed for a given duration. If the client receives a Rate Limit Exceeded response the client should process this response and halt future API calls for the duration, in seconds, indicated by the Retry-After header. Due to the increased frequency of clients ignoring this response, applications that are in violation of this policy may be disabled to preserve the integrity of the API.
 
 Common Reasons
 - Unregulated API calls. Check your API Call Graphs to monitor your Dev and Production API key activity.
 */
#define RATE_LIMIT_EXCEEDED 429

/**
 This error indicates an unexpected condition or exception which prevented the server from fulfilling an API request.
 */
#define INTERNAL_SERVER_ERROR 500

/**
 This error indicates the server is currently unavailable to handle requests because of an unknown reason. The Service Unavailable response implies a temporary condition which will be alleviated after some delay.
 */
#define SERVICE_UNAVAILABLE 503

#import "ILA_LocalStore.h"

@interface ILA_Connection : NSObject

+ (NSDictionary *)getRegionEndpointDictionary;
+ (void)getRegionHost :(void (^)(NSString *host))completionBlock;
+ (void)getRegionCode :(void (^)(NSString *regionCode))completionBlock;
+ (void)getRegionPlatformID :(void (^)(NSString *regionPlatformID))completionBlock;

+ (void)connectToServer:(NSURL *)url withFilename:(NSString *)cacheFilename inFolder:(NSString *)folder :(void (^)(id json, NSInteger responseCode, BOOL fromCache))completionBlock;

@end