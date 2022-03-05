//
//  Toast.m
//  seek
//
//  Created by Dan on 2021/2/26.
//  Copyright © 2021 Dan. All rights reserved.
//

#import "Toast.h"
#import <QuartzCore/QuartzCore.h>

#define FontSize ([UIFont systemFontOfSize:16.0])
static CGFloat sizeSpace = 40.0;
static CGFloat sizelabel = 8.0;
#define maxlabel (self.backView.frame.size.width - 20.0 * 2)

@interface Toast ()

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *textLb;
@property (nonatomic, strong) UIButton *button;

@end

@implementation Toast

DEF_SINGLETON(Toast)

- (void)showText:(NSString *)text
{
    if (text && 0 < text.length)
    {
        [self hiddenToast];

        [self.backView addSubview:self.textlabel];
        self.textlabel.text = text;

        NSDictionary *attributes = @{NSFontAttributeName: FontSize};
        CGRect rect = [text boundingRectWithSize:CGSizeMake(maxlabel, maxlabel)
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:attributes
                                                  context:nil];
        CGFloat labelX = (self.backView.frame.size.width - rect.size.width) / 2;
        CGFloat labelY = 20.0 + 44.0 + sizeSpace;
        CGFloat labelWidth = rect.size.width + sizelabel;
        CGFloat labelHeight = rect.size.height + sizelabel;
        labelY = (self.backView.frame.size.height - labelHeight - sizeSpace - kTabBarHeight);
        self.textLb.frame = CGRectMake(labelX, labelY, labelWidth, labelHeight);
        [self.backView addSubview:self.button];
        self.button.frame = self.textlabel.frame;
        
        if ([self respondsToSelector:@selector(hiddenToast)])
        {
            [self performSelector:@selector(hiddenToast) withObject:nil afterDelay:1.6];
        }
    }
}

#pragma mark - 隐藏
- (void)hiddenToast
{
    if (self.textlabel.superview)
    {
        [self.textlabel removeFromSuperview];
    }
    
    if (self.button.superview)
    {
        [self.button removeFromSuperview];
    }
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

#pragma mark - getter

- (UIView *)backView
{
    if (_backView == nil)
    {
        _backView = [UIApplication sharedApplication].delegate.window;
    }
    return _backView;
}

- (UILabel *)textlabel
{
    if (!_textLb)
    {
        _textLb = [[UILabel alloc] init];
        _textLb.font = FontSize;
        _textLb.textColor = [UIColor whiteColor];
        _textLb.textAlignment = NSTextAlignmentCenter;
        _textLb.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.8];
        _textLb.layer.cornerRadius = 5.0;
        _textLb.layer.masksToBounds = YES;
        _textLb.numberOfLines = 0;
        _textLb.shadowColor = [UIColor darkGrayColor];
        _textLb.shadowOffset = CGSizeMake(1.0, 1.0);
        _textLb.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    }
    return _textLb;
}

- (UIButton *)button
{
    if (!_button)
    {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.backgroundColor = [UIColor clearColor];
        [_button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _button;
}

#pragma mark - 响应事件
- (void)buttonClick
{
    [self hiddenToast];
}

@end
