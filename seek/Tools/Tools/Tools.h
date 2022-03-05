//
//  Tools.h
//  seek
//
//  Created by Dan on 2021/2/25.
//  Copyright © 2021 Dan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Tools : NSObject

+ (CGFloat)getStatusBarHight;

+ (UIImage *)imageWithColor:(UIColor *)color;

+ (CGFloat)setLabelHeightWithSizeFont:(CGFloat)font textStr:(NSString *)str;

+ (CGFloat)setLabelWidthWithSizeFont:(CGFloat)font str:(NSString *)str lblHeight:(CGFloat)height;

+ (UIViewController *)getSuperController:(UIView *)belongView;

+ (BOOL)checkTel:(NSString *)string;

+ (BOOL)checkNumber:(NSString*)number;

+ (BOOL)isBigMode;

+ (BOOL)stringContainsEmoji:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
