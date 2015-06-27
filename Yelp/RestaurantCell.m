//
//  RestaurantCell.m
//  Yelp
//
//  Created by Jhih-Yan Lin on 6/21/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import "RestaurantCell.h"

#import <AFNetworking/UIImageView+AFNetworking.h>

@interface RestaurantCell()

@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UIImageView *ratingView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *reviewLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

@end


@implementation RestaurantCell

- (void)awakeFromNib {
    // Initialization code
    self.nameLabel.preferredMaxLayoutWidth = self.nameLabel.frame.size.width;
    self.posterView.layer.cornerRadius = 3;
    self.posterView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setBusiness:(Business *)business {
    _business = business;
    
    [self.posterView setImageWithURL: [NSURL URLWithString:business.imageUrl]];
        [self.ratingView setImageWithURL: [NSURL URLWithString:business.ratingUrl]];
        self.nameLabel.text = business.name;
        self.categoryLabel.text = business.categories;
        self.addressLabel.text = business.address;
        self.reviewLabel.text = [NSString stringWithFormat:@"%ld Reviews", (long)business.numReviews];
    
        self.distanceLabel.text = [NSString stringWithFormat:@"%.2f mi", business.distance];
}


@end
