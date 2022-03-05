//
//  SOSViewController.m
//  seek
//
//  Created by Dan on 2021/3/26.
//  Copyright © 2021 Dan. All rights reserved.
//

#import "SOSViewController.h"
#import "SOSView.h"
#import "BottomAlertView.h"
#import "GotoPayAlertView.h"
#import "PayViewController.h"

@interface SOSViewController ()<SOSViewDelegate, BottomAlertViewDelegate, GotoPayAlertViewDelegate>

@property (nonatomic, strong) SOSView *sosView;
@property (nonatomic, strong) BottomAlertView *bottomAlertView;
@property (nonatomic, strong) NSMutableArray *userArray;
@property (nonatomic, strong) NSMutableArray *bindArray;

@end

@implementation SOSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initViews];
    
    [self initData];
}

- (void)initData
{
    self.bindArray = [[NSMutableArray alloc] init];
    //TODO 获取所有绑定人数
    [self.bindArray addObject:@"13889767675"];
    [self.bindArray addObject:@"18856457651"];
    [self.bindArray addObject:@"17765619872"];
    
    self.userArray = [[NSMutableArray alloc] init];
    //TODO 网络请求后赋值
    [self.userArray addObject:@"15187865643"];
    [self.userArray addObject:@"18790981468"];
    _sosView.userArray = [[NSMutableArray alloc] initWithArray:self.userArray copyItems:YES];
}

- (void)initViews
{
    _sosView = [[SOSView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    _sosView.delegate = self;
    [self.view addSubview:_sosView];
}

#pragma mark - 删除紧急联系人
- (void)deleteAction:(UIButton *)button
{
    AlertView *alertView = [[AlertView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    alertView.titleLbStr = @"提示";
    alertView.contentLbStr = @"确定删除该紧急联系人吗？";
    alertView.sureBtnStr = @"确定";
    [alertView sureClickBlock:^(NSString * _Nonnull inputString) {
        //TODO 调用删除接口
        [self.userArray removeObjectAtIndex:button.tag];
        self.sosView.userArray = self.userArray;
    }];
    [self.view addSubview:alertView];
}

#pragma mark - 添加紧急联系人
- (void)addSOSAction:(UIButton *)button
{
    //TODO 判断用户是否有权限，没有权限先弹支付弹窗，然后跳转支付界面
    BOOL role = YES;
    if (!role)
    {
        GotoPayAlertView *gotoPayView = [[GotoPayAlertView alloc]init];
        gotoPayView.delegate = self;
        [gotoPayView showInView:self.view];
        return;
    }
    
    [AlertToast showSheetActionWithViewController:self title:@"添加方式" action1Title:@"从关心的人中选择" action2Title:@"输入手机号" action1Handler:^(UIAlertAction * _Nonnull action) {
        self.bottomAlertView = [[BottomAlertView alloc]init];
        self.bottomAlertView.bindArray = self.bindArray;
        self.bottomAlertView.delegate = self;
        [self.bottomAlertView showInView:self.view];
    } action2Handler:^(UIAlertAction * _Nonnull action) {
        AlertView *alertView = [[AlertView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
        alertView.inputTx.keyboardType = UIKeyboardTypeNumberPad;
        alertView.titleLbStr = @"请输入联系人手机号";
        alertView.txHidden = NO;
        alertView.placeholderStr = @"点击输入手机号";
        alertView.sureBtnStr = @"确定";
        [alertView sureClickBlock:^(NSString * _Nonnull inputString) {
            if (inputString.length == 0)
            {
                [Toast alertWithTitleBottom:@"手机号不能为空"];
                return;
            }
            if (![Tools checkTel:inputString])
            {
                [Toast alertWithTitleBottom:@"请输入正确的手机号"];
                return;
            }
            [self addUserRequest:inputString];
        }];
        [self.view addSubview:alertView];
    }];
}

#pragma mark - GotoPayAlertView代理方法
- (void)gotoPayAction
{
    PayViewController *vc = [[PayViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - BottomAlertView代理方法
- (void)didSelectRowAction:(NSString *)tel
{
    [self addUserRequest:tel];
}

#pragma mark - 添加紧急联系人网络请求
- (void)addUserRequest:(NSString *)tel
{
    //判断要添加的手机号是否有已存在的
    if ([self.userArray containsObject:tel])
    {
        [Toast alertWithTitleBottom:@"请勿重复添加紧急联系人！"];
        return;
    }
    //TODO 添加网络请求
    [self.userArray addObject:tel];
    self.sosView.userArray = self.userArray;
}

#pragma mark - 发送消息给紧急联系人
- (void)sendSOSAction:(UIButton *)button
{
    //TODO 调用发送接口
}

@end
