//
//  API_Setup.h
//  LoL API Explorer
//
//  Created by Victor Ilisei on 1/20/15.
//  Copyright (c) 2015 Tech Genius. All rights reserved.
//

#import <UIKit/UIKit.h>

#define VIEW_PADDING 15.0f

@interface API_Setup : UIViewController <UIAlertViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate> {
    float ios7yPadding;
    UITextField *apiField;
    UIPickerView *regionPicker;
    NSArray *regions;
}

- (void)useTestKey;
- (void)nextView;

@end