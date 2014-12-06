//
//  TimeZonesViewController.m
//  SampleAppiOS1
//
//  Created by WAYNE SMALL on 12/3/14.
//  Copyright (c) 2014 WES FUN GAMES. All rights reserved.
//

#import "TimeZonesViewController.h"

NSInteger static selectedRow = -1;

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface TimeZonesViewController () <UITableViewDataSource, UITableViewDelegate> {
    NSArray *timeZonesData;
    NSTimeZone *selectedTimeZone;
}

@end

@implementation TimeZonesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    timeZonesData = [NSTimeZone knownTimeZoneNames];
    
    UITableView *theTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    theTableView.delegate = self;
    theTableView.dataSource = self;
    theTableView.backgroundView = nil;
    [self.view addSubview:theTableView];
    
    if (selectedRow == -1) {
        selectedRow = [timeZonesData indexOfObject:@"America/New_York"];
    }
    
    [theTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:selectedRow inSection:0]
                              animated:NO
                        scrollPosition:UITableViewScrollPositionMiddle];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.delegate setTheTimeZone:selectedTimeZone];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [timeZonesData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        UIView *bgColorView = [[UIView alloc] init];
        bgColorView.backgroundColor = UIColorFromRGB(0x87cefD);
        [cell setSelectedBackgroundView:bgColorView];
    }
    
    cell.textLabel.text = timeZonesData[indexPath.row];    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    selectedRow = indexPath.row;
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    selectedTimeZone = [NSTimeZone timeZoneWithName:cell.textLabel.text];
}

- (void)dealloc {
    self.delegate = nil;
}

@end
