//
//  Business.h
//  Yelp
//
//  Created by Jhih-Yan Lin on 6/20/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Business : NSObject

@property (strong, nonatomic) NSString *imageUrl;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *ratingUrl;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *categories;

@property (assign, nonatomic) CGFloat  distance;
@property (assign, nonatomic) NSInteger numReviews;

+(NSArray *) bussinessWithDictionary:(NSArray *) dicts;

@end
