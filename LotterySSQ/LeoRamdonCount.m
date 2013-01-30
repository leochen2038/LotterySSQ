//
//  LeoRamdonCount.m
//  LotterySSQ
//
//  Created by Leo.Chen on 13-1-30.
//  Copyright (c) 2013年 Leo.Chen. All rights reserved.
//

#import "LeoRamdonCount.h"

@implementation LeoRamdonCount

-(id) initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        _dic = dic;
    }
    return self;
}

-(NSArray *) RamdonRedBall
{
    //step 统计红球号码出现的次数
    NSMutableDictionary * sortRedBalls = [[NSMutableDictionary alloc] init];
    
    for (NSString * key in _dic) {
        NSArray * redBalls = [[[_dic objectForKey:key] objectForKey:@"redBall"] componentsSeparatedByString:@","];
        for (NSString * number in redBalls) {
            if ( [sortRedBalls objectForKey:number] == nil) {
                [sortRedBalls setObject: [NSNumber numberWithInt:1] forKey:number];
            } else {
                 int times = [[sortRedBalls objectForKey:number] intValue];
                [sortRedBalls setObject:[NSNumber numberWithInt:times++] forKey:number];
            }
        }
    }
    
    //按出现次数进行排序
    NSMutableArray * sortRedBallsNumbers =  [[NSMutableArray alloc] initWithArray:[sortRedBalls keysSortedByValueUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        if ([obj1 intValue] > [obj2 intValue]) {
            return NSOrderedAscending;
        } else {
            return NSOrderedDescending;
        }
        return NSOrderedSame;
    }]];
    
    //删除出现次数最多的6个号码
    [sortRedBallsNumbers removeObjectsInRange:NSMakeRange(0,5)];
    
    //step 随机取出6个号码
    int max = 6;
    NSMutableArray * choseNumbers = [[NSMutableArray alloc] init];
    for (int i = 0; i < max ; i++) {
        int index = arc4random() % sortRedBallsNumbers.count;
        [choseNumbers setObject:[sortRedBallsNumbers objectAtIndex:index] atIndexedSubscript:choseNumbers.count];
    }
    return choseNumbers;
}

-(NSString *) RandomBlueBall
{
    NSString * number;
    //step 统计蓝球号码出现的次数
    NSMutableDictionary * sortBlueBalls = [[NSMutableDictionary alloc] init];
    
    for (NSString * key in _dic) {
        NSString * number = [[_dic objectForKey:key] objectForKey:@"blueBall"];
        if ([sortBlueBalls objectForKey:number] == nil) {
            [sortBlueBalls setObject:[NSNumber numberWithInt:1] forKey:number];
        } else {
            int times = [[sortBlueBalls objectForKey:number] intValue];
            [sortBlueBalls setObject:[NSNumber numberWithInt:times++] forKey:number];
        }
    }
    NSMutableArray * sortBlueBellNumbers = [NSMutableArray arrayWithArray:[sortBlueBalls keysSortedByValueUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        if ([obj1 intValue] > [obj2 intValue]) {
            return NSOrderedAscending;
        } else {
            return NSOrderedDescending;
        }
        return NSOrderedSame;
    }]];
    [sortBlueBellNumbers removeObjectAtIndex:0];

    NSArray * keys = [_dic keysSortedByValueUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        if ([[obj1 objectForKey:@"key"] intValue] < [[obj2 objectForKey:@"key"] intValue]) {
            return NSOrderedAscending;
        } else {
            return NSOrderedDescending;
        }
        return NSOrderedSame;
    }];
    NSString * lastNumber = [[_dic objectForKey:keys.lastObject] objectForKey:@"blueBall"];

    while (YES) {
        int index = arc4random() % sortBlueBellNumbers.count;
        if ( [[sortBlueBellNumbers objectAtIndex:index] isEqual:lastNumber]) {
            continue;
        } else {
            number = [sortBlueBellNumbers objectAtIndex:index];
            break;
        }
    }
    return number;
}

@end
