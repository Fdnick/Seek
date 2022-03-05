//
//  GotoPayAlertView.m
//  seek
//
//  Created by Dan on 2021/3/30.
//  Copyright © 2021 Dan. All rights reserved.
//

#import "GotoPayAlertView.h"

@interface GotoPayAlertView()

@property (nonatomic, strong) UIView *contentView;

@end

@implementation GotoPayAlertView

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
    self.frame = CGRectMake(0, 0, kWidth, kHeight);
    
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disMissView)]];
    
    if (_contentView == nil)
    {
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(30, 170, kWidth - 60, kHeight / 2)];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.layer.cornerRadius = 12.0;
        _contentView.layer.masksToBounds = YES;
        [self addSubview:_contentView];
        
        UIImage *topImg = [UIImage imageNamed:@"pop_map"];
        UIImageView *topImgView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(_contentView.frame) / 4, 20, CGRectGetWidth(_contentView.frame) / 2, topImg.size.height * (CGRectGetWidth(_contentView.frame) / 2) / topImg.size.width)];
        topImgView.image = topImg;
        topImgView.userInteractionEnabled = YES;
        [_contentView addSubview:topImgView];
        
        UILabel *titleLb = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(topImgView.frame) + 20, CGRectGetWidth(_contentView.frame), 30)];
        titleLb.backgroundColor = [UIColor clearColor];
        titleLb.textColor = kOrangeColor;
        titleLb.font = [UIFont boldSystemFontOfSize:20.0];
        titleLb.text = @"解锁会员将得到以下服务";
        titleLb.textAlignment = NSTextAlignmentCenter;
        [_contentView addSubview:titleLb];
        
        //TODO 动态修改
        NSArray *importArray = @[@"一键查看对方实时位置与历史轨迹", @"一键求助，脱离紧急或危机情况", @"出入特定区域提醒"];
        CGFloat lbHeight = CGRectGetMaxY(titleLb.frame) + 20;
        for (int i = 0; i < importArray.count; i++)
        {
            UILabel *importLb = [[UILabel alloc] initWithFrame:CGRectMake(40, CGRectGetMaxY(titleLb.frame) + 10 + i * 30, CGRectGetWidth(_contentView.frame) - 50, 20)];
            importLb.text = importArray[i];
            importLb.font = [UIFont systemFontOfSize:15.0];
            importLb.textColor = kDeepGrayColor;
            [_contentView addSubview:importLb];
            
            UIView *orangeView = [[UIView alloc]initWithFrame:CGRectMake(20, CGRectGetMinY(importLb.frame) + 5, 10, 10)];
            orangeView.layer.cornerRadius = 5;
            orangeView.clipsToBounds = YES;
            orangeView.backgroundColor = kOrangeColor;
            [_contentView addSubview:orangeView];
            
            lbHeight = CGRectGetMaxY(importLb.frame) + 20;
        }

        UIImage *btnImg = [UIImage imageNamed:@"goto_btn"];
        CGFloat payBtnHeight = btnImg.size.height * kWidth / btnImg.size.width - 10;
        UIButton *payBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, lbHeight, CGRectGetWidth(_contentView.frame) - 40, payBtnHeight)];
        [payBtn setTitle:@"立即解锁" forState:UIControlStateNormal];
        [payBtn setTitleColor:kLightBlackColor forState:UIControlStateNormal];
        [payBtn setBackgroundImage:[UIImage imageNamed:@"goto_btn"] forState:UIControlStateNormal];
        [payBtn setBackgroundImage:[UIImage imageNamed:@"goto_btn_sel"] forState:UIControlStateHighlighted];
        [payBtn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:payBtn];
        
        _contentView.frame = CGRectMake(30, kHeight / 2 - (CGRectGetMaxY(payBtn.frame) + 20) / 2 - 10, kWidth - 60, CGRectGetMaxY(payBtn.frame) + 20);
    }
}

- (void)showInView:(UIView *)view
{
    if (!view)
    {
        return;
    }
    
    [view addSubview:self];
    [view addSubview:_contentView];
}

- (void)disMissView
{
    [self removeFromSuperview];
    [_contentView removeFromSuperview];
}

- (void)btnAction
{
    [self.delegate gotoPayAction];
    [self disMissView];
}

@end
