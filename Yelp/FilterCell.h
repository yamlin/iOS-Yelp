//
//  FilterCell.h
//  Yelp
//
//  Created by Jhih-Yan Lin on 6/21/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FilterCell;

@protocol FilterCellDelegate <NSObject>

- (void)switchCell: (FilterCell *) cell didUpdateValue:(BOOL) value;

@end

@interface FilterCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) id<FilterCellDelegate> delegate;
@property (assign, nonatomic) BOOL on;

- (void)setOn:(BOOL)on animated:(BOOL) animated;
@end
