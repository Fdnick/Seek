//
//  Toast+Category.m
//  seek
//
//  Created by Dan on 2021/2/26.
//  Copyright © 2021 Dan. All rights reserved.
//

#import "Toast+Category.h"

@implementation Toast (Category)

#pragma mark - 实例化Toast
+ (void)alertWithTitleBottom:(NSString *)title
{
    if ([self isNullNSStringWithText:title])
    {
        return ;
    }
    [[Toast sharedInstance] showText:title];
}

#pragma mark - 隐藏Toast
+ (void)hiddenToast
{
    [[Toast sharedInstance] hiddenToast];
}

#pragma mark - 字符非空判断（可以是空格字符串）
+ (BOOL)isNullNSStringWithText:(NSString *)text
{
    if (!text || [text isEqualToString:@""] || 0 == text.length)
    {
        return YES;
    }
    return NO;
}

@end
