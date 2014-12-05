//
//  TimeZonesViewController.h
//  SampleAppiOS1
//
//  Created by WAYNE SMALL on 12/3/14.
//  Copyright (c) 2014 WES FUN GAMES. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TimeZoneDelegate;

@interface TimeZonesViewController : UIViewController

@property (weak) id<TimeZoneDelegate> delegate;

@end

@protocol TimeZoneDelegate <NSObject>

@required

- (void)setTheTimeZone:(NSTimeZone *)timezone;

@end
