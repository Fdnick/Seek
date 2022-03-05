//
//  AlertView.m
//  seek
//
//  Created by Dan on 2021/3/5.
//  Copyright © 2021 Dan. All rights reserved.
//

#import "AlertView.h"

@interface AlertView ()<UITextFieldDelegate>

@property (nonatomic, assign) CGFloat alertHeight;

@end

@implementation AlertView

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
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    _bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [self addSubview:_bgView];
    
    UIImage *alertImg = [UIImage imageNamed:@"alert_bg"];
    self.alertHeight = alertImg.size.height * (kWidth - 60) / alertImg.size.width;
    _alertImgView = [[UIImageView alloc] initWithFrame:CGRectMake(30, kHeight / 2 - self.alertHeight / 2 - kTabBarHeight, kWidth - 60, self.alertHeight)];
    _alertImgView.image = alertImg;
    _alertImgView.userInteractionEnabled = YES;
    [self addSubview:_alertImgView];
    
    _titleLb = [[UILabel alloc] initWithFrame:CGRectMake(30, self.alertHeight * 0.2, CGRectGetWidth(_alertImgView.frame) - 60, 20)];
    _titleLb.font = [UIFont systemFontOfSize:16.0];
    _titleLb.textColor = kLightBlackColor;
    _titleLb.textAlignment = NSTextAlignmentCenter;
    [_alertImgView addSubview:_titleLb];
    
    _contentLb = [[UILabel alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(_titleLb.frame) + 5, CGRectGetWidth(_alertImgView.frame) - 60, self.alertHeight * 0.25)];
    _contentLb.font = [UIFont systemFontOfSize:14.0];
    _contentLb.textColor = kDeepGrayColor;
    _contentLb.textAlignment = NSTextAlignmentCenter;
    _contentLb.numberOfLines = 0;
    [_alertImgView addSubview:_contentLb];
    
    _inputTx = [[UITextField alloc] initWithFrame:CGRectMake(40, CGRectGetMaxY(_titleLb.frame) + 10, CGRectGetWidth(_alertImgView.frame) - 80, self.alertHeight * 0.25 - 15)];
    _inputTx.textColor = kDeepGrayColor;
    _inputTx.returnKeyType = UIReturnKeyDone;
    _inputTx.delegate = self;
    _inputTx.hidden = YES;
    _inputTx.font = [UIFont systemFontOfSize:14.0];
    _inputTx.borderStyle = UITextBorderStyleRoundedRect;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldDidChange:)
    name:@"UITextFieldTextDidChangeNotification" object:_inputTx];
    [_alertImgView addSubview:_inputTx];
    
    UIImage *sureBtnImg = [UIImage imageNamed:@"alert_sure_btn_bg"];
    CGFloat sureBtnHeight = self.alertHeight * 0.2;
    _sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(60, CGRectGetHeight(_alertImgView.frame) - sureBtnHeight - 15, CGRectGetWidth(_alertImgView.frame) - 120, sureBtnHeight)];
    _sureBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [_sureBtn setTitleColor:kLightBlackColor forState:UIControlStateNormal];
    [_sureBtn setBackgroundImage:sureBtnImg forState:UIControlStateNormal];
    [_sureBtn setBackgroundImage:[UIImage imageNamed:@"alert_sure_btn_bg_sel"] forState:UIControlStateHighlighted];
    [_sureBtn addTarget:self action:@selector(sureBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_alertImgView addSubview:_sureBtn];
    
    _closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(kWidth / 2 - 15, CGRectGetMaxY(_alertImgView.frame) + 10, 30, 30)];
    [_closeBtn setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [_closeBtn setBackgroundImage:[UIImage imageNamed:@"close_sel"] forState:UIControlStateHighlighted];
    [_closeBtn addTarget:self action:@selector(closeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_closeBtn];
}

- (void)setTitleLbStr:(NSString *)titleLbStr
{
    _titleLb.text = titleLbStr;
}

- (void)setContentLbStr:(NSString *)contentLbStr
{
    _contentLb.text = contentLbStr;
}

- (void)setTxStr:(NSString *)txStr
{
    _inputTx.text = txStr;
}

- (void)setPlaceholderStr:(NSString *)placeholderStr
{
    _inputTx.placeholder = placeholderStr;
}

- (void)setSureBtnStr:(NSString *)sureBtnStr
{
    [_sureBtn setTitle:sureBtnStr forState:UIControlStateNormal];
}

- (void)setTitleHidden:(BOOL)titleHidden
{
    _titleLb.hidden = titleHidden;
    _contentLb.frame = CGRectMake(30, self.alertHeight * 0.2, CGRectGetWidth(_alertImgView.frame) - 60, self.alertHeight * 0.25 + 20);
}

- (void)setContentHidden:(BOOL)contentHidden
{
    _contentLb.hidden = contentHidden;
}

- (void)setTxHidden:(BOOL)txHidden
{
    _inputTx.hidden = txHidden;
}

- (void)setCloseBtnHidden:(BOOL)closeBtnHidden
{
    _closeBtn.hidden = closeBtnHidden;
}

- (void)sureBtnAction:(UIButton *)sender
{
    if (self.sureBlock)
    {
        self.sureBlock(self.inputTx.text);
    }
    [self removeFromSuperview];
}

- (void)closeBtnAction:(UIButton *)sender
{
    [self removeFromSuperview];
}

- (void)sureClickBlock:(sureCallback)block
{
    self.sureBlock = block;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_inputTx resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (![_inputTx isExclusiveTouch])
    {
        [_inputTx resignFirstResponder];
    }
    return YES;
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

-(void)textFieldDidChange:(NSNotification *)obj
{
    int maxLength = 11;
    UITextField *textField = (UITextField *)obj.object;
    NSString *toBeString = textField.text;
    
    NSString *tem = [[textField.text componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] componentsJoinedByString:@""];
    textField.text = tem;
    
    UITextRange *selectedRange = [textField markedTextRange];
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    
    if (!position)
    {
        if (toBeString.length > maxLength)
        {
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:maxLength];
            if (rangeIndex.length == 1)
            {
                textField.text = [toBeString substringToIndex:maxLength];
            }
            else
            {
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, maxLength)];
                textField.text = [toBeString substringWithRange:rangeRange];
            }
        }
    }
}

@end
