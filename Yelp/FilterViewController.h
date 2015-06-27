//
//  FilterViewController.h
//  Yelp
//
//  Created by Jhih-Yan Lin on 6/21/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FilterViewController;

@protocol FilterViewControllerDelegeate <NSObject>

- (void)filterViewController:(FilterViewController *) filterViewController didChangeFilter:(NSDictionary *) filters;

@end

@interface FilterViewController : UIViewController

@property (weak, nonatomic) id<FilterViewControllerDelegeate> delegate;


@end
