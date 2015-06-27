//
//  PickerCell.m
//  Yelp
//
//  Created by Jhih-Yan Lin on 6/24/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import "PickerCell.h"

@interface PickerCell()
@property (weak, nonatomic) IBOutlet UIPickerView *picker;


@end

@implementation PickerCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
