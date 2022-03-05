//
//  DefaultInstance.h
//  seek
//
//  Created by Dan on 2021/3/1.
//  Copyright © 2021 Dan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

NS_ASSUME_NONNULL_BEGIN

@interface DefaultInstance : NSObject

AS_SINGLETON(DefaultInstance);

+ (void)saveUserTel:(NSString *)userTel;
+ (NSString *)getUserTel;

+ (void)saveUserNetwork:(NSString *)network;
+ (NSString *)getUserNetwork;

+ (void)saveUserHead:(NSData *)headData;
+ (NSData *)getUserHead;

+ (void)clearAllUserDefaultsData;

@end

NS_ASSUME_NONNULL_END
