//
//  PickerCell.h
//  Yelp
//
//  Created by Jhih-Yan Lin on 6/24/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PickerCell;

@protocol PickerCellDelete <NSObject>

- (void)pickerCell:(PickerCell *)cell didUpdateValue:(BOOL) value;

@end


@interface PickerCell : UITableViewCell

@end
