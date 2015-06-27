//
//  BusinessCell.m
//  Yelp
//
//  Created by Jhih-Yan Lin on 6/20/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import "BusinessCell.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface BusinessCell()
@property (weak, nonatomic) IBOutlet UIImageView *posterView;

//@property (weak, nonatomic) IBOutlet UIImageView *ratingView;
//@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
//@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
//@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
//@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
//@property (weak, nonatomic) IBOutlet UILabel *reviewLabel;
//
@end

@implementation BusinessCell

- (void) setBusiness:(Business *)business {
    //self.business = business;
    
    [self.posterView setImageWithURL: [NSURL URLWithString:business.imageUrl]];
//    [self.ratingView setImageWithURL: [NSURL URLWithString:business.ratingUrl]];
//    self.nameLabel.text = business.name;
//    self.categoryLabel.text = business.categories;
//    self.addressLabel.text = business.address;
//    self.reviewLabel.text = [NSString stringWithFormat:@"%ld Reviews", (long)business.numReviews];
//    
//    self.distanceLabel.text = [NSString stringWithFormat:@"%.2f mi", business.distance];
}
@end