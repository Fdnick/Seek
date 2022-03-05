//
//  MessageModel.h
//  seek
//
//  Created by Dan on 2021/3/23.
//  Copyright © 2021 Dan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MessageModel : NSObject

@property (nonatomic, assign) int msgId;
@property (nonatomic, assign) int state;
@property (nonatomic, copy) NSString *createTimeStr;
@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic, copy) NSString *contentStr;

+ (id)getModelWithDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
