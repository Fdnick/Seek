//
//  FourthTermViewController.m
//  seek
//
//  Created by Dan on 2021/2/25.
//  Copyright © 2021 Dan. All rights reserved.
//

#import "FourthTermViewController.h"
#import "PayViewController.h"
#import "FourthTermView.h"

@interface FourthTermViewController ()<UITabBarControllerDelegate, FourthTermViewDelegate, LoginBackDelegate>

@property (nonatomic, strong) FourthTermView *fourthTermView;

@end

@implementation FourthTermViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initViews];
    
    [self checkIsLogin];
}

- (void)initViews
{
    self.tabBarController.delegate = self;
    _fourthTermView = [[FourthTermView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    _fourthTermView.delegate = self;
    [self.view addSubview:_fourthTermView];
}

#pragma mark - 弹出编辑昵称弹窗
- (void)editAccountAction:(UIButton *)sender
{
    AlertView *alertView = [[AlertView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    alertView.titleLbStr = @"修改昵称";
    alertView.contentHidden = YES;
    alertView.txHidden = NO;
    alertView.placeholderStr = @"点击输入名称，最多11个字";
    alertView.txStr = _fourthTermView.editAccountBtn.titleLabel.text;
    alertView.sureBtnStr = @"确定";
    [alertView sureClickBlock:^(NSString * _Nonnull inputString) {
        if ([Tools stringContainsEmoji:inputString])
        {
            [Toast alertWithTitleBottom:@"不能包含表情"];
            return;
        }
        if (inputString.length == 0)
        {
            [Toast alertWithTitleBottom:@"请输入昵称"];
            return;
        }
        if ([inputString isEqualToString:self.fourthTermView.editAccountBtn.titleLabel.text])
        {
            return;
        }
        //TODO 更新上传用户昵称
        self.fourthTermView.editAccountStr = inputString;
    }];
    [[UIApplication sharedApplication].keyWindow addSubview:alertView];
}

#pragma mark - 跳转到登录界面
- (void)gotoLoginAction:(UIButton *)sender
{
    LoginViewController *vc = [[LoginViewController alloc] init];
    vc.delegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - 跳转到支付界面
- (void)gotoPayAction:(UIButton *)sender
{
    PayViewController *vc = [[PayViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - 登录成功返回代理事件
- (void)backValue:(NSString *)value
{
    [self checkIsLogin];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if (self.tabBarController.selectedIndex == 3)
    {
        [self checkIsLogin];
    }
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    UIViewController *tbselect = tabBarController.selectedViewController;
    if([tbselect isEqual:viewController])
    {
        return NO;
    }
    return YES;
}

- (void)checkIsLogin
{
    if ([DefaultInstance getUserTel].length != 0)
    {
        _fourthTermView.isLogin = YES;
    }
    else
    {
        _fourthTermView.isLogin = NO;
    }
}

@end
