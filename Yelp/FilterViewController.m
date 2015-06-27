//
//  FilterViewController.m
//  Yelp
//
//  Created by Jhih-Yan Lin on 6/21/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import "FilterViewController.h"
#import "FilterCell.h"
#import "SwitchCell.h"

@interface FilterViewController ()<UITableViewDataSource, UITableViewDelegate, SwitchCellDelete, UISearchBarDelegate, UIPickerViewDataSource, UIPickerViewDataSource>

@property (nonatomic, readonly) NSDictionary *filters;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *categories;
@property (strong, nonatomic) NSMutableSet *selectedCategories;
@property (strong, nonatomic) UISearchBar *searchBar;


@end

@implementation FilterViewController

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        self.selectedCategories = [NSMutableSet set];
        
        [self initCategories];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(onCancelButton)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStylePlain target:self action:@selector(onFilterButton)];
    
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.showsSearchResultsButton = YES;
    self.searchBar.delegate = self;
    
    self.navigationItem.titleView = self.searchBar;
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"SwitchCell" bundle:nil] forCellReuseIdentifier:@"SwitchCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"PickerCell" bundle:nil] forCellReuseIdentifier:@"PickerCell"];
//    [self.tableView registerNib:[UINib nibWithNibName:@"FilterCell" bundle:nil] forCellReuseIdentifier:@"FilterCell"];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button event

- (NSDictionary *) filters {
    NSMutableDictionary *filters = [NSMutableDictionary dictionary];
    if (self.selectedCategories.count > 0) {
        NSMutableArray *names = [NSMutableArray array];
        for (NSDictionary *category in self.selectedCategories) {
            [names addObject: category[@"code"]];
        }
        NSString *filterString = [names componentsJoinedByString:@","];
        
        [filters setObject:filterString forKey:@"category_filter"];
    }
    return filters;
}

- (void) onCancelButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) onFilterButton {

    [self.delegate filterViewController:self didChangeFilter:self.filters];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Tableview

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    }
    if (section == 3) {
        return self.categories.count;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        SwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PickerCell"];
        //cell.titleLabel.text = @"Offering a deal";
        //cell.on = NO;
        //cell.delegate = self;
        return cell;
    } else if (indexPath.section == 1) {
        return nil;
    } else if (indexPath.section == 2) {
        return nil;
    }
    
    SwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SwitchCell"];
    cell.titleLabel.text = self.categories[indexPath.row][@"name"];
    cell.on = [self.selectedCategories containsObject: self.categories[indexPath.row]];
    cell.delegate = self;
    return cell;
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 4;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"   ";
        case 1:
            return @"Distance";
        case 2:
            return @"Sort By";
        case 3:
            return @"Category";
            
        default:
            return @"TEST";
    }
}



#pragma mark - Filter 

-(void) switchCell:(FilterCell *)cell didUpdateValue:(BOOL) value {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSDictionary *dict = self.categories[indexPath.row];
    if (value) {
        [self.selectedCategories addObject: dict];
    } else {
        [self.selectedCategories removeObject: dict];
    }
}

#pragma mark - Search Bar

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    if ((self.searchBar.text != nil) && ([self.searchBar.text isEqualToString:@""] == NO)) {
        NSDictionary *searchKey = @{@"category_filter": [self.searchBar.text lowercaseString]};

        [self.delegate filterViewController:self didChangeFilter:searchKey];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}

#pragma mark - Picker View

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 1;
}

#pragma mark - init
- (void) initCategories {
    self.categories = @[@{@"name" : @"Afghan", @"code": @"afghani" },
                        @{@"name" : @"African", @"code": @"african" },
                        @{@"name" : @"American, New", @"code": @"newamerican" },
                        @{@"name" : @"American, Traditional", @"code": @"tradamerican" },
                        @{@"name" : @"Arabian", @"code": @"arabian" },
                        @{@"name" : @"Argentine", @"code": @"argentine" },
                        @{@"name" : @"Armenian", @"code": @"armenian" },
                        @{@"name" : @"Asian Fusion", @"code": @"asianfusion" },
                        @{@"name" : @"Asturian", @"code": @"asturian" },
                        @{@"name" : @"Australian", @"code": @"australian" },
                        @{@"name" : @"Austrian", @"code": @"austrian" },
                        @{@"name" : @"Baguettes", @"code": @"baguettes" },
                        @{@"name" : @"Bangladeshi", @"code": @"bangladeshi" },
                        @{@"name" : @"Barbeque", @"code": @"bbq" },
                        @{@"name" : @"Basque", @"code": @"basque" },
                        @{@"name" : @"Bavarian", @"code": @"bavarian" },
                        @{@"name" : @"Beer Garden", @"code": @"beergarden" },
                        @{@"name" : @"Beer Hall", @"code": @"beerhall" },
                        @{@"name" : @"Beisl", @"code": @"beisl" }];

}


@end
