//
//  ViewController.m
//  Yelp
//
//  Created by Jhih-Yan Lin on 6/21/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import "ViewController.h"
#import "YelpClient.h"
#import "Business.h"
//#import "BusinessCell.h"
#import "RestaurantCell.h"
#import "FilterViewController.h"

NSString * const kYelpConsumerKey = @"vxKwwcR_NMQ7WaEiQBK_CA";
NSString * const kYelpConsumerSecret = @"33QCvh5bIF5jIHR5klQr7RtBDhQ";
NSString * const kYelpToken = @"uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV";
NSString * const kYelpTokenSecret = @"mqtKIxMIR4iBtBPZCmCLEb-Dz3Y";


@interface ViewController ()  <UITableViewDataSource, UITableViewDelegate, FilterViewControllerDelegeate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) YelpClient *client;
@property (strong, nonatomic) NSArray *businesses;
- (void) queryYelpWithQuery:(NSString *)query params:(NSDictionary *) params;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.title = @"Yelp";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStylePlain target:self action:@selector(onFilterButton)];
//    
    [self.tableView registerNib:[UINib nibWithNibName:@"RestaurantCell" bundle:nil] forCellReuseIdentifier:@"RestaurantCell"];
    

    self.tableView.rowHeight = UITableViewAutomaticDimension;

    // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
    self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];
    
    [self queryYelpWithQuery:@"Restaurants" params:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) queryYelpWithQuery:(NSString *)query params:(NSDictionary *) params {
    [self.client searchWithTerm:query params:params success:^(AFHTTPRequestOperation *operation, id response) {
        
        self.businesses = [Business bussinessWithDictionary:response[@"businesses"]];
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"Could not load parameters: %@", params[@"category_filter"]] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
        //NSLog(@"error: %@", [error description]);
    }];
    
}

#pragma remark - Tableview implementation

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RestaurantCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RestaurantCell"];
    //RestaurantCell *cell = [[RestaurantCell alloc] init];
    Business *business = self.businesses[indexPath.row];
    [cell setBusiness:business];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{    
    return self.businesses.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

#pragma remark - Filter view delegate
- (void) filterViewController:(FilterViewController *)filterViewController didChangeFilter:(NSDictionary *)filters {
   
    // fire an network event
    [self queryYelpWithQuery:@"Restaurants" params:filters];
}


#pragma remark - Filter Button

- (void) onFilterButton {
    FilterViewController *fvc = [[FilterViewController alloc] init];
    fvc.delegate = self;
    
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:fvc];
    [self presentViewController:nvc animated:YES completion:nil];
}

@end
