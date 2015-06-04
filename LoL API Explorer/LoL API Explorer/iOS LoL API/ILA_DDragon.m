//
//  ILA_DDragon.m
//  LoL API Explorer
//
//  Created by Victor Ilisei on 5/31/15.
//  Copyright (c) 2015 Tech Genius. All rights reserved.
//

#import "ILA_DDragon.h"
#import "ILA_StaticData.h"

@implementation ILA_DDragon

#pragma mark - Private Methods

+ (void)getCDNurl:(void (^)(NSString *cdnUrl))completionBlock {
    [ILA_StaticData getRealmInfo:^(NSDictionary *realmInfo) {
        completionBlock(realmInfo[@"cdn"]);
    }];
}

+ (void)getLatestDDragonVersionFor:(NSString *)dataType :(void (^)(NSString *version))completionBlock {
    [ILA_StaticData getRealmInfo:^(NSDictionary *realmInfo) {
        if ([dataType isEqualToString:@"v"]) {
            completionBlock(realmInfo[dataType]);
        } else {
            NSDictionary *n = realmInfo[@"n"];
            completionBlock(n[dataType]);
        }
    }];
}

+ (void)optimalRegionCode:(void (^)(NSString *localeCode))completionBlock {
    [ILA_StaticData getRegionValidLocales:^(NSArray *validLocales) {
        if ([validLocales containsObject:[[NSLocale autoupdatingCurrentLocale] localeIdentifier]]) {
            completionBlock([[NSLocale autoupdatingCurrentLocale] localeIdentifier]);
        } else {
            [ILA_StaticData getRealmInfo:^(NSDictionary *realmInfo) {
                completionBlock(realmInfo[@"l"]);
            }];
        }
    }];
}

+ (void)connectToDDragon:(NSString *)url :(void (^)(NSData *data))completionBlock {
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSHTTPURLResponse *correctResponse = (NSHTTPURLResponse *)response;
        if (correctResponse.statusCode == 200 && data && !connectionError) {
            completionBlock(data);
        }
    }];
}

#pragma mark - Public Methods

+ (void)getImageFromRect:(CGRect)imageRectInSprite fromSprite:(UIImage *)sprite :(void (^)(UIImage *))completionBlock {
    CGImageRef imageRef = CGImageCreateWithImageInRect(sprite.CGImage, imageRectInSprite);
    completionBlock([UIImage imageWithCGImage:imageRef]);
    CGImageRelease(imageRef);
}

+ (void)getProfileIcon:(int)profileIconId :(void (^)(UIImage *))completionBlock {
    [self getCDNurl:^(NSString *cdnUrl) {
        [self getLatestDDragonVersionFor:@"profileicon" :^(NSString *version) {
            NSString *url = [[[[[cdnUrl stringByAppendingPathComponent:version] stringByAppendingPathComponent:@"img"] stringByAppendingPathComponent:@"profileicon"] stringByAppendingPathComponent:[NSString stringWithFormat:@"%d", profileIconId]] stringByAppendingPathExtension:@"png"];
            
            [self connectToDDragon:url :^(NSData *data) {
                completionBlock([UIImage imageWithData:data]);
            }];
        }];
    }];
}

+ (void)getSplashArtForChampion:(NSString *)fileName withSkinNumber:(int)skinNumber :(void (^)(UIImage *))completionBlock {
    [self getCDNurl:^(NSString *cdnUrl) {
        NSString *url = [[[[cdnUrl stringByAppendingPathComponent:@"img"] stringByAppendingPathComponent:@"champion"] stringByAppendingPathComponent:@"splash"] stringByAppendingPathComponent:[[fileName stringByDeletingPathExtension] stringByAppendingFormat:@"_%d.jpg", skinNumber]];
        
        [self connectToDDragon:url :^(NSData *data) {
            completionBlock([UIImage imageWithData:data]);
        }];
    }];
}

+ (void)getLoadingArtForChampion:(NSString *)fileName withSkinNumber:(int)skinNumber :(void (^)(UIImage *))completionBlock {
    [self getCDNurl:^(NSString *cdnUrl) {
        NSString *url = [[[[cdnUrl stringByAppendingPathComponent:@"img"] stringByAppendingPathComponent:@"champion"] stringByAppendingPathComponent:@"loading"] stringByAppendingPathComponent:[[fileName stringByDeletingPathExtension] stringByAppendingFormat:@"_%d.jpg", skinNumber]];
        
        [self connectToDDragon:url :^(NSData *data) {
            completionBlock([UIImage imageWithData:data]);
        }];
    }];
}

+ (void)getSquareArtForChampion:(NSString *)fileName :(void (^)(UIImage *))completionBlock {
    [self getCDNurl:^(NSString *cdnUrl) {
        [self getLatestDDragonVersionFor:@"champion" :^(NSString *version) {
            NSString *url = [[[[cdnUrl stringByAppendingPathComponent:version] stringByAppendingPathComponent:@"img"] stringByAppendingPathComponent:@"champion"] stringByAppendingPathComponent:fileName];
            
            [self connectToDDragon:url :^(NSData *data) {
                completionBlock([UIImage imageWithData:data]);
            }];
        }];
    }];
}

+ (void)getPassiveAbilityIcon:(NSString *)fileName :(void (^)(UIImage *))completionBlock {
    [self getCDNurl:^(NSString *cdnUrl) {
        [self getLatestDDragonVersionFor:@"champion" :^(NSString *version) {
            NSString *url = [[[[cdnUrl stringByAppendingPathComponent:version] stringByAppendingPathComponent:@"img"] stringByAppendingPathComponent:@"passive"] stringByAppendingPathComponent:fileName];
            
            [self connectToDDragon:url :^(NSData *data) {
                completionBlock([UIImage imageWithData:data]);
            }];
        }];
    }];
}

