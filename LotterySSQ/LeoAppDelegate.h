//
//  LeoAppDelegate.h
//  LotterySSQ
//
//  Created by Leo.Chen on 13-1-26.
//  Copyright (c) 2013年 Leo.Chen. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LeoDataSource.h"
#import "LeoRamdonCount.h"

@interface LeoAppDelegate : NSObject <NSApplicationDelegate>
{
    LeoDataSource * _dataSource;
    LeoRamdonCount * _ramdon;
}

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSTextField *blueLb;
@property (assign) IBOutlet NSTextField *redLb;
@property (assign) IBOutlet NSTextField *totalCount;
@property (assign) IBOutlet NSTextField *newly;
@property (assign) IBOutlet NSTextField *newlyDate;

- (IBAction)random:(id)sender;
- (IBAction)upData:(id)sender;

@end
