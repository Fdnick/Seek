//
//  FourthTermView.m
//  seek
//
//  Created by Dan on 2021/3/4.
//  Copyright © 2021 Dan. All rights reserved.
//

#import "FourthTermView.h"
#import "FourthCellButton.h"
#import "UILabel+AttributeTextTapAction.h"
#import "WebViewController.h"

@interface FourthTermView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *containerView;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIButton *loginoutBtn;
@property (nonatomic, strong) UIButton *gotoPayBtn;
@property (nonatomic, strong) UIImageView *vipImgView;
@property (nonatomic, strong) UIImageView *headImgView;
@property (nonatomic, strong) UILabel *goodsLb;
@property (nonatomic, strong) UIView *subViewsBgView;
@property (nonatomic, strong) NSArray *cellLbNameArray;
@property (nonatomic, assign) CGFloat space;

@end

@implementation FourthTermView

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
    
    _containerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kWidth, self.frame.size.height - kTabBarHeight)];
    _containerView.delegate = self;
    _containerView.backgroundColor = kLightGrayColor;
    [self addSubview:_containerView];
    if (@available(iOS 11.0, *))
    {
        _containerView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    UIImage *topImg = [UIImage imageNamed:@"my_top_bg"];
    UIImageView *topImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWidth, topImg.size.height * kWidth / topImg.size.width)];
    topImgView.image = topImg;
    topImgView.userInteractionEnabled = YES;
    [_containerView addSubview:topImgView];
    
    self.space = 15;
    NSString *titleString = @"155****6405";
    CGFloat titleWidth = [titleString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:25]}].width;
    UIImage *btnImage = [UIImage imageNamed:@"my_edit"];
    CGFloat imageWidth = btnImage.size.width;
    _editAccountBtn = [[UIButton alloc] initWithFrame:CGRectMake(kWidth / 2 - 150, kStatusBarHeight + 20, 300, 30)];
    _editAccountBtn.tag = 1;
    [_editAccountBtn setImage:[UIImage imageNamed:@"my_edit"] forState:UIControlStateNormal];
    [_editAccountBtn setImage:[UIImage imageNamed:@"my_edit_sel"] forState:UIControlStateHighlighted];
    [_editAccountBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -(imageWidth + self.space * 0.5), 0, (imageWidth + self.space * 0.5))];
    [_editAccountBtn setImageEdgeInsets:UIEdgeInsetsMake(0, (titleWidth + self.space * 0.5), 0, -(titleWidth + self.space * 0.5))];
    [_editAccountBtn setTitle:titleString forState:UIControlStateNormal];
    _editAccountBtn.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
    [_editAccountBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_containerView addSubview:_editAccountBtn];
    
    _loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(kWidth / 2 - 150, kStatusBarHeight + 20, 300, 30)];
    _loginBtn.tag = 2;
    _loginBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
    [_loginBtn setTitle:@"登录解锁黑科技" forState:UIControlStateNormal];
    [_loginBtn setTitleColor:KWhiteColor forState:UIControlStateNormal];
    [_loginBtn setTitleColor:kPlaceholderColor forState:UIControlStateHighlighted];
    [_loginBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_containerView addSubview:_loginBtn];
    
    CGFloat originX = 20;
    UIImage *vipImg = [UIImage imageNamed:@"vip_card"];
    _vipImgView = [[UIImageView alloc] initWithFrame:CGRectMake(originX, CGRectGetMaxY(_editAccountBtn.frame) + 30, kWidth - originX * 2, vipImg.size.height * (kWidth - originX * 2) / vipImg.size.width)];
    _vipImgView.image = vipImg;
    _vipImgView.userInteractionEnabled = YES;
    [_containerView addSubview:_vipImgView];
    
    //TODO 登录用户头像
    _headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 40, 40)];
    _headImgView.image = [UIImage imageNamed:@"head_orange"];
    _headImgView.userInteractionEnabled = YES;
    [_vipImgView addSubview:_headImgView];
    
    //TODO 不是会员，显示文本“开通会员，解锁全部功能”；是会员，显示文本“有效期至2022.03.03”
    _goodsLb = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_headImgView.frame) + 5, 15, CGRectGetWidth(_vipImgView.frame) - CGRectGetMaxX(_headImgView.frame) - 5 - 15, 40)];
    _goodsLb.text = @"开通会员，解锁全部功能";
    _goodsLb.textColor = KWhiteColor;
    _goodsLb.font = [UIFont systemFontOfSize:15.0];
    [_vipImgView addSubview:_goodsLb];
    
    //TODO 不是会员，显示文本“解锁黑科技”；是会员，显示文本“续费”
    _gotoPayBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetWidth(_vipImgView.frame) - 100 - 10, CGRectGetHeight(_vipImgView.frame) - 40, 100, 30)];
    _gotoPayBtn.tag = 3;
    _gotoPayBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [_gotoPayBtn setTitle:@"解锁黑科技" forState:UIControlStateNormal];
    [_gotoPayBtn setTitleColor:kLightBlackColor forState:UIControlStateNormal];
    [_gotoPayBtn setBackgroundImage:[UIImage imageNamed:@"btn_rectangle_orange_bg"] forState:UIControlStateNormal];
    [_gotoPayBtn setBackgroundImage:[UIImage imageNamed:@"btn_rectangle_orange_bg_sel"] forState:UIControlStateHighlighted];
    [_gotoPayBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_vipImgView addSubview:_gotoPayBtn];
    
    _subViewsBgView = [[UIView alloc] initWithFrame:CGRectMake(originX, CGRectGetMaxY(_vipImgView.frame) + originX, kWidth - originX * 2, 200)];
    _subViewsBgView.backgroundColor = kCellGrayColor;
    _subViewsBgView.layer.cornerRadius = 10.0;
    _subViewsBgView.layer.masksToBounds = YES;
    [_containerView addSubview:_subViewsBgView];
    
    //TODO 根据显隐数据返回，显示的添加到数组
    NSArray *cellImgNameArray = @[@"fourth_cell1", @"fourth_cell2", @"fourth_cell3", @"fourth_cell4"];
    _cellLbNameArray = @[@"用户协议", @"隐私政策", @"使用教程", @"注销账户"];
    
    for (int i = 0; i < _cellLbNameArray.count; i++)
    {
        FourthCellButton *cellBtn = [[FourthCellButton alloc] initWithFrame:CGRectMake(0, 0 + i * 60, CGRectGetWidth(_subViewsBgView.frame), 60)];
        cellBtn.cellImgView.image = [UIImage imageNamed:cellImgNameArray[i]];
        cellBtn.cellLb.text = _cellLbNameArray[i];
        cellBtn.tag = i + 4;
        cellBtn.userInteractionEnabled = YES;
        [cellBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_subViewsBgView addSubview:cellBtn];
        
        _subViewsBgView.frame = CGRectMake(originX, CGRectGetMaxY(_vipImgView.frame) + originX, kWidth - originX * 2, (i + 1) * 60);
    }
    
    CGFloat loginoutBtnHeight = (kWidth - (originX + 10) * 2) * 181 / 833;
    _loginoutBtn = [[UIButton alloc]initWithFrame:CGRectMake(originX + 10, kHeight - kTabBarHeight - 50 - loginoutBtnHeight, kWidth - (originX + 10) * 2, loginoutBtnHeight)];
    _loginoutBtn.tag = 8;
    _loginoutBtn.titleLabel.font = [UIFont systemFontOfSize:18.0];
    [_loginoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [_loginoutBtn setTitleColor:KWhiteColor forState:UIControlStateNormal];
    [_loginoutBtn setBackgroundImage:[UIImage imageNamed:@"logout_btn_bg"] forState:UIControlStateNormal];
    [_loginoutBtn setBackgroundImage:[UIImage imageNamed:@"logout_btn_bg_sel"] forState:UIControlStateHighlighted];
    [_loginoutBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_containerView addSubview:_loginoutBtn];
    
    if (IPHONE_X)
    {
        _loginoutBtn.frame = CGRectMake(originX + 10, kHeight - kTabBarHeight - 50 - loginoutBtnHeight, kWidth - (originX + 10) * 2, loginoutBtnHeight);
    }
    else
    {
        _loginoutBtn.frame = CGRectMake(originX + 10, CGRectGetMaxY(_subViewsBgView.frame) + 20, kWidth - (originX + 10) * 2, loginoutBtnHeight);
    }
    
    _containerView.contentSize = CGSizeMake(0, CGRectGetMaxY(_loginoutBtn.frame) + 10);
}

