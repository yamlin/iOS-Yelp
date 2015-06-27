//
//  MainViewController.m
//  Yelp
//
//  Created by Timothy Lee on 3/21/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "MainViewController.h"
#import "YelpClient.h"
#import "Business.h"
//#import "BusinessCell.h"
#import "RestaurantCell.h"
#import "FilterViewController.h"

NSString * const kYelpConsumerKey = @"vxKwwcR_NMQ7WaEiQBK_CA";
NSString * const kYelpConsumerSecret = @"33QCvh5bIF5jIHR5klQr7RtBDhQ";
NSString * const kYelpToken = @"uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV";
NSString * const kYelpTokenSecret = @"mqtKIxMIR4iBtBPZCmCLEb-Dz3Y";

@interface MainViewController () <UITableViewDataSource, UITableViewDelegate, FilterViewControllerDelegeate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) YelpClient *client;
@property (strong, nonatomic) NSArray *businesses;

@end

@implementation MainViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.title = @"Yelp";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStylePlain target:self action:@selector(onFilterButton)];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"RetaurantCell" bundle:nil] forCellReuseIdentifier:@"RetaurantCell"];
    
    // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
    self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];
    
    [self.client searchWithTerm:@"Thai" success:^(AFHTTPRequestOperation *operation, id response) {
        
        self.businesses = [Business bussinessWithDictionary:response[@"businesses"]];
        
        [self.tableView reloadData];
        //self.tableView.rowHeight = UITableViewAutomaticDimension;

//        NSLog(@"response: %@", response);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", [error description]);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma remark - Tableview implementation

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    RestaurantCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RestaurantCell"];
    Business *business = self.businesses[indexPath.row];
    
    [cell setBusiness: business];
    return cell;
    //return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSLog(@"count: %d", self.businesses.count);
    return 5;
    //return self.businesses.count;
}

#pragma remark - delegate
- (void) filterViewController:(FilterViewController *)filterViewController didChangeFilter:(NSDictionary *)filters {
    NSLog(@"network!!");
}


#pragma remark - Filter Button

- (void) onFilterButton {
    FilterViewController *fvc = [[FilterViewController alloc] init];
    fvc.delegate = self;
    
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:fvc];
    [self presentViewController:nvc animated:YES completion:nil];
}

@end
