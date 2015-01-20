//
//  ILA_Connection.m
//  LoL API Explorer
//
//  Created by Victor Ilisei on 1/20/15.
//  Copyright (c) 2015 Tech Genius. All rights reserved.
//

#import "ILA_Connection.h"

@implementation ILA_Connection

/**
 @note check if @c dateOfLocalStore is nil to check if locally stored or live from server.
 @return @c json can be nil if data not available online or locally stored
 @return @c dateOfLocalStore is last save to local store of current request, it is nil if data is successfully retreived from server
 @return @c statusCode is the HTTP status code returned from request
 @return @c connectionError the NSError returned by NSURLConnection for not being able to reach the url
 */
+ (void)connectWithURL:(NSString *)url completion:(void(^)(NSDictionary *json, NSDate *dateOfLocalStore, NSInteger statusCode, NSError *connectionError))completionBlock {
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            if ([ILA_LocalStore getItemFromLocalStoreForFilename:[url lastPathComponent] inFolder:[[url stringByDeletingLastPathComponent] lastPathComponent]]) {
                completionBlock([[ILA_LocalStore getItemFromLocalStoreForFilename:[url lastPathComponent] inFolder:[[url stringByDeletingLastPathComponent] lastPathComponent]] objectForKey:@"json"], [[ILA_LocalStore getItemFromLocalStoreForFilename:[url lastPathComponent] inFolder:[[url stringByDeletingLastPathComponent] lastPathComponent]] objectForKey:@"modifiedDate"], 0, connectionError);
            } else {
                completionBlock(nil, nil, 0, connectionError);
            }
        } else {
            @autoreleasepool {
                // Check Response code
                NSHTTPURLResponse *correctResponse = (NSHTTPURLResponse *)response;
                
                if (correctResponse.statusCode == 200) {
                    [ILA_LocalStore writeToLocalStore:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil] inFolder:[[url stringByDeletingLastPathComponent] lastPathComponent] withFilename:[url lastPathComponent]];
                    completionBlock([NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil], nil, correctResponse.statusCode, nil);
                } else {
                    if ([ILA_LocalStore getItemFromLocalStoreForFilename:[url lastPathComponent] inFolder:[[url stringByDeletingLastPathComponent] lastPathComponent]]) {
                        completionBlock([[ILA_LocalStore getItemFromLocalStoreForFilename:[url lastPathComponent] inFolder:[[url stringByDeletingLastPathComponent] lastPathComponent]] objectForKey:@"json"], [[ILA_LocalStore getItemFromLocalStoreForFilename:[url lastPathComponent] inFolder:[[url stringByDeletingLastPathComponent] lastPathComponent]] objectForKey:@"modifiedDate"], correctResponse.statusCode, nil);
                    } else {
                        completionBlock(nil, nil, correctResponse.statusCode, nil);
                    }
                }
            }
        }
    }];
}

@end