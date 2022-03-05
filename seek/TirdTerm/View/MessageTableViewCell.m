//
//  MessageTableViewCell.m
//  seek
//
//  Created by Dan on 2021/3/23.
//  Copyright © 2021 Dan. All rights reserved.
//

#import "MessageTableViewCell.h"

@interface MessageTableViewCell ()

@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UILabel *timeLb;
@property (nonatomic, strong) UILabel *contentLb;
@property (nonatomic, strong) UIButton *dealMsgBtn;

@end

@implementation MessageTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = [NSString stringWithFormat:@"cell-ld%ld", (long)indexPath.row];
    MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell)
    {
        cell = [[MessageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(originX, 10, kWidth - 2 * originX, 100)];
    bgView.layer.cornerRadius = 12;
    bgView.layer.masksToBounds = YES;
    bgView.backgroundColor = kCellGrayColor;
    [self.contentView addSubview:bgView];
    
    UIImageView *msgImgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetHeight(bgView.frame) / 2 - 25, 50, 50)];
    msgImgView.image = [UIImage imageNamed:@"receive_msg_circle"];
    [bgView addSubview:msgImgView];
    
    _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(msgImgView.frame) + 10, 20, 70, 20)];
    _titleLb.backgroundColor = [UIColor clearColor];
    _titleLb.textColor = kLightBlackColor;
    _titleLb.font = [UIFont boldSystemFontOfSize:16.0];
    [bgView addSubview:_titleLb];
    
    _timeLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_titleLb.frame) + 5, 20, CGRectGetWidth(bgView.frame) - CGRectGetMaxX(_titleLb.frame) - 10 - originX, 20)];
    _timeLb.backgroundColor = [UIColor clearColor];
    _timeLb.textColor = kDeepGrayColor;
    _timeLb.font = [UIFont systemFontOfSize:13.0];
    [bgView addSubview:_timeLb];
    
    _contentLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(msgImgView.frame) + 10, CGRectGetMaxY(_titleLb.frame) + 5, CGRectGetMaxX(_titleLb.frame) + 30, 35)];
    _contentLb.backgroundColor = [UIColor clearColor];
    _contentLb.textColor = kDeepGrayColor;
    _contentLb.font = [UIFont systemFontOfSize:13.0];
    _contentLb.numberOfLines = 0;
    [bgView addSubview:_contentLb];
    
    _dealMsgBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetWidth(bgView.frame) - 80 - 10, CGRectGetHeight(bgView.frame) / 2 - 20, 80, 40)];
    _dealMsgBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    _dealMsgBtn.layer.cornerRadius = 20;
    _dealMsgBtn.layer.masksToBounds = YES;
    [_dealMsgBtn setTitleColor:KGeenColor forState:UIControlStateNormal];
    [_dealMsgBtn setTitleColor:kDeepGrayColor forState:UIControlStateHighlighted];
    [_dealMsgBtn addTarget:self action:@selector(btnAction:)
         forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:_dealMsgBtn];
    
    if ([Tools isBigMode])
    {
        bgView.frame = CGRectMake(10, 10, kWidth - 20, 100);
        msgImgView.frame = CGRectMake(10, CGRectGetHeight(bgView.frame) / 2 - 20, 40, 40);
        _titleLb.frame = CGRectMake(CGRectGetMaxX(msgImgView.frame) + 10, 20, 70, 20);
        _timeLb.frame = CGRectMake(CGRectGetMaxX(_titleLb.frame) + 5, 20, CGRectGetWidth(bgView.frame) - CGRectGetMaxX(_titleLb.frame) - 20, 20);
        _contentLb.frame = CGRectMake(CGRectGetMaxX(msgImgView.frame) + 10, CGRectGetMaxY(_titleLb.frame) + 5, CGRectGetMaxX(_titleLb.frame) + 40, 35);
        _dealMsgBtn.frame = CGRectMake(CGRectGetWidth(bgView.frame) - 60 - 10, CGRectGetHeight(bgView.frame) / 2 - 15, 60, 30);
        _dealMsgBtn.layer.cornerRadius = 15;
        _dealMsgBtn.layer.masksToBounds = YES;
    }
}

- (void)setModel:(MessageModel *)model
{
    _model = model;
    self.state = model.state;
    //TODO 看“好友申请”、“系统通知”这些标题是后台直接返回的，还是只返回状态自行设置文本。如果只返回状态，则根据状态值进行赋值
    _titleLb.text = model.titleStr;
    //TODO 转换时间
    _timeLb.text = model.createTimeStr;
    _contentLb.text = model.contentStr;
}

- (void)btnAction:(UIButton *)sender
{
    [self.delegate dealMsgAction:self sender:sender];
}

- (void)setState:(int)state
{
    //TODO 根据后台返回的实际情况修改
    //0：主动绑定好友获取的状态->不显示按钮 1：被绑定并且已同意申请->显示“已接受”按钮 2：被绑定并且未处理->显示“接受”按钮 3：绑定用户围栏位置消息->显示“查看详情”按钮
    if (state == 0)
    {
        _dealMsgBtn.hidden = YES;
    }
    else
    {
        _dealMsgBtn.hidden = NO;
        if (state == 1)
        {
            [_dealMsgBtn setTitle:@"已接受" forState:UIControlStateNormal];
            _dealMsgBtn.enabled = NO;
        }
        else if (state == 2)
        {
            [_dealMsgBtn setTitle:@"接受" forState:UIControlStateNormal];
            [_dealMsgBtn setTitleColor:KWhiteColor forState:UIControlStateNormal];
            [_dealMsgBtn setBackgroundImage:[UIImage imageNamed:@"login_btn"] forState:UIControlStateNormal];
            [_dealMsgBtn setBackgroundImage:[UIImage imageNamed:@"login_btn_sel"] forState:UIControlStateHighlighted];
        }
        else if (state == 3)
        {
            [_dealMsgBtn setTitle:@"查看详情" forState:UIControlStateNormal];
        }
    }
}

@end
