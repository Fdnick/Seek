//
//  LocationMessageViewController.m
//  seek
//
//  Created by Dan on 2021/3/24.
//  Copyright © 2021 Dan. All rights reserved.
//

#import "LocationMessageViewController.h"
#import "LocationMessageTableViewCell.h"
#import "LocationMessageTableHeaderView.h"
#import "BottomAlertView.h"
#import "LocationMessageModel.h"

@interface LocationMessageViewController ()<UITableViewDataSource, UITableViewDelegate, LocationMessageCellDelegate, LocationMessageHeaderDelegate, BottomAlertViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *addLocationBtn;
@property (nonatomic, strong) LocationMessageTableHeaderView *headerView;
@property (nonatomic, strong) BottomAlertView *bottomAlertView;
@property (nonatomic, strong) NSMutableArray *modelArray;
@property (nonatomic, strong) NSMutableArray *bindArray;
@property (nonatomic, copy) NSString *currentChooseBind;
@property (nonatomic, assign) int page;
@property (nonatomic, assign) int total;

@end

@implementation LocationMessageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initData];
    
    [self initViews];
}

- (void)initData
{
    self.bindArray = [[NSMutableArray alloc] init];
    //TODO 获取所有绑定人数
    [self.bindArray addObject:@"13889767675"];
    [self.bindArray addObject:@"18856457651"];
    [self.bindArray addObject:@"17765619872"];
}

- (void)initViews
{
    self.view.backgroundColor = kLightGrayColor;
    
    NavigationView *naviView = [[NavigationView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kNavigationHeight)];
    naviView.titleLb.text = @"地点提醒";
    [self.view addSubview:naviView];
    
    UIImage *btnImg = [UIImage imageNamed:@"login_btn"];
    CGFloat addLocationBtnHeight = btnImg.size.height * kWidth / btnImg.size.width - 10;
    _addLocationBtn = [[UIButton alloc]initWithFrame:CGRectMake(40, kHeight - addLocationBtnHeight - kBottomSafeHeight - 20, kWidth - 40 * 2, addLocationBtnHeight)];
    _addLocationBtn.titleLabel.font = [UIFont systemFontOfSize:18.0];
    [_addLocationBtn setTitle:@"+ 添加地点" forState:UIControlStateNormal];
    [_addLocationBtn setTitleColor:KWhiteColor forState:UIControlStateNormal];
    [_addLocationBtn setBackgroundImage:[UIImage imageNamed:@"login_btn"] forState:UIControlStateNormal];
    [_addLocationBtn setBackgroundImage:[UIImage imageNamed:@"login_btn_sel"] forState:UIControlStateHighlighted];
    [_addLocationBtn addTarget:self action:@selector(addLocationAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_addLocationBtn];
    
    if (self.bindArray.count == 0)
    {
        UIImage *bgImg = [UIImage imageNamed:@"fail_null"];
        CGFloat imgViewHeight = bgImg.size.height * 120 / bgImg.size.width;
        UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth / 2 - 60, kHeight / 2 - imgViewHeight / 2 - 150, 120, imgViewHeight)];
        bgImgView.image = bgImg;
        [self.view addSubview:bgImgView];
        
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(bgImgView.frame) + 30, kWidth, 20)];
        messageLabel.text = @"尚无关心的人，请先添加再设置！";
        messageLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
        messageLabel.textColor = kDeepGrayColor;
        messageLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:messageLabel];
        
        _addLocationBtn.frame = CGRectMake(40, CGRectGetMaxY(messageLabel.frame) + 20, kWidth - 40 * 2, addLocationBtnHeight);
        
        return;
    }
    
    //默认获取第一个用户
    self.currentChooseBind = self.bindArray[0];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(naviView.frame), kWidth, kHeight - CGRectGetHeight(naviView.frame) - addLocationBtnHeight - kBottomSafeHeight - 40) style:UITableViewStylePlain];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    _tableView.backgroundColor = kLightGrayColor;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorInset = UIEdgeInsetsZero;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
    
    if (@available(iOS 11.0, *))
    {
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    MJRefreshNormalHeader *header = [[MJRefreshNormalHeader alloc] init];
    [header setRefreshingTarget:self refreshingAction:@selector(headerClick)];
    self.tableView.mj_header = header;
    
    MJRefreshBackNormalFooter *footer = [[MJRefreshBackNormalFooter alloc] init];
    [footer setRefreshingTarget:self refreshingAction:@selector(footerClick)];
    self.tableView.mj_footer = footer;
}

