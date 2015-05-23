//
//  EndpointBrowser.m
//  LoL API Explorer
//
//  Created by Victor Ilisei on 5/21/15.
//  Copyright (c) 2015 Tech Genius. All rights reserved.
//

#import "EndpointBrowser.h"

#import "DetailArray.h"
#import "DetailDictionary.h"

#import "iOSLoLAPI.h"

@interface EndpointBrowser ()

@end

@implementation EndpointBrowser

- (instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"Endpoint Browser";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (NSArray *)endpoints {
    return [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Endpoints" ofType:@"plist"]];
}

#pragma mark - Table view data source

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[[self endpoints] objectAtIndex:section] objectForKey:@"endpointTitle"];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return [[[[[self endpoints] objectAtIndex:section] objectForKey:@"endpointRegions"] valueForKey:@"description"] componentsJoinedByString:@", "];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [[self endpoints] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [[[[self endpoints] objectAtIndex:section] objectForKey:@"subEndpoints"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    cell.textLabel.text = [[[[[self endpoints] objectAtIndex:indexPath.section] objectForKey:@"subEndpoints"] objectAtIndex:indexPath.row] objectForKey:@"relativePath"];
    cell.detailTextLabel.text = [[[[[self endpoints] objectAtIndex:indexPath.section] objectForKey:@"subEndpoints"] objectAtIndex:indexPath.row] objectForKey:@"description"];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                    @autoreleasepool {
                        UIAlertController *alert = [UIAlertController alertControllerWithTitle:[tableView cellForRowAtIndexPath:indexPath].textLabel.text message:[[tableView cellForRowAtIndexPath:indexPath].detailTextLabel.text stringByAppendingString:@"\n\n\n\nParam to retrieve only free to play champions."] preferredStyle:UIAlertControllerStyleAlert];
                        UISwitch *freeChampSwitch = [[UISwitch alloc] initWithFrame:CGRectMake((270 - 51) /2, 95, 51, 31)];
                        [alert.view addSubview:freeChampSwitch];
                        [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
                        [alert addAction:[UIAlertAction actionWithTitle:@"Submit" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                            [ILA_Champion getAllChampions:freeChampSwitch.on :^(NSArray *champions) {
                                @autoreleasepool {
                                    DetailArray *detail = [[DetailArray alloc] init];
                                    detail.title = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
                                    detail.content = champions;
                                    [self.navigationController pushViewController:detail animated:YES];
                                }
                            }];
                        }]];
                        [self presentViewController:alert animated:YES completion:nil];
                    }
                    break;
                case 1:
                    @autoreleasepool {
                        UIAlertController *alert = [UIAlertController alertControllerWithTitle:[tableView cellForRowAtIndexPath:indexPath].textLabel.text message:[tableView cellForRowAtIndexPath:indexPath].detailTextLabel.text preferredStyle:UIAlertControllerStyleAlert];
                        [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
                            textField.placeholder = @"ID of the champion to retrieve.";
                            textField.keyboardType = UIKeyboardTypeNumberPad;
                        }];
                        [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
                        [alert addAction:[UIAlertAction actionWithTitle:@"Submit" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                            [ILA_Champion getChampionByID:[alert.textFields[0] text].intValue :^(NSDictionary *champInfo) {
                                @autoreleasepool {
                                    DetailDictionary *detail = [[DetailDictionary alloc] init];
                                    detail.title = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
                                    detail.content = champInfo;
                                    [self.navigationController pushViewController:detail animated:YES];
                                }
                            }];
                        }]];
                        [self presentViewController:alert animated:YES completion:nil];
                    }
                    break;
                    
                default:
                    break;
            }
            break;
            
        case 1:
            switch (indexPath.row) {
                case 0:
                    @autoreleasepool {
                        UIAlertController *alert = [UIAlertController alertControllerWithTitle:[tableView cellForRowAtIndexPath:indexPath].textLabel.text message:[tableView cellForRowAtIndexPath:indexPath].detailTextLabel.text preferredStyle:UIAlertControllerStyleAlert];
                        [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
                            textField.placeholder = @"ID of the summonder to current game info.";
                            textField.keyboardType = UIKeyboardTypeNumberPad;
                        }];
                        [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
                        [alert addAction:[UIAlertAction actionWithTitle:@"Submit" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                            [ILA_CurrentGame getSpectatorGameInfoOfSummoner:[alert.textFields[0] text].intValue :^(NSDictionary *currentGameInfo) {
                                @autoreleasepool {
                                    DetailDictionary *detail = [[DetailDictionary alloc] init];
                                    detail.title = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
                                    detail.content = currentGameInfo;
                                    [self.navigationController pushViewController:detail animated:YES];
                                }
                            }];
                        }]];
                        [self presentViewController:alert animated:YES completion:nil];
                    }
                    break;
            }
            break;
            
        case 2:
            switch (indexPath.row) {
                case 0:
                    @autoreleasepool {
                        UIAlertController *alert = [UIAlertController alertControllerWithTitle:[tableView cellForRowAtIndexPath:indexPath].textLabel.text message:[tableView cellForRowAtIndexPath:indexPath].detailTextLabel.text preferredStyle:UIAlertControllerStyleAlert];
                        [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
                        [alert addAction:[UIAlertAction actionWithTitle:@"Submit" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                            [ILA_FeaturedGames getFeaturedGames:^(NSDictionary *featuredGames) {
                                @autoreleasepool {
                                    DetailDictionary *detail = [[DetailDictionary alloc] init];
                                    detail.title = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
                                    detail.content = featuredGames;
                                    [self.navigationController pushViewController:detail animated:YES];
                                }
                            }];
                        }]];
                        [self presentViewController:alert animated:YES completion:nil];
                    }
                    break;
            }
            break;
            
        default:
            break;
    }
}

@end