//
//  NavigationView.m
//  seek
//
//  Created by Dan on 2021/3/5.
//  Copyright © 2021 Dan. All rights reserved.
//

#import "NavigationView.h"

@implementation NavigationView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self initViews];
    }
    return self;
}

- (void)initViews
{
    self.backgroundColor = kLightGrayColor;
    
    _titleLb = [[UILabel alloc] initWithFrame:CGRectMake(35, kStatusBarHeight, kWidth - 70, self.frame.size.height - kStatusBarHeight)];
    _titleLb.textAlignment = NSTextAlignmentCenter;
    _titleLb.font = [UIFont systemFontOfSize:18.0];
    _titleLb.adjustsFontSizeToFitWidth = YES;
    _titleLb.textColor = kLightBlackColor;
    _titleLb.backgroundColor = [UIColor clearColor];
    [self addSubview:_titleLb];
    
    _backBtn = [[UIButton alloc]initWithFrame:CGRectMake(25, (self.frame.size.height - kStatusBarHeight) / 2 - 8 + kStatusBarHeight, 10, 16)];
    [_backBtn setBackgroundImage:[UIImage imageNamed:@"back_left"] forState:UIControlStateNormal];
    [_backBtn setBackgroundImage:[UIImage imageNamed:@"back_left"] forState:UIControlStateHighlighted];
    [_backBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_backBtn];
}

- (void)btnAction:(UIButton *)sender
{
    [[Tools getSuperController:self] dismissViewControllerAnimated:YES completion:nil];
}

@end