- (void)btnAction:(UIButton *)sender
{
    WebViewController *webView = [[WebViewController alloc]init];
    if (sender.tag == 1 && self.delegate && [self.delegate respondsToSelector:@selector(editAccountAction:)])
    {
        [self.delegate editAccountAction:sender];
    }
    else if (sender.tag == 2 && self.delegate && [self.delegate respondsToSelector:@selector(gotoLoginAction:)])
    {
        [self.delegate gotoLoginAction:sender];
    }
    else if (sender.tag == 3 && self.delegate && [self.delegate respondsToSelector:@selector(gotoPayAction:)])
    {
        [self.delegate gotoPayAction:sender];
    }
    else if (sender.tag == 4)
    {
        webView.titleStr = @"用户协议";
        [[Tools getSuperController:self] presentViewController:webView animated:YES completion:nil];
    }
    else if (sender.tag == 5)
    {
        webView.titleStr = @"隐私政策";
        [[Tools getSuperController:self] presentViewController:webView animated:YES completion:nil];
    }
    else if (sender.tag == 6)
    {
        //TODO 跳转"使用教程"界面
    }
    else
    {
        AlertView *alertView = [[AlertView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
        alertView.titleHidden = YES;
        NSString *path = nil;
        if (sender.tag == 7)
        {
            alertView.contentLbStr = @"7天后自动注销\n注销时解除所有联系人关心状态";
            alertView.sureBtnStr = @"确认注销";
            path = @"";//TODO 赋值
        }
        else
        {
            alertView.contentLbStr = @"退出后你的家人好友将无法获取你的位置，也无法再保护你的位置安全。";
            alertView.sureBtnStr = @"退出登录";
            path = @"";//TODO 赋值
        }
        [alertView sureClickBlock:^(NSString * _Nonnull inputString) {
            [self logoutRequest:path];
        }];
        [[UIApplication sharedApplication].keyWindow addSubview:alertView];
    }
}

#pragma mark - 注销登录或者退出登录请求
- (void)logoutRequest:(NSString *)path
{
    //TODO 添加网络请求
    self.isLogin = NO;
    [DefaultInstance clearAllUserDefaultsData];
}

- (void)setIsLogin:(BOOL)isLogin
{
    CGFloat originX = 20;
    if (isLogin)
    {
        _editAccountBtn.hidden = NO;
        _loginBtn.hidden = YES;
        _vipImgView.hidden = NO;
        _loginoutBtn.hidden = NO;
        _subViewsBgView.frame = CGRectMake(originX, CGRectGetMaxY(_vipImgView.frame) + originX, kWidth - originX * 2, _cellLbNameArray.count * 60);
        //TODO 该值应该是从后台接口请求的，不是本地存储的手机号
        [_editAccountBtn setTitle:[[DefaultInstance getUserTel] stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"] forState:UIControlStateNormal];
    }
    else
    {
        _editAccountBtn.hidden = YES;
        _loginBtn.hidden = NO;
        _vipImgView.hidden = YES;
        _loginoutBtn.hidden = YES;
        _subViewsBgView.frame = CGRectMake(originX, CGRectGetMaxY(_editAccountBtn.frame) + 30, kWidth - originX * 2, (_cellLbNameArray.count - 1) * 60);
    }
}

- (void)setEditAccountStr:(NSString *)editAccountStr
{
    NSString *titleString = editAccountStr;
    CGFloat titleWidth = [titleString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:25]}].width;
    UIImage *btnImage = [UIImage imageNamed:@"my_edit"];
    CGFloat imageWidth = btnImage.size.width;
    [_editAccountBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -(imageWidth + self.space * 0.5), 0, (imageWidth + self.space * 0.5))];
    [_editAccountBtn setImageEdgeInsets:UIEdgeInsetsMake(0, (titleWidth + self.space * 0.5), 0, -(titleWidth + self.space * 0.5))];
    [_editAccountBtn setTitle:titleString forState:UIControlStateNormal];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    scrollView.bounces = (scrollView.contentOffset.y > 100);
}

@end
