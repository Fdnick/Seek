//
//  LoginView.m
//  seek
//
//  Created by Dan on 2021/2/25.
//  Copyright © 2021 Dan. All rights reserved.
//

#import "LoginView.h"
#import "UILabel+AttributeTextTapAction.h"
#import "WebViewController.h"

@implementation LoginView

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
    
    CGFloat originX = 50;
    
    CGFloat originY = 150;
    if ([Tools isBigMode])
    {
        originY = 60;
    }
    UILabel *welcomeLb = [[UILabel alloc] initWithFrame:CGRectMake(0, originY, kWidth, 60)];
    welcomeLb.text = @"欢迎登录";
    welcomeLb.textAlignment = NSTextAlignmentCenter;
    welcomeLb.textColor = kLightBlackColor;
    welcomeLb.font = [UIFont boldSystemFontOfSize:35.0];
    [self addSubview:welcomeLb];
    
    UILabel *telLb = [[UILabel alloc] initWithFrame:CGRectMake(originX, CGRectGetMaxY(welcomeLb.frame) + 50, kWidth - originX * 2, 20)];
    telLb.text = @"手机号";
    telLb.textColor = kDeepGrayColor;
    telLb.font = [UIFont systemFontOfSize:16.0];
    [self addSubview:telLb];
    
    _telTextField = [[UITextField alloc] initWithFrame:CGRectMake(originX, CGRectGetMaxY(telLb.frame) + 5, kWidth - originX * 2, 30)];
    _telTextField.tag = 1001;
    _telTextField.delegate = self;
    _telTextField.placeholder = @"请输入手机号";
    _telTextField.keyboardType = UIKeyboardTypeNumberPad;
    _telTextField.font = [UIFont systemFontOfSize:19.0];
    _telTextField.textColor = kLightBlackColor;
    _telTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入手机号" attributes:@{NSForegroundColorAttributeName:kPlaceholderColor}];
    [self addSubview:_telTextField];
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(originX, CGRectGetMaxY(_telTextField.frame) + 10, kWidth - originX * 2, 1)];
    lineView1.backgroundColor = kPlaceholderColor;
    [self addSubview:lineView1];
    
    UILabel *passLb = [[UILabel alloc] initWithFrame:CGRectMake(originX, CGRectGetMaxY(lineView1.frame) + 30, kWidth - originX * 2, 20)];
    passLb.text = @"验证码";
    passLb.textColor = kDeepGrayColor;
    passLb.font = [UIFont systemFontOfSize:16.0];
    [self addSubview:passLb];
    
    _passTextField = [[UITextField alloc] initWithFrame:CGRectMake(originX, CGRectGetMaxY(passLb.frame) + 5, kWidth - originX * 2, 30)];
    _passTextField.tag = 1002;
    _passTextField.delegate = self;
    _passTextField.placeholder = @"请输入验证码";
    _passTextField.keyboardType = UIKeyboardTypeNumberPad;
    _passTextField.font = [UIFont systemFontOfSize:19.0];
    _passTextField.textColor = kLightBlackColor;
    _passTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入验证码" attributes:@{NSForegroundColorAttributeName:kPlaceholderColor}];
    [self addSubview:_passTextField];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(originX, CGRectGetMaxY(_passTextField.frame) + 10, kWidth - originX * 2, 1)];
    lineView2.backgroundColor = kPlaceholderColor;
    [self addSubview:lineView2];
    
    _getCodeBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lineView2.frame) - 100, CGRectGetMinY(_passTextField.frame), 100, 30)];
    _getCodeBtn.tag = 1;
    _getCodeBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_getCodeBtn setTitleColor:KGeenColor forState:UIControlStateNormal];
    [_getCodeBtn setTitleColor:kLightBlackColor forState:UIControlStateHighlighted];
    [_getCodeBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_getCodeBtn];
    
    _timeLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    _timeLb.text = @"等待60秒";
    _timeLb.font = [UIFont systemFontOfSize:16.0];
    _timeLb.backgroundColor = [UIColor clearColor];
    _timeLb.textAlignment = NSTextAlignmentCenter;
    _timeLb.hidden = YES;
    _timeLb.textColor = KGeenColor;
    [_getCodeBtn addSubview:_timeLb];
    
    UIImage *btnImg = [UIImage imageNamed:@"login_btn"];
    CGFloat loginBtnHeight = btnImg.size.height * (kWidth - (originX - 10) * 2) / btnImg.size.width;
    _loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(originX - 10, CGRectGetMaxY(lineView2.frame) + 30, kWidth - (originX - 10) * 2, loginBtnHeight)];
    _loginBtn.tag = 2;
    _loginBtn.titleLabel.font = [UIFont systemFontOfSize:18.0];
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_loginBtn setTitleColor:KWhiteColor forState:UIControlStateNormal];
    [_loginBtn setBackgroundImage:[UIImage imageNamed:@"login_btn"] forState:UIControlStateNormal];
    [_loginBtn setBackgroundImage:[UIImage imageNamed:@"login_btn_sel"] forState:UIControlStateHighlighted];
    [_loginBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_loginBtn];
    
    _protocolBtn = [[UIButton alloc] initWithFrame:CGRectMake(originX - 15, CGRectGetMaxY(_loginBtn.frame) + 30, kWidth - (originX - 15) * 2, 60)];
    [_protocolBtn setImage:[UIImage imageNamed:@"login_disagree"] forState:UIControlStateNormal];
    [_protocolBtn setImage:[UIImage imageNamed:@"login_agree"] forState:UIControlStateSelected];
    [_protocolBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 25, 0)];
    [_protocolBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    NSString *showText = @"我已经阅读并同意《用户协议》和《隐私政策》";
    NSAttributedString *showAttString = [self getAttributeWith:@[@"《用户协议》",@"《隐私政策》"] string:showText orginFont:15 orginColor:kDeepGrayColor attributeFont:15 attributeColor:KGeenColor];
    [_protocolBtn setAttributedTitle:showAttString forState:UIControlStateNormal];
    _protocolBtn.titleLabel.numberOfLines = 0;
    [self addSubview:_protocolBtn];
    [_protocolBtn addTarget:self action:@selector(onButtonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    __weak typeof(self) weakSelf = self;
    [_protocolBtn.titleLabel addAttributeTapActionWithStrings:@[@"《用户协议》",@"《隐私政策》"] tapClicked:^(UILabel *label, NSString *string, NSRange range, NSInteger index) {
        typeof(weakSelf) __strong strongSelf = weakSelf;
        if ([string isEqualToString:@"我已经阅读并同意"])
        {
            strongSelf.protocolBtn.selected = !strongSelf.protocolBtn.selected;
        }
        else
        {
            WebViewController *webView = [[WebViewController alloc]init];
            if ([string isEqualToString:@"《用户协议》"])
            {
                webView.titleStr = @"用户协议";
                [[Tools getSuperController:strongSelf] presentViewController:webView animated:YES completion:nil];
            }
            else
            {
                webView.titleStr = @"隐私政策";
                [[Tools getSuperController:strongSelf] presentViewController:webView animated:YES completion:nil];
            }
        }
    }];
    
    UIImage *img = [UIImage imageNamed:@"login_agree_pop"];
    _popImgView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(_protocolBtn.frame) - 8, CGRectGetMinY(_protocolBtn.frame) - 25, img.size.width * 30 / img.size.height, 30)];
    _popImgView.image = img;
    _popImgView.hidden = NO;
    _popImgView.userInteractionEnabled = YES;
    [self addSubview:_popImgView];
    
    UILabel *importLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_popImgView.frame), 20)];
    importLb.text = @"请先同意";
    importLb.font = [UIFont systemFontOfSize:11.0];
    importLb.backgroundColor = [UIColor clearColor];
    importLb.textAlignment = NSTextAlignmentCenter;
    importLb.textColor = KWhiteColor;
    [_popImgView addSubview:importLb];
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(25, kStatusBarHeight + 20, 10, 16)];
    backBtn.tag = 3;
    [backBtn setBackgroundImage:[UIImage imageNamed:@"back_left"] forState:UIControlStateNormal];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"back_left"] forState:UIControlStateHighlighted];
    [backBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backBtn];
}

