//
//  MessageModel.m
//  seek
//
//  Created by Dan on 2021/3/23.
//  Copyright © 2021 Dan. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel

+ (id)getModelWithDic:(NSDictionary *)dic
{
    //TODO 更改model参数
    MessageModel *model = [[MessageModel alloc]init];
    model.msgId = [dic[@"id"] intValue];
    model.state = [dic[@"state"] intValue];
    model.titleStr = [NSString stringWithFormat:@"%@", dic[@"title"]];
    model.contentStr = [NSString stringWithFormat:@"%@", dic[@"content"]];
    model.createTimeStr = [NSString stringWithFormat:@"%@", dic[@"createTime"]];
    return model;
}

@end
