//
//  PayView.m
//  seek
//
//  Created by Dan on 2021/3/19.
//  Copyright © 2021 Dan. All rights reserved.
//

#import "PayView.h"

@interface PayView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *containerView;
@property (nonatomic, strong) UIImageView *topImgView;
@property (nonatomic, strong) UIImageView *headImgView;
@property (nonatomic, strong) UILabel *telLb;
@property (nonatomic, strong) UILabel *timeLb;
@property (nonatomic, strong) UILabel *priceLb;
@property (nonatomic, strong) UILabel *priceDiscountLb;
@property (nonatomic, strong) UIView *subViewsBgView;
@property (nonatomic, strong) NSArray *cellLbNameArray;

@end

@implementation PayView

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
    
    CGFloat originX = 20;
    
    _containerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    _containerView.delegate = self;
    _containerView.backgroundColor = kLightGrayColor;
    [self addSubview:_containerView];
    if (@available(iOS 11.0, *))
    {
        _containerView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    UIImage *topImg = [UIImage imageNamed:@"pay_top_novip_bg"];
    _topImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWidth, topImg.size.height * kWidth / topImg.size.width)];
    _topImgView.image = topImg;
    _topImgView.userInteractionEnabled = YES;
    [_containerView addSubview:_topImgView];
    
    NavigationView *naviView = [[NavigationView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kNavigationHeight)];
    naviView.titleLb.text = @"会员中心";
    naviView.titleLb.textColor = KWhiteColor;
    [naviView.backBtn setBackgroundImage:[UIImage imageNamed:@"back_left_white"] forState:UIControlStateNormal];
    naviView.backgroundColor = [UIColor clearColor];
    [_topImgView addSubview:naviView];
    
    //TODO 登录用户头像
    _headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(_topImgView.frame) - 100, 40, 40)];
    _headImgView.image = [UIImage imageNamed:@"head_orange"];
    [_topImgView addSubview:_headImgView];
    
    _telLb = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_headImgView.frame) + 5, CGRectGetMinY(_headImgView.frame) + 10, CGRectGetWidth(_topImgView.frame) - CGRectGetMaxX(_headImgView.frame) - 5 - 30, 20)];
    _telLb.text = [DefaultInstance getUserTel];
    _telLb.textColor = KWhiteColor;
    _telLb.font = [UIFont systemFontOfSize:19.0];
    [_topImgView addSubview:_telLb];
    
    _timeLb = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_headImgView.frame) + 5, CGRectGetMaxY(_telLb.frame) + 5, CGRectGetWidth(_topImgView.frame) - CGRectGetMaxX(_headImgView.frame) - 5 - 30, 20)];
    _timeLb.textColor = KWhiteColor;
    _timeLb.font = [UIFont systemFontOfSize:13.0];
    _timeLb.hidden = YES;
    [_topImgView addSubview:_timeLb];
    
    if ([Tools isBigMode])
    {
        _headImgView.frame = CGRectMake(30, CGRectGetMaxY(_topImgView.frame) - 90, 38, 38);
        _telLb.font = [UIFont systemFontOfSize:16.0];
        _timeLb.font = [UIFont systemFontOfSize:12.0];
    }
    
    UIImage *lineImg = [UIImage imageNamed:@"pay_lb_bg"];
    CGFloat lineHeight = 40;
    UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(originX, CGRectGetMaxY(_topImgView.frame) + originX, lineImg.size.width * lineHeight / lineImg.size.height, lineHeight)];
    lineImageView.image = lineImg;
    [_containerView addSubview:lineImageView];
    
    UILabel *lineLb = [[UILabel alloc] initWithFrame:CGRectMake(17, 0, CGRectGetWidth(lineImageView.frame) - 30, CGRectGetHeight(lineImageView.frame))];
    lineLb.text = @"会员尊享特权";
    lineLb.textColor = KWhiteColor;
    lineLb.font = [UIFont boldSystemFontOfSize:20.0];
    [lineImageView addSubview:lineLb];
    
    _subViewsBgView = [[UIView alloc] initWithFrame:CGRectMake(originX, CGRectGetMaxY(lineImageView.frame) + originX, kWidth - originX * 2, 200)];
    _subViewsBgView.backgroundColor = kCellGrayColor;
    _subViewsBgView.layer.cornerRadius = 10.0;
    _subViewsBgView.layer.masksToBounds = YES;
    [_containerView addSubview:_subViewsBgView];
    
    //TODO 根据显隐数据返回，显示的添加到数组
    _cellLbNameArray = @[@"无限好友", @"出入提醒", @"实时位置", @"一键求救", @"历史轨迹", @"专属客服"];
    NSArray *cellImgNameArray = @[@"pay_friend_bg", @"pay_warning_bg", @"pay_location_bg", @"pay_sos_bg", @"pay_history_bg", @"pay_customer_bg"];
    //TODO 动态获取一行有几个赋值给rowCount就可以，下面的布局已经计算好动态均匀分布
    int rowCount = 4;
    CGFloat imageWidth = CGRectGetWidth(_subViewsBgView.frame) / (rowCount + 1.5);
    CGFloat spaceX = (CGRectGetWidth(_subViewsBgView.frame) - imageWidth * rowCount) / (rowCount + 1);
    CGFloat cellLbHeight = 30;
    for (int i = 0; i < _cellLbNameArray.count; i++)
    {
        CGFloat spaceY = originX + (imageWidth + cellLbHeight + originX) * (i / rowCount);
        UIImageView *cellImgView = [[UIImageView alloc] initWithFrame:CGRectMake(spaceX + (i % rowCount) * (imageWidth + spaceX), spaceY, imageWidth, imageWidth)];
        cellImgView.image = [UIImage imageNamed:cellImgNameArray[i]];
        [_subViewsBgView addSubview:cellImgView];
        
        UILabel *cellLb = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(cellImgView.frame), CGRectGetMaxY(cellImgView.frame), CGRectGetWidth(cellImgView.frame), cellLbHeight)];
        cellLb.textColor = KGeenColor;
        cellLb.text = _cellLbNameArray[i];
        cellLb.font = [UIFont systemFontOfSize:13.0];
        cellLb.textAlignment = NSTextAlignmentCenter;
        [_subViewsBgView addSubview:cellLb];
        if ([Tools isBigMode])
        {
            cellLb.font = [UIFont systemFontOfSize:12.0];
        }
        
        _subViewsBgView.frame = CGRectMake(originX, CGRectGetMaxY(lineImageView.frame) + originX, kWidth - originX * 2, CGRectGetMaxY(cellLb.frame) + 10);
    }
    
    UIImage *priceBgImg = [UIImage imageNamed:@"price_bg"];
    UIImageView *priceBgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(originX, CGRectGetMaxY(_subViewsBgView.frame) + 30, kWidth - originX * 2, priceBgImg.size.height * (kWidth - originX * 2) / priceBgImg.size.width)];
    priceBgImgView.image = priceBgImg;
    [_containerView addSubview:priceBgImgView];
    
    UIImage *discountImg = [UIImage imageNamed:@"pay_benefit_orange_bg"];
    CGFloat disountImgHeight = 30;
    UIImageView *discountImgView = [[UIImageView alloc] initWithFrame:CGRectMake(originX, CGRectGetMinY(priceBgImgView.frame) - disountImgHeight / 2, discountImg.size.width * disountImgHeight / discountImg.size.height, disountImgHeight)];
    discountImgView.image = discountImg;
    [_containerView addSubview:discountImgView];
    
    UILabel *discountLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(discountImgView.frame), CGRectGetHeight(discountImgView.frame))];
    discountLb.text = @"限时优惠";
    discountLb.textColor = KWhiteColor;
    discountLb.font = [UIFont systemFontOfSize:15.0];
    discountLb.textAlignment = NSTextAlignmentCenter;
    [discountImgView addSubview:discountLb];
    
    _priceLb = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(priceBgImgView.frame) / 2 - 25, CGRectGetWidth(priceBgImgView.frame), 30)];
    _priceLb.textColor = KWhiteColor;
    _priceLb.font = [UIFont boldSystemFontOfSize:22.0];
    _priceLb.textAlignment = NSTextAlignmentCenter;
    [priceBgImgView addSubview:_priceLb];
    
    _priceDiscountLb = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_priceLb.frame), CGRectGetWidth(priceBgImgView.frame), 20)];
    _priceDiscountLb.textColor = KWhiteColor;
    _priceDiscountLb.font = [UIFont systemFontOfSize:12.0];
    _priceDiscountLb.textAlignment = NSTextAlignmentCenter;
    [priceBgImgView addSubview:_priceDiscountLb];
    
    UILabel *importLb = [[UILabel alloc] initWithFrame:CGRectMake(originX, CGRectGetMaxY(priceBgImgView.frame) + 10, CGRectGetWidth(discountImgView.frame), CGRectGetHeight(discountImgView.frame))];
    importLb.text = @"温馨提示";
    importLb.textColor = kLightBlackColor;
    importLb.font = [UIFont systemFontOfSize:18.0];
    [_containerView addSubview:importLb];
    
    //TODO 动态获取文本
    UILabel *importContentLb = [[UILabel alloc] initWithFrame:CGRectMake(originX, CGRectGetMaxY(importLb.frame) + 10, kWidth - originX * 2, 20)];
    importContentLb.text = @"1.会员服务为计时制。每次购买后会增加相应服务时间并累计；到期后将停止服务，请注意时间。\n2.未成年人请在监护者的陪同下进行购买。";
    CGFloat importContentLbHeight = [Tools setLabelHeightWithSizeFont:15.0 textStr:importContentLb.text];
    importContentLb.frame = CGRectMake(originX, CGRectGetMaxY(importLb.frame) + 10, kWidth - originX * 2, importContentLbHeight);
    importContentLb.textColor = kDeepGrayColor;
    importContentLb.font = [UIFont systemFontOfSize:15.0];
    importContentLb.numberOfLines = 0;
    [_containerView addSubview:importContentLb];
    
    CGFloat loginoutBtnHeight = (kWidth - (originX + 10) * 2) * 181 / 833;
    UIButton *payBtn = [[UIButton alloc]initWithFrame:CGRectMake(originX + 10, CGRectGetMaxY(importContentLb.frame) + 30, kWidth - (originX + 10) * 2, loginoutBtnHeight)];
    payBtn.titleLabel.font = [UIFont systemFontOfSize:18.0];
    [payBtn setTitle:@"去支付" forState:UIControlStateNormal];
    [payBtn setTitleColor:KWhiteColor forState:UIControlStateNormal];
    [payBtn setBackgroundImage:[UIImage imageNamed:@"logout_btn_bg"] forState:UIControlStateNormal];
    [payBtn setBackgroundImage:[UIImage imageNamed:@"logout_btn_bg_sel"] forState:UIControlStateHighlighted];
    [payBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_containerView addSubview:payBtn];
    
    _containerView.contentSize = CGSizeMake(0, CGRectGetMaxY(payBtn.frame) + 10);
}

- (void)btnAction:(UIButton *)sender
{
    [self.delegate gotoPayAction:sender];
}

- (void)setIsPay:(BOOL)isPay
{
    if (isPay)
    {
        _topImgView.image = [UIImage imageNamed:@"pay_top_vip_bg"];
        _timeLb.hidden = NO;
    }
    else
    {
        _topImgView.image = [UIImage imageNamed:@"pay_top_novip_bg"];
        _timeLb.hidden = YES;
    }
}

- (void)setTimeStr:(NSString *)timeStr
{
    _timeLb.text = [NSString stringWithFormat:@"到期时间：%@", timeStr];
}

- (void)setPriceStr:(NSString *)priceStr
{
    _priceLb.text = priceStr;
}

- (void)setPriceDiscountStr:(NSString *)priceDiscountStr
{
    _priceDiscountLb.text = priceDiscountStr;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    scrollView.bounces = (scrollView.contentOffset.y > 100);
}

@end