#pragma mark - 同意隐私政策和用户协议按钮事件
- (void)onButtonClickAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
    _popImgView.hidden = !_popImgView.hidden;
}

#pragma mark - 获取验证码和登录按钮事件
- (void)btnAction:(UIButton *)sender
{
    if (sender.tag == 1 && self.delegate && [self.delegate respondsToSelector:@selector(getCodeAction:)])
    {
        if (_telTextField.text.length == 0)
        {
            [Toast alertWithTitleBottom:@"手机号不能为空"];
            return;
        }
        if (![Tools checkTel:_telTextField.text])
        {
            [Toast alertWithTitleBottom:@"请输入正确的手机号"];
            return;
        }
        [self.delegate getCodeAction:sender];
    }
    else if (sender.tag == 2 && self.delegate && [self.delegate respondsToSelector:@selector(loginAction:)])
    {
        if (_telTextField.text.length == 0 || _passTextField.text.length == 0)
        {
            [Toast alertWithTitleBottom:@"请输入手机号和验证码"];
            return;
        }
        if (![Tools checkTel:_telTextField.text])
        {
            [Toast alertWithTitleBottom:@"请输入正确的手机号"];
            return;
        }
        if (!_popImgView.hidden)
        {
            [Toast alertWithTitleBottom:@"请先同意"];
            return;
        }
        [self.delegate loginAction:sender];
    }
    else
    {
        [self.delegate backAction:sender];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_telTextField resignFirstResponder];
    [_passTextField resignFirstResponder];
}

