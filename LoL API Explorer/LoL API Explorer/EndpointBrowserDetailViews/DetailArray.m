//
//  DetailArray.m
//  LoL API Explorer
//
//  Created by Victor Ilisei on 5/21/15.
//  Copyright (c) 2015 Tech Genius. All rights reserved.
//

#import "DetailArray.h"
#import "DetailDictionary.h"

@interface DetailArray ()

@end

@implementation DetailArray

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.content.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    cell.textLabel.text = [NSString stringWithFormat:@"Item %ld", (long)indexPath.row];
    
    if ([self.content[indexPath.row] isKindOfClass:[NSDictionary class]]) {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"(%lu items)", (unsigned long)[self.content[indexPath.row] allValues].count];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    }  else if ([self.content[indexPath.row] isKindOfClass:[NSArray class]]) {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"(%lu items)", (unsigned long)[self.content[indexPath.row] count]];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    } else {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", self.content[indexPath.row]];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self.content[indexPath.row] isKindOfClass:[NSDictionary class]]) {
        DetailDictionary *detail = [[DetailDictionary alloc] init];
        detail.title = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
        detail.content = self.content[indexPath.row];
        [self.navigationController pushViewController:detail animated:YES];
    } else if ([self.content[indexPath.row] isKindOfClass:[NSArray class]]) {
        DetailArray *detail = [[DetailArray alloc] init];
        detail.title = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
        detail.content = self.content[indexPath.row];
        [self.navigationController pushViewController:detail animated:YES];
    }
}

@end