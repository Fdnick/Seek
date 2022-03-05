//
//  ThirdTermViewController.m
//  seek
//
//  Created by Dan on 2021/2/25.
//  Copyright © 2021 Dan. All rights reserved.
//

#import "ThirdTermViewController.h"
#import "FeedbackViewController.h"
#import "MessageViewController.h"
#import "LocationMessageViewController.h"
#import "SOSViewController.h"
#import "ThirdTermView.h"
#import "UITabBar+Badge.h"

@interface ThirdTermViewController ()<ThirdTermViewDelegate, LoginBackDelegate>

@property (nonatomic, strong) ThirdTermView *thirdTermView;

@end

@implementation ThirdTermViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initViews];
}

- (void)initViews
{
    _thirdTermView = [[ThirdTermView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    _thirdTermView.delegate = self;
    //TODO 如果有消息cell要添加红点提醒
    _thirdTermView.isHideBadge = NO;
    [self.view addSubview:_thirdTermView];
}

- (void)cellAction:(ThirdCellButton *)sender
{
    switch (sender.tag)
    {
        case 1:
            //在线客服
            [self showCustomerAlert];
            break;
        case 2:
            //在线反馈
            [self gotoFeedbackController];
            break;
        case 3:
            //消息
            [self gotoBindMessageController];
            break;
        case 4:
            //到达/离开地点提醒消息
            [self gotoLocationMessageController];
            break;
        default:
            break;
    }
}

#pragma mark - 在线客服
- (void)showCustomerAlert
{
    AlertView *alertView = [[AlertView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    alertView.titleLbStr = @"在线咨询";
    alertView.contentLbStr = @"联系邮箱：bjrjserve@yeah.net";
    alertView.sureBtnStr = @"确定";
    alertView.closeBtnHidden = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:alertView];
}

#pragma mark - 在线反馈
- (void)gotoFeedbackController
{
    if (![self checkIsLogin])
    {
        return;
    }
    FeedbackViewController *vc = [[FeedbackViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - 消息
- (void)gotoBindMessageController
{
    if (![self checkIsLogin])
    {
        return;
    }
    
    //TODO 点击“消息”则移除红点提醒，处理相关数据
    [self.tabBarController.tabBar hideBadgeOnItemIndex:2];
    _thirdTermView.isHideBadge = YES;
    
    MessageViewController *vc = [[MessageViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - 到达/离开地点提醒消息
- (void)gotoLocationMessageController
{
    if (![self checkIsLogin])
    {
        return;
    }
    LocationMessageViewController *vc = [[LocationMessageViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - 跳转到紧急联系人界面
- (void)sosAction:(UIButton *)sender
{
    if (![self checkIsLogin])
    {
        return;
    }
    SOSViewController *vc = [[SOSViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - 判断是否需要跳转到登录界面
- (BOOL)checkIsLogin
{
    if ([DefaultInstance getUserTel].length == 0)
    {
        LoginViewController *vc = [[LoginViewController alloc] init];
        vc.delegate = self;
        [self presentViewController:vc animated:YES completion:nil];
        return NO;
    }
    else
    {
        return YES;
    }
}

#pragma mark - 登录成功返回代理事件
- (void)backValue:(NSString *)value
{
    
}

@end
