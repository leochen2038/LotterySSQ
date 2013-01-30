//
//  LeoDataSource.h
//  LotterySSQ
//
//  Created by Leo.Chen on 13-1-30.
//  Copyright (c) 2013年 Leo.Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LeoDataSource : NSObject
{
    NSString * _dataPath;
}

@property (readonly) NSMutableDictionary * dic;

-(NSMutableDictionary *) updateData;

@end
