//
//  Tools.m
//  seek
//
//  Created by Dan on 2021/2/25.
//  Copyright © 2021 Dan. All rights reserved.
//

#import "Tools.h"

@implementation Tools

#pragma mark - 动态获取状态栏的高度
+ (CGFloat)getStatusBarHight
{
    float statusBarHeight = 0;
    if (@available(iOS 13.0, *))
    {
        UIStatusBarManager *statusBarManager = [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager;
        statusBarHeight = statusBarManager.statusBarFrame.size.height;
    }
    else
    {
        statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    }
    return statusBarHeight;
}

#pragma mark - 颜色转换为背景图片
+ (UIImage *)imageWithColor:(UIColor *)color;
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark - 宽度不变，动态设置label的高度
+ (CGFloat)setLabelHeightWithSizeFont:(CGFloat)font textStr:(NSString *)str
{
    CGSize sizeBody = [str boundingRectWithSize:CGSizeMake(kWidth - 40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font],NSFontAttributeName, nil] context:nil].size;

    return sizeBody.height;
}

#pragma mark - 高度不变，动态设置label的宽度
+ (CGFloat)setLabelWidthWithSizeFont:(CGFloat)font str:(NSString *)str lblHeight:(CGFloat)height
{
    CGSize textLimit = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font],NSFontAttributeName, nil] context:nil].size;

    return textLimit.width;
}

#pragma mark - 获取当前UIView所在的UIViewController
+ (UIViewController *)getSuperController:(UIView *)belongView
{
    UIViewController *vc = [[UIViewController alloc]init];
    
    for (UIView* next = [belongView superview]; next; next = next.superview)
    {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            vc = (UIViewController*)nextResponder;
            break;
        }
    }
    return vc;
}

#pragma mark - 判断是否是合法的手机号码
+ (BOOL)checkTel:(NSString *)string
{
    NSString *regex = @"^1[3-9]\\d{9}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:string];
    if (!isMatch)
    {
        return NO;
    }
    return YES;
}

#pragma mark - 判断是否是纯数字
+ (BOOL)checkNumber:(NSString*)number
{
    BOOL res = YES;
    NSCharacterSet *tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length)
    {
        NSString *string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0)
        {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

#pragma mark - 判断是否是放大模式
+ (BOOL)isBigMode
{
    BOOL res = NO;
    CGFloat scale = [[UIScreen mainScreen] scale];
    CGFloat nativeScale = [[UIScreen mainScreen] nativeScale];
    if ((scale == 2.000000 && nativeScale == 2.343750) || (scale == 3.000000 && nativeScale == 2.880000))
    {
        res = YES;
        return res;
    }
    else
    {
        res = NO;
        return res;
    }
    return res;
}

#pragma mark - 判断是否包含表情
+ (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
     
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff)
                                {
                                    if (substring.length > 1)
                                    {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f)
                                        {
                                            returnValue = YES;
                                        }
                                    }
                                }
                                else if (substring.length > 1)
                                {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3)
                                    {
                                        returnValue = YES;
                                    }
                                }
                                else
                                {
                                    if (0x2100 <= hs && hs <= 0x27ff)
                                    {
                                        returnValue = YES;
                                    }
                                    else if (0x2B05 <= hs && hs <= 0x2b07)
                                    {
                                        returnValue = YES;
                                    }
                                    else if (0x2934 <= hs && hs <= 0x2935)
                                    {
                                        returnValue = YES;
                                    }
                                    else if (0x3297 <= hs && hs <= 0x3299)
                                    {
                                        returnValue = YES;
                                    }
                                    else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50)
                                    {
                                        returnValue = YES;
                                    }
                                }
                            }];
    return returnValue;
}

@end