- (void)headerClick
{
    [self getData:1 withTel:self.currentChooseBind];
    self.page = 1;
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer resetNoMoreData];
}

- (void)footerClick
{
    self.page++;
    //TODO self.total是总页数，根据实际情况看是否有分页
    if (self.page <= self.total)
    {
        [self getData:self.page withTel:self.currentChooseBind];
        [self.tableView.mj_footer endRefreshing];
    }
    else
    {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
}

#pragma mark - 网络请求数据
- (void)getData:(int)page withTel:(NSString *)tel
{
    //TODO 网络请求当前选中的绑定号码提醒地点
}

- (NSMutableArray *)modelArray
{
    if (_modelArray == nil)
    {
        _modelArray = [[NSMutableArray alloc]init];
        NSMutableArray *tempArray = [[NSMutableArray alloc]init];
        [tempArray addObject:@{@"id": @(1), @"title": @"小电(来吃饭早餐)", @"content": @"泛远巷28号现代家园", @"state": @"0", @"tel": @"15558176405"}];
        [tempArray addObject:@{@"id": @(2), @"title": @"易居房友", @"content": @"泛远巷22号", @"state": @"1", @"tel": @"15558176405"}];
        [tempArray addObject:@{@"id": @(3), @"title": @"现代置业大厦西楼", @"content": @"置业街附近", @"state": @"0", @"tel": @"15558176405"}];
        NSMutableArray *models = [NSMutableArray arrayWithCapacity:tempArray.count];
        for (NSDictionary *dict in tempArray)
        {
            LocationMessageModel *model = [LocationMessageModel getModelWithDic: dict];
            [models addObject:model];
        }
        self.modelArray = [models mutableCopy];
        [_tableView reloadData];
    }
    return _modelArray;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [tableView tableViewShowNoDataText:@"你没有为该好友设置地点提醒！" img:@"fail_null" rowCount:self.modelArray.count];
    return self.modelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LocationMessageTableViewCell *cell = [LocationMessageTableViewCell cellWithTableView:tableView cellForRowAtIndexPath:indexPath];
    cell.delegate = self;
    cell.model = self.modelArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //TODO 跳转地图界面
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    _headerView = [LocationMessageTableHeaderView headerViewWithTableView:tableView];
    //默认显示第一条
    _headerView.headStr = self.currentChooseBind;
    _headerView.delegate = self;
    return _headerView;
}

#pragma mark - cell代理
- (void)deleteAction:(UITableViewCell *)cell sender:(UIButton *)button
{
    NSIndexPath *index = [self.tableView indexPathForRowAtPoint:cell.center];
    AlertView *alertView = [[AlertView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    alertView.titleLbStr = @"确认删除吗？";
    alertView.contentLbStr = @"删除后不能获取好友位置提醒";
    alertView.sureBtnStr = @"确定";
    [alertView sureClickBlock:^(NSString * _Nonnull inputString) {
        //TODO 调用删除接口
        [self.modelArray removeObjectAtIndex:index.row];
        [self.tableView reloadData];
    }];
    [self.view addSubview:alertView];
}

- (void)msgSwitchChange:(UITableViewCell *)cell sender:(UISwitch *)msgSwitch
{
    //TODO 调用接口改变开关状态 根据实际情况修改model参数
    NSIndexPath *index = [self.tableView indexPathForRowAtPoint:cell.center];
    LocationMessageModel *model = [self.modelArray objectAtIndex:index.row];
    if (msgSwitch.on == YES)
    {
        model.state = 1;
    }
    else
    {
        model.state = 0;
    }
    [self.modelArray replaceObjectAtIndex:index.row withObject:model];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:index] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - header代理
- (void)chooseAction:(UIButton *)button
{
    _bottomAlertView = [[BottomAlertView alloc]init];
    _bottomAlertView.bindArray = self.bindArray;
    _bottomAlertView.delegate = self;
    [_bottomAlertView showInView:self.view];
}

#pragma mark - BottomAlertView代理方法 选择切换绑定用户
- (void)didSelectRowAction:(NSString *)tel
{
    if ([tel isEqualToString:self.currentChooseBind])
    {
        return;
    }
    self.currentChooseBind = tel;
    _headerView.headStr = self.currentChooseBind;
    //TODO 重新请求切换的手机号码所有提醒位置信息
    [self getData:1 withTel:tel];
}

#pragma mark - 添加地点按钮事件
- (void)addLocationAction:(UIButton *)sender
{
    //TODO 跳转地图界面选择地点
}

@end
