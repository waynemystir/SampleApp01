//
//  ViewController.m
//  SampleAppiOS1
//
//  Created by WAYNE SMALL on 12/3/14.
//  Copyright (c) 2014 WES FUN GAMES. All rights reserved.
//

#import "ViewController.h"
#import "TimeZonesViewController.h"

@interface ViewController () <TimeZoneDelegate> {
    NSTimer *timer;
    NSTimeZone *theTimeZone;
    UIPopoverController *poc;
}

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeZoneLabel;

@end

@implementation ViewController

- (void)loadView {
    [super loadView];
    
    [self setTheTimeZone:[NSTimeZone systemTimeZone]];
    [self updateTimerLabel];
    [self startTimer];
    
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    UIBarButtonItem *tzButton = [[UIBarButtonItem alloc] initWithTitle:@"Change Timezone" style:UIBarButtonItemStyleBordered target:self action:@selector(showTimeZones:)];
    self.navigationItem.leftBarButtonItem = tzButton;
}

- (NSString *)deviceTime {
    NSDate* gmtDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:theTimeZone ? : [NSTimeZone systemTimeZone]];
    [formatter setDateFormat:@"MMM-dd-yyyy hh:mm:ss a"];
    return [formatter stringFromDate:gmtDate];
}

- (void)startTimer {
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0f/1.0f
                                             target:self
                                           selector:@selector(updateTimerLabel)
                                           userInfo:[NSDate date]
                                            repeats:YES];
}

- (void)updateTimerLabel {
    _timeLabel.text = [self deviceTime];
}

- (void)setTheTimeZone:(NSTimeZone *)timezone {
    theTimeZone = timezone;
    _timeZoneLabel.text = timezone.name;
}

- (void)showTimeZones:(id)sender {
    TimeZonesViewController *tzvc = [TimeZonesViewController new];
    tzvc.delegate = self;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        poc = [[UIPopoverController alloc] initWithContentViewController:tzvc];
        poc.popoverContentSize = CGSizeMake(300, self.view.frame.size.height);
        [poc presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    } else {
        [self.navigationController pushViewController:tzvc animated:YES];
    }
}

@end
