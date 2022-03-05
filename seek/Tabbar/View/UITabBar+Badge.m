//
//  UITabBar+Badge.m
//  seek
//
//  Created by Dan on 2021/3/26.
//  Copyright © 2021 Dan. All rights reserved.
//

#import "UITabBar+Badge.h"

//TODO 实际的UITabbar一共有几项
#define TabbarItemNums 4

@implementation UITabBar (Badge)

#pragma mark - 显示红点
- (void)showBadgeOnItmIndex:(int)index
{
    [self removeBadgeOnItemIndex:index];
    
    UIView *bview = [[UIView alloc]init];
    bview.tag = 888 + index;
    bview.layer.cornerRadius = 5;
    bview.clipsToBounds = YES;
    bview.backgroundColor = [UIColor redColor];
    CGRect tabFram = self.frame;
    
    float percentX = (index + 0.6) / TabbarItemNums;
    CGFloat x = ceilf(percentX * tabFram.size.width);
    CGFloat y = ceilf(0.1 * tabFram.size.height);
    bview.frame = CGRectMake(x, y, 10, 10);
    [self addSubview:bview];
    [self bringSubviewToFront:bview];
}

#pragma mark - 隐藏红点
-(void)hideBadgeOnItemIndex:(int)index
{
    [self removeBadgeOnItemIndex:index];
}

#pragma mark - 移除控件
- (void)removeBadgeOnItemIndex:(int)index
{
    for (UIView *subView in self.subviews)
    {
        if (subView.tag == 888 + index)
        {
            [subView removeFromSuperview];
        }
    }
}

@end
