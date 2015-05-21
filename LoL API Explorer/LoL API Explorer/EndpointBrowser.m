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
                    <#statements#>
                    break;
                    
                default:
                    break;
            }
            break;
            
        default:
            break;
    }
}

@end