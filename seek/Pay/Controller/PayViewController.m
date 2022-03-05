//
//  PayViewController.m
//  seek
//
//  Created by Dan on 2021/3/19.
//  Copyright © 2021 Dan. All rights reserved.
//

#import "PayViewController.h"
#import "PayView.h"

@interface PayViewController ()<PayViewDelegate>

@property (nonatomic, strong) PayView *payView;

@end

@implementation PayViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initViews];
}

- (void)initViews
{
    _payView = [[PayView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    _payView.delegate = self;
    _payView.priceStr = @"45元/年";
    _payView.priceDiscountStr = @"仅0.12元/天";
    //TODO 获取登录用户是否支付过
    BOOL isPay = YES;
    _payView.isPay = isPay;
    _payView.timeStr = @"2022-09-21 15:37:09";
    [self.view addSubview:_payView];
}

#pragma mark - 支付按钮代理事件
- (void)gotoPayAction:(UIButton *)sender
{
    
}

@end
