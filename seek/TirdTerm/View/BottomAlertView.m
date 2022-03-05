//
//  BottomAlertView.m
//  seek
//
//  Created by Dan on 2021/3/25.
//  Copyright © 2021 Dan. All rights reserved.
//

#import "BottomAlertView.h"

#define BottomAlertViewHight 250.0

@interface BottomAlertView()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation BottomAlertView

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
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, kHeight - BottomAlertViewHight, kWidth, BottomAlertViewHight)];
        _contentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_contentView];
        
        UILabel *titleLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kWidth, 40)];
        titleLb.backgroundColor = [UIColor clearColor];
        titleLb.textColor = kLightBlackColor;
        titleLb.font = [UIFont boldSystemFontOfSize:16.0];
        titleLb.text = @"选择要查看的人";
        titleLb.textAlignment = NSTextAlignmentCenter;
        [_contentView addSubview:titleLb];
        
        UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        closeBtn.frame = CGRectMake(0, CGRectGetHeight(_contentView.frame) - kBottomSafeHeight - 20, kWidth, 20);
        [closeBtn setTitle:@"取消" forState:UIControlStateNormal];
        [closeBtn setTitleColor:KGeenColor forState:UIControlStateNormal];
        [closeBtn setTitleColor:kDeepGrayColor forState:UIControlStateHighlighted];
        [closeBtn addTarget:self action:@selector(disMissView) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:closeBtn];
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLb.frame), kWidth, BottomAlertViewHight - CGRectGetHeight(closeBtn.frame) - kBottomSafeHeight - CGRectGetMaxY(titleLb.frame))];
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_contentView addSubview:_tableView];
        _tableView.separatorInset = UIEdgeInsetsZero;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        
        if (@available(iOS 11.0, *))
        {
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.bindArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = self.bindArray[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.textColor = kDeepGrayColor;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate didSelectRowAction:[self.bindArray objectAtIndex:indexPath.row]];
    [self disMissView];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)showInView:(UIView *)view
{
    if (!view)
    {
        return;
    }
    
    [view addSubview:self];
    [view addSubview:_contentView];
    
    [_contentView setFrame:CGRectMake(0, kHeight, kWidth, BottomAlertViewHight)];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1.0;
        [self->_contentView setFrame:CGRectMake(0, kHeight - BottomAlertViewHight, kWidth, BottomAlertViewHight)];
    } completion:nil];
}

- (void)disMissView
{
    [_contentView setFrame:CGRectMake(0, kHeight - BottomAlertViewHight, kWidth, BottomAlertViewHight)];
    [UIView animateWithDuration:0.3f animations:^{
        self.alpha = 0.0;
        [self->_contentView setFrame:CGRectMake(0, kHeight, kWidth, BottomAlertViewHight)];
    }completion:^(BOOL finished){
        [self removeFromSuperview];
        [self->_contentView removeFromSuperview];
     }];
}

@end
