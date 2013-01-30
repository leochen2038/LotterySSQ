//
//  LeoRamdonCount.h
//  LotterySSQ
//
//  统计红球出现的次数，然后去掉出现次数最多的6个号码，随机选择选取其他号码，如果所选的号码没有大号（28－33）则去掉选的6个号码中出现次数最多的一个，然后从28－33中随机选择一个。
//  统计蓝球出现的次数，然后去掉出现次数最多的1个号码，及上期出现的号码。随机选择其他号码。
//  Created by Leo.Chen on 13-1-30.
//  Copyright (c) 2013年 Leo.Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LeoRamdonCount : NSObject
{
    NSDictionary * _dic;
}

-(id) initWithDictionary:(NSDictionary *)dic;

-(NSArray *) RamdonRedBall;
-(NSString *) RandomBlueBall;

@end
