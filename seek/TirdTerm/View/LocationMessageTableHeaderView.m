//
//  LocationMessageTableHeaderView.m
//  seek
//
//  Created by Dan on 2021/3/24.
//  Copyright © 2021 Dan. All rights reserved.
//

#import "LocationMessageTableHeaderView.h"

@interface LocationMessageTableHeaderView ()

@property (nonatomic, strong) UIButton *chooseBtn;

@end

@implementation LocationMessageTableHeaderView

+ (instancetype)headerViewWithTableView:(UITableView *)tableView
{
    static NSString *headerID = @"header";
    LocationMessageTableHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerID];
    if (headerView == nil)
    {
        headerView = [[LocationMessageTableHeaderView alloc]initWithReuseIdentifier:headerID];
    }
    return headerView;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier])
    {
         [self initLayout];
    }
    return self;
}

- (void)initLayout
{
    self.contentView.backgroundColor = kLightGrayColor;
    
    CGFloat space = 5;
    NSString *titleString = @"18888888888";
    CGFloat titleWidth = [titleString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}].width;
    UIImage *btnImage = [UIImage imageNamed:@"back_bottom"];
    CGFloat imageWidth = btnImage.size.width;
    CGFloat originX = 20;
    
    if ([Tools isBigMode])
    {
        originX = 10;
    }
    _chooseBtn = [[UIButton alloc] initWithFrame:CGRectMake(originX, 40, 140, 20)];
    [_chooseBtn setImage:[UIImage imageNamed:@"back_bottom"] forState:UIControlStateNormal];
    [_chooseBtn setImage:[UIImage imageNamed:@"back_bottom_sel"] forState:UIControlStateHighlighted];
    [_chooseBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -(imageWidth + space * 0.5), 0, (imageWidth + space * 0.5))];
    [_chooseBtn setImageEdgeInsets:UIEdgeInsetsMake(2, (titleWidth + space * 0.5), 2, -(titleWidth + space * 0.5))];
    _chooseBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [_chooseBtn setTitleColor:kLightBlackColor forState:UIControlStateNormal];
    [_chooseBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_chooseBtn];
}

- (void)btnAction:(UIButton *)sender
{
    [self.delegate chooseAction:sender];
}

- (void)setHeadStr:(NSString *)headStr
{
    [_chooseBtn setTitle:headStr forState:UIControlStateNormal];
}

@end
