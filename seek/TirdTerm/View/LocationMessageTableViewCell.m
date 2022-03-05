//
//  LocationMessageTableViewCell.m
//  seek
//
//  Created by Dan on 2021/3/24.
//  Copyright © 2021 Dan. All rights reserved.
//

#import "LocationMessageTableViewCell.h"

@interface LocationMessageTableViewCell ()

@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UILabel *contentLb;
@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, strong) UISwitch *msgSwitch;

@end

@implementation LocationMessageTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = [NSString stringWithFormat:@"cell-ld%ld", (long)indexPath.row];
    LocationMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell)
    {
        cell = [[LocationMessageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor = kLightGrayColor;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self initLayout];
    }
    return self;
}

- (void)initLayout
{
    CGFloat originX = 20;
    
    if ([Tools isBigMode])
    {
        originX = 10;
    }
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(originX, 10, kWidth - 2 * originX, 100)];
    bgView.layer.cornerRadius = 12;
    bgView.layer.masksToBounds = YES;
    bgView.backgroundColor = kCellGrayColor;
    [self.contentView addSubview:bgView];
    
    _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(originX, 20, 80, 30)];
    _titleLb.backgroundColor = [UIColor clearColor];
    _titleLb.textColor = kLightBlackColor;
    _titleLb.font = [UIFont boldSystemFontOfSize:16.0];
    [bgView addSubview:_titleLb];
    
    _contentLb = [[UILabel alloc]initWithFrame:CGRectMake(originX, CGRectGetMaxY(_titleLb.frame) + 10, CGRectGetWidth(bgView.frame) - originX * 2, 20)];
    _contentLb.backgroundColor = [UIColor clearColor];
    _contentLb.textColor = kDeepGrayColor;
    _contentLb.font = [UIFont systemFontOfSize:13.0];
    _contentLb.numberOfLines = 0;
    [bgView addSubview:_contentLb];
    
    _deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_titleLb.frame) + 10, 20, 50, 30)];
    _deleteBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    _deleteBtn.layer.cornerRadius = 6.0;
    _deleteBtn.layer.masksToBounds = YES;
    _deleteBtn.layer.borderColor = KGeenColor.CGColor;
    _deleteBtn.layer.borderWidth = 1.0f;
    [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [_deleteBtn setTitleColor:KGeenColor forState:UIControlStateNormal];
    [_deleteBtn setTitleColor:kDeepGrayColor forState:UIControlStateHighlighted];
    [_deleteBtn addTarget:self action:@selector(btnAction:)
         forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:_deleteBtn];
    
    _msgSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(CGRectGetWidth(bgView.frame) - 70, CGRectGetHeight(bgView.frame) / 2 - 20, 80, 40)];
    [_msgSwitch setOnTintColor:KGeenColor];
    [_msgSwitch setThumbTintColor:KWhiteColor];
    [_msgSwitch addTarget:self action:@selector(switchChange:) forControlEvents:UIControlEventValueChanged];
    [bgView addSubview:_msgSwitch];
}

- (void)setModel:(LocationMessageModel *)model
{
    _model = model;
    _titleLb.text = model.titleStr;
    _titleLb.frame = CGRectMake(CGRectGetMinX(_titleLb.frame), CGRectGetMinY(_titleLb.frame), [Tools setLabelWidthWithSizeFont:16.0 str:model.titleStr lblHeight:CGRectGetHeight(_titleLb.frame)] + 5, CGRectGetHeight(_titleLb.frame));
    _deleteBtn.frame = CGRectMake(CGRectGetMaxX(_titleLb.frame) + 10, CGRectGetMinY(_deleteBtn.frame), CGRectGetWidth(_deleteBtn.frame), CGRectGetHeight(_deleteBtn.frame));
    _contentLb.text = model.contentStr;
    if (model.state == 0)
    {
        _msgSwitch.on = NO;
    }
    else
    {
        _msgSwitch.on = YES;
    }
}

- (void)btnAction:(UIButton *)sender
{
    [self.delegate deleteAction:self sender:sender];
}

- (void)switchChange:(UISwitch *)sender
{
    [self.delegate msgSwitchChange:self sender:sender];
}

@end
