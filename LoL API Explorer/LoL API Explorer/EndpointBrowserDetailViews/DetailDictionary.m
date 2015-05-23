//
//  DetailDictionary.m
//  LoL API Explorer
//
//  Created by Victor Ilisei on 5/21/15.
//  Copyright (c) 2015 Tech Genius. All rights reserved.
//

#import "DetailDictionary.h"
#import "DetailArray.h"

@interface DetailDictionary ()

@end

@implementation DetailDictionary

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.content.allKeys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    cell.textLabel.text = self.content.allKeys[indexPath.row];
    if ([self.content.allValues[indexPath.row] isKindOfClass:[NSDictionary class]]) {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"(%lu items)", (unsigned long)[self.content.allValues[indexPath.row] allValues].count];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    } else if ([self.content.allValues[indexPath.row] isKindOfClass:[NSArray class]]) {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"(%lu items)", (unsigned long)[self.content.allValues[indexPath.row] count]];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    } else {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", self.content.allValues[indexPath.row]];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self.content.allValues[indexPath.row] isKindOfClass:[NSDictionary class]]) {
        DetailDictionary *detail = [[DetailDictionary alloc] init];
        detail.title = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
        detail.content = self.content.allValues[indexPath.row];
        [self.navigationController pushViewController:detail animated:YES];
    } else if ([self.content.allValues[indexPath.row] isKindOfClass:[NSArray class]]) {
        DetailArray *detail = [[DetailArray alloc] init];
        detail.title = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
        detail.content = self.content.allValues[indexPath.row];
        [self.navigationController pushViewController:detail animated:YES];
    } else {
        CGSize size = [[tableView cellForRowAtIndexPath:indexPath].detailTextLabel.text sizeWithAttributes:@{NSFontAttributeName: [tableView cellForRowAtIndexPath:indexPath].detailTextLabel.font}];
        if (size.width > [tableView cellForRowAtIndexPath:indexPath].detailTextLabel.bounds.size.width) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:[tableView cellForRowAtIndexPath:indexPath].textLabel.text message:[tableView cellForRowAtIndexPath:indexPath].detailTextLabel.text preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleCancel handler:nil]];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
}

@end