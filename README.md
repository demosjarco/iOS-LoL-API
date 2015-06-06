# iOS LoL API

Objective-C client for retrieving data from "League of Legends" API. All available web services exposed by the official League of Legends API are available allowing developers easy access without hassle. This client even has offline access to whatever data once it has accessed it at least once successfully. This also included data dragon integration for latest images. Also has an option to store images offline too (but will take up alot of space). This is handy for your rate limit exceeded (429) or service unavailable (503) or user simply offline.

## Riot API Terms & Conditions
Please read Riot Games API terms [here](https://developer.riotgames.com/terms) and adhere to those rules. iOS LoL API is not responsible for any API misuses. iOS LoL API isn't endorsed by Riot Games and doesn't reflect the views or opinions of Riot Games or anyone officially involved in producing or managing League of Legends. League of Legends and Riot Games are trademarks or registered trademarks of Riot Games, Inc. League of Legends © Riot Games, Inc.

## Why you should use this
- Heavily documented
- Offline capability
- Data Dragon image support built in
- Rate limit support

## Requirements
- ARC

### Cocoa Frameworks Required
- Foundation
- UIKit

## Getting Started

1. Subclass the ILA_Setup and override the 2 methods `+ (void)getAPIkey :(void (^)(NSString *apiKey))completionBlock` and `+ (void)getLeagueRegion :(void (^)(NSString *regionCode))completionBlock` and use the `completionBlock()` to return NSString of the appropriate values. See code comments for more information.
2. Import `iOSLoLAPI.h` into any class that you need to call methods, or in a prefix file as you please.
3. Call away! Note if you hit your rate limit or for whatever reason server is offline, it will attempt to read the last saved version and return that instead. These files are saved in the `~/Documents/Riot_API_Cache/` of your application documents directory. You may change this in `ILA_LocalStore`.
4. 
## Examples
See project LoL API Explorer for code examples and/or excerpt for my league app below.

```
[ILA_Champion getAllChampionsWithOnlyFreeChamps:NO :^(NSArray *champions) {
        for (ILA_ChampionDto *champ in champions) {
            [ILA_StaticData getChampionInfoFor:[NSNumber numberWithLong:champ.champId].intValue withData:@"image" :^(ILA_StaticData_ChampionDto *championInfo) {
                if (champ.freeToPlay) {
                    // Do stuff
                } else {
                    // Do other stuff
                }
                
                for (NSMutableArray *section in champs) {
                    // Gotta make a quick snapshot of what it was before for fancy stuff later on
                    NSMutableArray *oldSection = [NSArray arrayWithArray:section].mutableCopy;
                    // I like champions organized alphabetically
                    [section sortUsingComparator:^NSComparisonResult(ILA_StaticData_ChampionDto *obj1, ILA_StaticData_ChampionDto *obj2) {
                        NSString *champName1 = obj1.name;
                        NSString *champName2 = obj2.name;
                        return [champName1 compare:champName2];
                    }];
                    
                    // Lets get fancy and animate movement of items
                    for (NSDictionary *champInfo2 in section) {
                        if ([oldSection indexOfObject:champInfo2] != [section indexOfObject:champInfo2]) {
                            [self.collectionView moveItemAtIndexPath:[NSIndexPath indexPathForItem:[oldSection indexOfObject:champInfo2] inSection:[champs indexOfObject:section]] toIndexPath:[NSIndexPath indexPathForItem:[section indexOfObject:champInfo2] inSection:[champs indexOfObject:section]]];
                            [oldSection removeObject:champInfo2];
                            [oldSection insertObject:champInfo2 atIndex:[section indexOfObject:champInfo2]];
                        }
                    }
                }
                
                // Lets stop the spinning wheel
                if ([champs[0] count] + [champs[1] count] == champions.count) {
                    [refreshControl endRefreshing];
                }
            }];
        }
    }];
```
