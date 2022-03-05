//
//  ThirdTermView.m
//  seek
//
//  Created by Dan on 2021/3/2.
//  Copyright © 2021 Dan. All rights reserved.
//

#import "ThirdTermView.h"

@interface ThirdTermView ()

@property (nonatomic, strong) UIView *redView;

@end

@implementation ThirdTermView

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
    
    UIImage *topImg = [UIImage imageNamed:@"third_top_bg"];
    UIImageView *topImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWidth, topImg.size.height * kWidth / topImg.size.width)];
    topImgView.image = topImg;
    topImgView.userInteractionEnabled = YES;
    [self addSubview:topImgView];
    
    CGFloat originX = 50;
    CGFloat cellSpacing = 10;
    if ([Tools isBigMode])
    {
        originX = 25;
        cellSpacing = 5;
    }
    UIImage *customerImg = [UIImage imageNamed:@"third_customer"];
    UIImageView *customerImgView = [[UIImageView alloc] initWithFrame:CGRectMake(originX, CGRectGetMaxY(topImgView.frame) - customerImg.size.height * 90 / customerImg.size.width, 90, customerImg.size.height * 90 / customerImg.size.width)];
    customerImgView.image = customerImg;
    customerImgView.userInteractionEnabled = YES;
    [self addSubview:customerImgView];
    
    UIImage *popImg = [UIImage imageNamed:@"third_top_pop"];
    UIImageView *popImgView = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth - 170 - CGRectGetMinX(customerImgView.frame), CGRectGetMinY(customerImgView.frame) + 10, 170, popImg.size.height * 170 / popImg.size.width)];
    popImgView.image = popImg;
    popImgView.userInteractionEnabled = YES;
    [self addSubview:popImgView];
    
    UILabel *welcomeLb = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, CGRectGetWidth(popImgView.frame) - 25, CGRectGetHeight(popImgView.frame))];
    welcomeLb.text = @"欢迎留下您的宝贵意见\n客服为您提供帮助";
    welcomeLb.textColor = KWhiteColor;
    welcomeLb.font = [UIFont boldSystemFontOfSize:13.0];
    welcomeLb.numberOfLines = 0;
    [popImgView addSubview:welcomeLb];
    
    //TODO 根据显隐数据返回，显示的添加到数组
    NSArray *cellImgNameArray = @[@"third_cell1", @"third_cell2", @"third_cell3", @"third_cell4"];
    NSArray *cellLbNameArray = @[@"在线咨询", @"在线反馈", @"消息", @"到达/离开地点提醒消息"];
    
    for (int i = 0; i < cellLbNameArray.count; i++)
    {
        ThirdCellButton *cellBtn = [[ThirdCellButton alloc] initWithFrame:CGRectMake(cellSpacing, CGRectGetMaxY(topImgView.frame) + cellSpacing + (80 * i + cellSpacing), kWidth - 20, 80)];
        cellBtn.cellImgView.image = [UIImage imageNamed:cellImgNameArray[i]];
        cellBtn.cellLb.text = cellLbNameArray[i];
        cellBtn.tag = i + 1;
        cellBtn.userInteractionEnabled = YES;
        [cellBtn addTarget:self action:@selector(cellBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cellBtn];
        
        if (i == 2)
        {
            _redView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetWidth(cellBtn.cellLb.frame), CGRectGetHeight(cellBtn.cellLb.frame) / 2 - 5, 10, 10)];
            _redView.layer.cornerRadius = 5;
            _redView.clipsToBounds = YES;
            _redView.backgroundColor = [UIColor redColor];
            [cellBtn.cellLb addSubview:_redView];
            self.isHideBadge = YES;
        }
    }
    
    UIButton *sosBtn = [[UIButton alloc]initWithFrame:CGRectMake(kWidth - 60 - 10, kHeight - kTabBarHeight - 60 - 10, 60, 60)];
    [sosBtn setBackgroundImage:[UIImage imageNamed:@"sos"] forState:UIControlStateNormal];
    [sosBtn setBackgroundImage:[UIImage imageNamed:@"sos_sel"] forState:UIControlStateHighlighted];
    [sosBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:sosBtn];
    
    if ([Tools isBigMode])
    {
        sosBtn.frame = CGRectMake(kWidth - 60 - 10, kHeight - kTabBarHeight - 60 - 5, 60, 60);
    }
}

- (void)cellBtnAction:(ThirdCellButton *)sender
{
    [self.delegate cellAction:sender];
}

- (void)btnAction:(UIButton *)sender
{
    [self.delegate sosAction:sender];
}

- (void)setIsHideBadge:(BOOL)isHideBadge
{
    _redView.hidden = isHideBadge;
}

@end
