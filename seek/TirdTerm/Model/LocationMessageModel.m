//
//  LocationMessageModel.m
//  seek
//
//  Created by Dan on 2021/3/24.
//  Copyright © 2021 Dan. All rights reserved.
//

#import "LocationMessageModel.h"

@implementation LocationMessageModel

+ (id)getModelWithDic:(NSDictionary *)dic
{
    //TODO 更改model参数
    LocationMessageModel *model = [[LocationMessageModel alloc]init];
    model.msgId = [dic[@"id"] intValue];
    model.state = [dic[@"state"] intValue];
    model.titleStr = [NSString stringWithFormat:@"%@", dic[@"title"]];
    model.contentStr = [NSString stringWithFormat:@"%@", dic[@"content"]];
    model.telStr = [NSString stringWithFormat:@"%@", dic[@"tel"]];
    return model;
}

@end
