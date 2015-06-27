//
//  Business.m
//  Yelp
//
//  Created by Jhih-Yan Lin on 6/20/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import "Business.h"

@implementation Business

- (id) initWithDictionary:(NSDictionary *) dict {
    self = [super init];
    
    if (self) {
        NSArray *categories = dict[@"categories"];
        NSMutableArray *categoryNames = [NSMutableArray array];
        
        [categories enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [categoryNames addObject:obj[0]];
        }];
        
        self.categories = [categoryNames componentsJoinedByString:@", "];
        
        self.name = dict[@"name"];
        
        self.imageUrl = dict[@"image_url"];
        self.ratingUrl = dict[@"rating_img_url"];
        
        NSString *stree = @"";
        NSArray *addresses = [dict valueForKeyPath:@"location.address"];
        if (addresses.count  > 0) {
            stree = [dict valueForKeyPath:@"location.address"][0];
        }
        
        NSString *neighborhood = @"";
        NSArray *neighs = [dict valueForKeyPath:@"location.neighborhoods"];
        if (neighs.count > 0) {
            neighborhood = [dict valueForKeyPath:@"location.neighborhoods"][0];
        }
        
        self.address = [NSString stringWithFormat:@"%@, %@", stree, neighborhood];
        float milesPerMeter = 0.00062137;
        self.distance = [dict[@"distance"] integerValue] * milesPerMeter;
        self.numReviews = [dict[@"review_count"] integerValue];
    }
    
    return self;
}

+(NSArray *) bussinessWithDictionary:(NSArray *) dicts {
    NSMutableArray *businesses = [NSMutableArray array];
    for (NSDictionary *dict in dicts) {
        Business *bns = [[Business alloc] initWithDictionary:dict];
        [businesses addObject:bns];
    }
    return businesses;
}
@end
