//
//  SwitchCell.h
//  Yelp
//
//  Created by Jhih-Yan Lin on 6/22/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SwitchCell;

@protocol SwitchCellDelete <NSObject>

- (void)switchCell:(SwitchCell *)cell didUpdateValue:(BOOL) value;

@end

@interface SwitchCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (assign, nonatomic) BOOL on;

@property (strong, nonatomic) id<SwitchCellDelete> delegate;

- (void)setOn:(BOOL)on animated:(BOOL) animated;


@end