#pragma mark - UITextField代理方法 - Start
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self becomeFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag == 1001)
    {
        NSInteger strLength = _telTextField.text.length - range.length + string.length;
        if (strLength > 11 || strLength < 0)
            return NO;
        
        NSString *text = nil;
        if (string.length > 0)
        {
            text = [NSString stringWithFormat:@"%@%@",_telTextField.text,string];
        }
        else
        {
            text = [_telTextField.text substringToIndex:range.location];
        }
    }
    
    if (textField.tag == 1002)
    {
        NSInteger strLength = _passTextField.text.length - range.length + string.length;
        if (strLength > 6 || strLength < 0)
            return NO;
    }
    
    return [Tools checkNumber:string];
}
#pragma mark - UITextField代理方法 - End

- (NSAttributedString *)getAttributeWith:(id)sender
                                  string:(NSString *)string
                               orginFont:(CGFloat)orginFont
                              orginColor:(UIColor *)orginColor
                           attributeFont:(CGFloat)attributeFont
                          attributeColor:(UIColor *)attributeColor
{
    __block  NSMutableAttributedString *totalStr = [[NSMutableAttributedString alloc] initWithString:string];
    [totalStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:orginFont] range:NSMakeRange(0, string.length)];
    [totalStr addAttribute:NSForegroundColorAttributeName value:orginColor range:NSMakeRange(0, string.length)];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5.0f]; //设置行间距
    [paragraphStyle setLineBreakMode:NSLineBreakByTruncatingTail];
    [paragraphStyle setAlignment:NSTextAlignmentLeft];
    [paragraphStyle setLineBreakMode:NSLineBreakByCharWrapping];
    [totalStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [totalStr length])];
    
    if ([sender isKindOfClass:[NSArray class]])
    {
        __block NSString *oringinStr = string;
        __weak typeof(self) weakSelf = self;
        
        [sender enumerateObjectsUsingBlock:^(NSString *  _Nonnull str, NSUInteger idx, BOOL * _Nonnull stop) {
            NSRange range = [oringinStr rangeOfString:str];
            [totalStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:attributeFont] range:range];
            [totalStr addAttribute:NSForegroundColorAttributeName value:attributeColor range:range];
            oringinStr = [oringinStr stringByReplacingCharactersInRange:range withString:[weakSelf getStringWithRange:range]];
        }];
        
    }
    else if ([sender isKindOfClass:[NSString class]])
    {
        NSRange range = [string rangeOfString:sender];
        [totalStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:attributeFont] range:range];
        [totalStr addAttribute:NSForegroundColorAttributeName value:attributeColor range:range];
    }
    return totalStr;
}

- (NSString *)getStringWithRange:(NSRange)range
{
    NSMutableString *string = [NSMutableString string];
    for (int i = 0; i < range.length ; i++)
    {
        [string appendString:@" "];
    }
    return string;
}

@end
