//
//  SOSView.m
//  seek
//
//  Created by Dan on 2021/3/26.
//  Copyright © 2021 Dan. All rights reserved.
//

#import "SOSView.h"

@interface SOSView()<UIScrollViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *addSOSBtn;
@property (nonatomic, strong) UIButton *sendSOSBtn;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UIScrollView *containerView;
@property (nonatomic, assign) CGFloat addSOSBtnHeight;

@end

@implementation SOSView

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
    
    NavigationView *naviView = [[NavigationView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kNavigationHeight)];
    naviView.titleLb.text = @"一键求助";
    [self addSubview:naviView];
    
    _containerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(naviView.frame), kWidth, kHeight - CGRectGetHeight(naviView.frame))];
    _containerView.delegate = self;
    _containerView.backgroundColor = kLightGrayColor;
    [self addSubview:_containerView];
    if (@available(iOS 11.0, *))
    {
        _containerView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    UIImage *btnImg = [UIImage imageNamed:@"login_btn"];
    self.addSOSBtnHeight = btnImg.size.height * kWidth / btnImg.size.width - 10;
    _addSOSBtn = [[UIButton alloc]initWithFrame:CGRectMake(40, CGRectGetMinY(_containerView.frame) + 60, kWidth - 40 * 2, self.addSOSBtnHeight)];
    _addSOSBtn.tag = 1;
    _addSOSBtn.titleLabel.font = [UIFont systemFontOfSize:18.0];
    [_addSOSBtn setTitle:@"+ 添加紧急联系人" forState:UIControlStateNormal];
    [_addSOSBtn setTitleColor:KWhiteColor forState:UIControlStateNormal];
    [_addSOSBtn setBackgroundImage:[UIImage imageNamed:@"login_btn"] forState:UIControlStateNormal];
    [_addSOSBtn setBackgroundImage:[UIImage imageNamed:@"login_btn_sel"] forState:UIControlStateHighlighted];
    [_addSOSBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_containerView addSubview:_addSOSBtn];
    
    _messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_addSOSBtn.frame) + 40, self.frame.size.width, 20)];
    _messageLabel.text = @"求助信息将发送给紧急联系人";
    _messageLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    _messageLabel.textColor = kDeepGrayColor;
    _messageLabel.textAlignment = NSTextAlignmentCenter;
    [_containerView addSubview:_messageLabel];
    
    _sendSOSBtn = [[UIButton alloc]initWithFrame:CGRectMake(kWidth / 2 - 60, CGRectGetMaxY(_messageLabel.frame) + 30, 120, 120)];
    _sendSOSBtn.tag = 2;
    _sendSOSBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    _sendSOSBtn.titleLabel.numberOfLines = 0;
    _sendSOSBtn.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    [_sendSOSBtn setTitle:@"立即\n发送" forState:UIControlStateNormal];
    [_sendSOSBtn setTitleEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [_sendSOSBtn setTitleColor:KWhiteColor forState:UIControlStateNormal];
    [_sendSOSBtn setBackgroundImage:[UIImage imageNamed:@"sos_send_btn"] forState:UIControlStateNormal];
    [_sendSOSBtn setBackgroundImage:[UIImage imageNamed:@"sos_send_btn_sel"] forState:UIControlStateHighlighted];
    [_sendSOSBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_containerView addSubview:_sendSOSBtn];
    
    _containerView.contentSize = CGSizeMake(0, CGRectGetMaxY(_sendSOSBtn.frame) + 10);
}

- (void)btnAction:(UIButton *)sender
{
    if (sender.tag == 1 && self.delegate && [self.delegate respondsToSelector:@selector(addSOSAction:)])
    {
        [self.delegate addSOSAction:sender];
    }
    else
    {
        [self.delegate sendSOSAction:sender];
    }
}

- (void)setUserArray:(NSMutableArray *)userArray
{
    for (UIView *bgView in self.containerView.subviews)
    {
        if (bgView.tag >= 111)
        {
            [bgView removeFromSuperview];
        }
    }
    
    CGFloat originX = 20;
    CGFloat lastBgViewY = 0;
    if (userArray.count == 0)
    {
        lastBgViewY = 50;
    }
    for (int i = 0; i < userArray.count; i++)
    {
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(originX, 10 + i * (70 + 15), kWidth - 2 * originX, 70)];
        bgView.tag = 111 + i;
        bgView.layer.cornerRadius = 12;
        bgView.layer.masksToBounds = YES;
        bgView.backgroundColor = kCellGrayColor;
        [_containerView addSubview:bgView];
        
        UILabel *titleLb = [[UILabel alloc]initWithFrame:CGRectMake(originX, 10, CGRectGetWidth(bgView.frame) - originX * 2 - 40, 20)];
        titleLb.backgroundColor = [UIColor clearColor];
        titleLb.textColor = kDeepGrayColor;
        titleLb.font = [UIFont boldSystemFontOfSize:13.0];
        titleLb.text = [NSString stringWithFormat:@"紧急联系人%d", i + 1];
        [bgView addSubview:titleLb];
        
        UILabel *contentLb = [[UILabel alloc]initWithFrame:CGRectMake(originX, CGRectGetMaxY(titleLb.frame) + 5, CGRectGetWidth(bgView.frame) - originX * 2 - 40, 20)];
        contentLb.backgroundColor = [UIColor clearColor];
        contentLb.textColor = kLightBlackColor;
        contentLb.font = [UIFont systemFontOfSize:16.0];
        contentLb.text = userArray[i];
        [bgView addSubview:contentLb];
        
        UIButton *deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetWidth(bgView.frame) - 40, CGRectGetHeight(bgView.frame) / 2 - 10, 20, 20)];
        deleteBtn.tag = i;
        [deleteBtn setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        [deleteBtn setImage:[UIImage imageNamed:@"delete_sel"] forState:UIControlStateHighlighted];
        [deleteBtn addTarget:self action:@selector(deleteAction:)
             forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:deleteBtn];
    }
    
    _addSOSBtn.frame = CGRectMake(40, lastBgViewY + 10 + userArray.count * 90, CGRectGetWidth(_addSOSBtn.frame), self.addSOSBtnHeight);
    _addSOSBtn.hidden = NO;
    //TODO 动态获取上限个数
    if (userArray.count == 3)
    {
        _addSOSBtn.frame = CGRectMake(40, lastBgViewY + 10 + userArray.count * 90, CGRectGetWidth(_addSOSBtn.frame), 0);
        _addSOSBtn.hidden = YES;
    }
    _messageLabel.frame = CGRectMake(0, CGRectGetMaxY(_addSOSBtn.frame) + 60, CGRectGetWidth(_messageLabel.frame), CGRectGetHeight(_messageLabel.frame));
    _sendSOSBtn.frame = CGRectMake(CGRectGetMinX(_sendSOSBtn.frame), CGRectGetMaxY(_messageLabel.frame) + 30, CGRectGetWidth(_sendSOSBtn.frame), CGRectGetHeight(_sendSOSBtn.frame));
    _containerView.contentSize = CGSizeMake(0, CGRectGetMaxY(_sendSOSBtn.frame) + 10);
}

- (void)deleteAction:(UIButton *)sender
{
    [self.delegate deleteAction:sender];
}

@end
