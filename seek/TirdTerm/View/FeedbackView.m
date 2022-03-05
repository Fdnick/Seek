//
//  FeedbackView.m
//  seek
//
//  Created by Dan on 2021/3/8.
//  Copyright © 2021 Dan. All rights reserved.
//

#import "FeedbackView.h"

@interface FeedbackView ()<UITextViewDelegate>

@end

@implementation FeedbackView

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
    naviView.titleLb.text = @"在线反馈";
    [self addSubview:naviView];
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(25, kNavigationHeight + 20, kWidth - 50, kHeight / 3)];
    whiteView.backgroundColor = KWhiteColor;
    whiteView.layer.cornerRadius = 10.0;
    whiteView.layer.masksToBounds = YES;
    [self addSubview:whiteView];
    
    UILabel *prefixLb = [[UILabel alloc] initWithFrame:CGRectMake(25, 0, CGRectGetWidth(whiteView.frame) - 50, 40)];
    prefixLb.text = @"请填写意见或反馈";
    prefixLb.textColor = kLightBlackColor;
    prefixLb.font = [UIFont systemFontOfSize:15.0];
    [whiteView addSubview:prefixLb];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(CGRectGetMinX(prefixLb.frame), CGRectGetMaxY(prefixLb.frame) + 5, CGRectGetWidth(prefixLb.frame), CGRectGetHeight(whiteView.frame) - CGRectGetHeight(prefixLb.frame) - 5 - 25)];
    _textView.font = [UIFont systemFontOfSize:16];
    _textView.textColor = kPlaceholderColor;
    _textView.returnKeyType = UIReturnKeyDone;
    _textView.delegate = self;
    _textView.layer.cornerRadius = 6.0;
    _textView.clipsToBounds = YES;
    _textView.layer.borderColor = kPlaceholderColor.CGColor;
    _textView.layer.borderWidth = 0.5f;
    _textView.textContainerInset = UIEdgeInsetsMake(10, 10, 0, 10);
    [whiteView addSubview:_textView];
    
    UIImage *submitImg = [UIImage imageNamed:@"login_btn"];
    UIButton *submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMinX(whiteView.frame), CGRectGetMaxY(whiteView.frame) + 50, CGRectGetWidth(whiteView.frame), submitImg.size.height * CGRectGetWidth(whiteView.frame) / submitImg.size.width)];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:18.0];
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [submitBtn setTitleColor:KWhiteColor forState:UIControlStateNormal];
    [submitBtn setBackgroundImage:[UIImage imageNamed:@"login_btn"] forState:UIControlStateNormal];
    [submitBtn setBackgroundImage:[UIImage imageNamed:@"login_btn_sel"] forState:UIControlStateHighlighted];
    [submitBtn addTarget:self action:@selector(submitBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:submitBtn];
}

- (void)submitBtnAction
{
    if (_textView.text.length == 0 || [_textView.text isEqualToString:self.importStr])
    {
        [AlertToast showDecideWithController:[Tools getSuperController:self] title:@"提示" sureStr:@"我知道了" message:@"请输入内容"];
        return;
    }
    
    [self.delegate submitAction];
}

#pragma mark - textviewdelegate
- (void)textViewDidChange:(UITextView *)textView
{
    UITextRange *selectedRange = [textView markedTextRange];
    UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
    if (selectedRange && pos)
    {
        return;
    }
    NSString *countStr = @"200";
    NSString *nsTextContent = textView.text;
    NSInteger existTextNum = nsTextContent.length;
    if (existTextNum > countStr.intValue)
    {
        NSString *s = [nsTextContent substringToIndex:countStr.intValue];
        [textView setText:s];
        existTextNum = countStr.intValue;
        [AlertToast showDecideWithController:[Tools getSuperController:self] title:@"提示" sureStr:@"知道了" message:@"输入内容不超过200个字符"];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([self isNineKeyBoard:text])
    {
        return YES;
    }
    else
    {
        if ([self hasEmoji:text] || [Tools stringContainsEmoji:text])
        {
            return NO;
        }
    }
    if ([text isEqualToString: @"\n" ])
    {
        [textView resignFirstResponder];
        return  NO;
    }
  return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if(textView.text.length < 1)
    {
        textView.text = self.importStr;
        textView.textColor = kPlaceholderColor;
     }
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
     if([textView.text isEqualToString:self.importStr])
     {
         textView.text = @"";
         textView.textColor = kLightBlackColor;
     }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    [_textView resignFirstResponder];
}

- (BOOL)hasEmoji:(NSString*)string;
{
    NSString *pattern = @"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:string];
    return isMatch;
}

- (BOOL)isNineKeyBoard:(NSString *)string
{
    NSString *other = @"➋➌➍➎➏➐➑➒";
    int len = (int)string.length;
    for (int i = 0; i < len; i++)
    {
        if(!([other rangeOfString:string].location != NSNotFound))
            return NO;
    }
    return YES;
}

@end
