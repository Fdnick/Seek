//
//  LoginViewController.m
//  seek
//
//  Created by Dan on 2021/2/25.
//  Copyright © 2021 Dan. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"

@interface LoginViewController ()<LoginViewDelegate>

@property (nonatomic, strong) LoginView *loginView;
@property (nonatomic, assign) int time;

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initData];
    
    [self initViews];
}

- (void)initData
{
    self.time = 60;
}

- (void)initViews
{
    _loginView = [[LoginView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    _loginView.delegate = self;
    [self.view addSubview:_loginView];
}

#pragma mark - 获取验证码按钮代理事件
- (void)getCodeAction:(UIButton *)sender
{
    _loginView.timeLb.hidden = NO;
    _loginView.timeLb.text = [NSString stringWithFormat:@"等待%d秒",self.time];
    sender.enabled = NO;
    [sender setTitle:@"" forState:UIControlStateNormal];
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(descreaseTimeAction:) userInfo:nil repeats:YES];
    
    //TODO 获取验证码网络请求
}

#pragma mark - 倒计时
- (void)descreaseTimeAction:(NSTimer *)tm
{
    self.time = self.time - 1;
    _loginView.timeLb.text = [NSString stringWithFormat:@"等待%d秒",self.time];
    if (self.time == 0)
    {
        [tm invalidate];
        self.time = 60;
        _loginView.timeLb.hidden = YES;
        _loginView.getCodeBtn.hidden = NO;
        _loginView.getCodeBtn.enabled = YES;
        [_loginView.getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
}

#pragma mark - 登录按钮代理事件
- (void)loginAction:(UIButton *)sender
{
    //TODO 验证码校验网络请求
    
    //TODO 登录网络请求
    
    //请求成功，保存用户登录手机号码，再跳转到点击的原控制器，根据需求看是否需要回传值
    [DefaultInstance saveUserTel:_loginView.telTextField.text];
    [self dismissViewControllerAnimated:YES completion:^{
         [self.delegate backValue:@""];
    }];
}

#pragma mark - 返回按钮事件
- (void)backAction:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
