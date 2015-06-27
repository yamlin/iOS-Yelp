//
//  FilterCell.m
//  Yelp
//
//  Created by Jhih-Yan Lin on 6/21/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import "FilterCell.h"

@interface FilterCell()
@property (weak, nonatomic) IBOutlet UISwitch *switchToggle;

@end

@implementation FilterCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)switchValueChanged:(id)sender {
    [self.delegate switchCell:self didUpdateValue:self.switchToggle.on];
}

- (void)setOn:(BOOL)on {
    [self setOn:on animated:NO];
}

- (void)setOn:(BOOL)on animated:(BOOL) animated {
    _on = on;
    [self.switchToggle setOn:on animated:animated];
}
@end