+ (void)getAbilityIcon:(NSString *)fileName :(void (^)(UIImage *))completionBlock {
    [self getCDNurl:^(NSString *cdnUrl) {
        [self getLatestDDragonVersionFor:@"champion" :^(NSString *version) {
            NSString *url = [[[[cdnUrl stringByAppendingPathComponent:version] stringByAppendingPathComponent:@"img"] stringByAppendingPathComponent:@"spell"] stringByAppendingPathComponent:fileName];
            
            [self connectToDDragon:url :^(NSData *data) {
                completionBlock([UIImage imageWithData:data]);
            }];
        }];
    }];
}

+ (void)getSummonerSpell:(NSString *)fileName :(void (^)(UIImage *))completionBlock {
    [self getCDNurl:^(NSString *cdnUrl) {
        [self getLatestDDragonVersionFor:@"summoner" :^(NSString *version) {
            NSString *url = [[[[cdnUrl stringByAppendingPathComponent:version] stringByAppendingPathComponent:@"img"] stringByAppendingPathComponent:@"spell"] stringByAppendingPathComponent:fileName];
            
            [self connectToDDragon:url :^(NSData *data) {
                completionBlock([UIImage imageWithData:data]);
            }];
        }];
    }];
}

+ (void)getItem:(NSString *)fileName :(void (^)(UIImage *))completionBlock {
    [self getCDNurl:^(NSString *cdnUrl) {
        [self getLatestDDragonVersionFor:@"item" :^(NSString *version) {
            NSString *url = [[[[cdnUrl stringByAppendingPathComponent:version] stringByAppendingPathComponent:@"img"] stringByAppendingPathComponent:@"item"] stringByAppendingPathComponent:fileName];
            
            [self connectToDDragon:url :^(NSData *data) {
                completionBlock([UIImage imageWithData:data]);
            }];
        }];
    }];
}

+ (void)getMasteryIcon:(NSString *)fileName hasRank:(BOOL)hasRank :(void (^)(UIImage *))completionBlock {
    [self getCDNurl:^(NSString *cdnUrl) {
        [self getLatestDDragonVersionFor:@"mastery" :^(NSString *version) {
            NSString *url;
            if (hasRank) {
                url = [[[[cdnUrl stringByAppendingPathComponent:version] stringByAppendingPathComponent:@"img"] stringByAppendingPathComponent:@"mastery"] stringByAppendingPathComponent:fileName];
            } else {
                url = [[[[cdnUrl stringByAppendingPathComponent:version] stringByAppendingPathComponent:@"img"] stringByAppendingPathComponent:@"mastery"] stringByAppendingPathComponent:[NSString stringWithFormat:@"gray_%@", fileName]];
            }
            
            [self connectToDDragon:url :^(NSData *data) {
                completionBlock([UIImage imageWithData:data]);
            }];
        }];
    }];
}

+ (void)getRuneIcon:(NSString *)fileName :(void (^)(UIImage *))completionBlock {
    [self getCDNurl:^(NSString *cdnUrl) {
        [self getLatestDDragonVersionFor:@"rune" :^(NSString *version) {
            NSString *url = [[[[cdnUrl stringByAppendingPathComponent:version] stringByAppendingPathComponent:@"img"] stringByAppendingPathComponent:@"rune"] stringByAppendingPathComponent:fileName];
            
            [self connectToDDragon:url :^(NSData *data) {
                completionBlock([UIImage imageWithData:data]);
            }];
        }];
    }];
}

+ (void)getSpriteSheet:(NSString *)fileName :(void (^)(UIImage *))completionBlock {
    [self getCDNurl:^(NSString *cdnUrl) {
        [self getLatestDDragonVersionFor:@"v" :^(NSString *version) {
            NSString *url = [[[[cdnUrl stringByAppendingPathComponent:version] stringByAppendingPathComponent:@"img"] stringByAppendingPathComponent:@"sprite"] stringByAppendingPathComponent:fileName];
            
            [self connectToDDragon:url :^(NSData *data) {
                completionBlock([UIImage imageWithData:data]);
            }];
        }];
    }];
}

+ (void)getMinimap:(NSString *)fileName :(void (^)(UIImage *))completionBlock {
    [self getCDNurl:^(NSString *cdnUrl) {
        [self getLatestDDragonVersionFor:@"v" :^(NSString *version) {
            NSString *url = [[[[cdnUrl stringByAppendingPathComponent:version] stringByAppendingPathComponent:@"img"] stringByAppendingPathComponent:@"map"] stringByAppendingPathComponent:fileName];
            
            [self connectToDDragon:url :^(NSData *data) {
                completionBlock([UIImage imageWithData:data]);
            }];
        }];
    }];
}

/**
 @param icon Valid values: champion, gold, items, minion, score, spells
 */
+ (void)getScoreboardIcon:(NSString *)icon :(void (^)(UIImage *))completionBlock {
    [self getCDNurl:^(NSString *cdnUrl) {
        [self getLatestDDragonVersionFor:@"v" :^(NSString *version) {
            NSString *url = [[[[[cdnUrl stringByAppendingPathComponent:version] stringByAppendingPathComponent:@"img"] stringByAppendingPathComponent:@"ui"] stringByAppendingPathComponent:icon] stringByAppendingPathExtension:@"png"];
            
            [self connectToDDragon:url :^(NSData *data) {
                completionBlock([UIImage imageWithData:data]);
            }];
        }];
    }];
}

@end