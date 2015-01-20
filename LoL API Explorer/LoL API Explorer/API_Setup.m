//
//  API_Setup.m
//  LoL API Explorer
//
//  Created by Victor Ilisei on 1/20/15.
//  Copyright (c) 2015 Tech Genius. All rights reserved.
//

#import "API_Setup.h"

#import "iOSLoLAPI.h"

@implementation API_Setup

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        ios7yPadding = self.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height;
    } else {
        ios7yPadding = 0.0f;
    }
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Use Test Key" style:UIBarButtonItemStyleBordered target:self action:@selector(useTestKey)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(nextView)];
    
    apiField = [[UITextField alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - (self.view.frame.size.width - VIEW_PADDING * 2) / 2, ios7yPadding + VIEW_PADDING, self.view.frame.size.width - VIEW_PADDING * 2, 30)];
    apiField.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    apiField.borderStyle = UITextBorderStyleRoundedRect;
    apiField.textAlignment = NSTextAlignmentCenter;
    apiField.placeholder = @"Riot Games API Key";
    apiField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:apiField];
    
    regions = @[@"Brazil", @"EU Nordic & East", @"EU West", @"Korea", @"Latin America North", @"Latin America South", @"North America", @"Oceania", @"Russia", @"Turkey"];
    
    regionPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 162, self.view.frame.size.width, 162)];
    regionPicker.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    regionPicker.delegate = self;
    regionPicker.dataSource = self;
    [self.view addSubview:regionPicker];
}

- (void)useTestKey {
    @autoreleasepool {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"This key is for demo purposes. Please do not use this key to spam or abuse. Rate limit:\n\n10 request(s) every 10 second(s)\n500 request(s) every 10 minute(s)" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"I Agree", nil];
        alert.delegate = self;
        [alert show];
    }
}

- (void)nextView {
    if (apiField.text.length == 36) {
        [ILA_Setup setupAPIwithKey:apiField.text region:[regionPicker selectedRowInComponent:0]];
    } else {
        @autoreleasepool {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Make sure you have typed your API key correctly" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
            [alert show];
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != [alertView cancelButtonIndex]) {
        apiField.text = @"2112a619-bd40-4f33-a086-cb41d67c3423";
    }
}

#pragma mark - UIPickerView data source

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return regions.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return regions[row];
}

@end