//
//  LeoAppDelegate.m
//  LotterySSQ
//
//  Created by Leo.Chen on 13-1-26.
//  Copyright (c) 2013年 Leo.Chen. All rights reserved.
//

#import "LeoAppDelegate.h"
#import "GDataXMLNode.h"

@implementation LeoAppDelegate

-(id) init
{
    self = [super init];
    if (self) {
        _dataSource = [[LeoDataSource alloc] init];
    }
    return self;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
}

- (IBAction)random:(id)sender
{
    LeoRamdonCount * ramdon = [[LeoRamdonCount alloc] initWithDictionary:_dataSource.dic];
    NSArray * redNumbers = [ramdon RamdonRedBall];
    NSString * blueNumber = [ramdon RandomBlueBall];
    [_blueLb setObjectValue:blueNumber];
    [_redLb setObjectValue:[redNumbers componentsJoinedByString:@","]];
}


- (IBAction)upData:(id)sender
{
    NSMutableDictionary * dic = [_dataSource updateData];
    
    //取得最新的期号及开奖日期
    NSArray * keys = [dic keysSortedByValueUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        if ([[obj1 objectForKey:@"key"] intValue] < [[obj2 objectForKey:@"key"] intValue]) {
            return NSOrderedAscending;
        } else {
            return NSOrderedDescending;
        }
        return NSOrderedSame;
    }];
    [_newly setObjectValue:keys.lastObject];
    [_newlyDate setObjectValue:[[dic objectForKey:keys.lastObject] objectForKey:@"date"]];
    [_totalCount setObjectValue:[NSString stringWithFormat:@"%ld",(unsigned long)dic.count]];
}

-(void) awakeFromNib
{
    NSMutableDictionary * dic = _dataSource.dic;
    
    //取得最新的期号及开奖日期
    NSArray * keys = [dic keysSortedByValueUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        if ([[obj1 objectForKey:@"key"] intValue] < [[obj2 objectForKey:@"key"] intValue]) {
            return NSOrderedAscending;
        } else {
            return NSOrderedDescending;
        }
        return NSOrderedSame;
    }];
    [_newly setObjectValue:keys.lastObject];
    [_newlyDate setObjectValue:[[dic objectForKey:keys.lastObject] objectForKey:@"date"]];
    [_totalCount setObjectValue:[NSString stringWithFormat:@"%ld",(unsigned long)dic.count]];

}
@end
