//
//  DefaultInstance.m
//  seek
//
//  Created by Dan on 2021/3/1.
//  Copyright © 2021 Dan. All rights reserved.
//

#import "DefaultInstance.h"

@implementation DefaultInstance

DEF_SINGLETON(DefaultInstance)

+ (void)saveUserTel:(NSString *)userTel
{
    NSUserDefaults *tel = [NSUserDefaults standardUserDefaults];
    [tel setObject:userTel forKey:@"userTel"];
}

+ (NSString *)getUserTel
{
    NSUserDefaults *tel = [NSUserDefaults standardUserDefaults];
    NSString *getTelStr = [tel objectForKey:@"userTel"];
    return getTelStr;
}

+ (void)saveUserNetwork:(NSString *)network
{
    NSUserDefaults *net = [NSUserDefaults standardUserDefaults];
    [net setObject:network forKey:@"network"];
}

+ (NSString *)getUserNetwork
{
    NSUserDefaults *net = [NSUserDefaults standardUserDefaults];
    NSString *getNetworkStr = [net objectForKey:@"network"];
    return getNetworkStr;
}

+ (void)saveUserHead:(NSData *)headData
{
    NSUserDefaults *headImg = [NSUserDefaults standardUserDefaults];
    [headImg setObject:headData forKey:@"headImg"];
}

+ (NSData *)getUserHead
{
    NSUserDefaults *headImg = [NSUserDefaults standardUserDefaults];
    NSData *headData = [headImg objectForKey:@"headImg"];
    return headData;
}

+ (void)clearAllUserDefaultsData
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic = [userDefaults dictionaryRepresentation];
    for (id  key in dic)
    {
        [userDefaults removeObjectForKey:key];
    }
    [userDefaults synchronize];
}

@end
