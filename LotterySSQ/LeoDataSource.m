//
//  LeoDataSource.m
//  LotterySSQ
//
//  Created by Leo.Chen on 13-1-30.
//  Copyright (c) 2013年 Leo.Chen. All rights reserved.
//

#import "LeoDataSource.h"
#import "GDataXMLNode.h"

@implementation LeoDataSource

bool _isUpdateFinish = NO;

-(id) init
{
    self = [super init];
    if (self) {
        NSBundle *bundle = [NSBundle mainBundle];
        _dataPath = [bundle pathForResource:@"data" ofType:@"plist"];
        _dic = [[NSMutableDictionary alloc] initWithContentsOfFile:_dataPath];
        if (_dic == nil) {
            _dic = [[NSMutableDictionary alloc] init];
        }
    }
    return self;
}

-(NSMutableDictionary *) updateData
{
    int maxPage = 1;
    for (int page = 1; page <= maxPage; page++) {
        NSURL * url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://kaijiang.zhcw.com/zhcw/html/ssq/list_%d.html",page]];
        NSData * reponseData = [self request:url];
        
        GDataXMLDocument * xml = [[GDataXMLDocument alloc] initWithHTMLData:reponseData error:nil];
        [self parseData:xml];
        if (_isUpdateFinish) {
            //保存数据到文件
            [_dic writeToFile:_dataPath atomically:YES];
            _isUpdateFinish = NO;
            return _dic;
        }
        
        //从网站取得最新的最大页数
        if (maxPage == 1) {
            GDataXMLElement * table = [[[[[xml rootElement] elementsForName:@"body"] objectAtIndex:0] elementsForName:@"table"] objectAtIndex:0];
            NSArray * trs = [table elementsForName:@"tr"];
            maxPage = [[[[[[[[[trs lastObject] elementsForName:@"td"] objectAtIndex:0]
                            elementsForName:@"p"] objectAtIndex:1]
                          elementsForName:@"strong"] objectAtIndex:0]
                        stringValue] intValue];
        }
    }
    [_dic writeToFile:_dataPath atomically:YES];
    return _dic;
}

-(NSData *) request:(NSURL *)url
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc ] initWithURL:url ];
    [request setHTTPMethod:@"get"];
    [request setHTTPBody:nil];
    [request setTimeoutInterval:10];
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Current-Type"];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    return responseData;
}


-(void) parseData:(GDataXMLDocument *)xml
{
    GDataXMLElement * table = [[[[[xml rootElement] elementsForName:@"body"] objectAtIndex:0] elementsForName:@"table"] objectAtIndex:0];
    NSArray * trs = [table elementsForName:@"tr"];
    
    for (int index = 2; index < trs.count-1; index++) {
        NSArray * tds = [[trs objectAtIndex:index] elementsForName:@"td"];
        NSString * red = @"";
        NSString * blue = @"";
        NSString * key = [[tds objectAtIndex:1] stringValue];
        NSString * date = [[tds objectAtIndex:0] stringValue];
        
        if ([_dic objectForKey:key] == nil) {
            NSArray * ems = [[tds objectAtIndex:2] elementsForName:@"em"];
            for (GDataXMLElement * em in ems) {
                if ([[[em attributeForName:@"class"] stringValue] isEqualToString:@"rr"] ) {
                    red = [red stringByAppendingFormat:@",%@",[em stringValue]];
                } else {
                    blue = [blue stringByAppendingString:[em stringValue]];
                }
            }
            red = [red substringFromIndex:(1)];
        
            NSDictionary * row = [[NSDictionary alloc] initWithObjectsAndKeys:key,@"key",date,@"date",red,@"redBall",blue,@"blueBall", nil];
            [_dic setObject:row forKey:key];
        } else {
            _isUpdateFinish = YES;
            return;
        }
    }

}
@end
