//
//  MessageViewController.m
//  seek
//
//  Created by Dan on 2021/3/23.
//  Copyright © 2021 Dan. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageTableViewCell.h"
#import "MessageModel.h"

@interface MessageViewController ()<UITableViewDataSource, UITableViewDelegate, MessageCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *modelArray;
@property (nonatomic, assign) int page;
@property (nonatomic, assign) int total;

@end

@implementation MessageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initViews];
    
    [self getData:1];
}

- (void)initViews
{
    NavigationView *naviView = [[NavigationView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kNavigationHeight)];
    naviView.titleLb.text = @"消息";
    [self.view addSubview:naviView];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(naviView.frame), kWidth, kHeight - CGRectGetHeight(naviView.frame)) style:UITableViewStylePlain];
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
    [self getData:1];
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
        [self getData:self.page];
        [self.tableView.mj_footer endRefreshing];
    }
    else
    {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
}

#pragma mark - 网络请求数据
- (void)getData:(int)page
{
    //TODO 网络请求获取交互数据
}

- (NSMutableArray *)modelArray
{
    if (_modelArray == nil)
    {
        _modelArray = [[NSMutableArray alloc]init];
        NSMutableArray *tempArray = [[NSMutableArray alloc]init];
        [tempArray addObject:@{@"id": @(1), @"title": @"系统消息", @"content": @"您的好友15558176405解除了与您的好友关系", @"state": @"0", @"createTime": @"03-03 14:43"}];
        [tempArray addObject:@{@"id": @(2), @"title": @"好友申请", @"content": @"15558176405已同意您的请求", @"state": @"0", @"createTime": @"03-03 14:28"}];
        [tempArray addObject:@{@"id": @(3), @"title": @"好友申请", @"content": @"15558176405请求加您为好友", @"state": @"1", @"createTime": @"03-03 14:16"}];
        [tempArray addObject:@{@"id": @(4), @"title": @"好友申请", @"content": @"15558176405请求加您为好友", @"state": @"2", @"createTime": @"03-03 14:11"}];
        [tempArray addObject:@{@"id": @(5), @"title": @"系统消息", @"content": @"您绑定的用户13876549875离开现代家园(置业街)附近", @"state": @"3", @"createTime": @"03-03 11:09"}];
        NSMutableArray *models = [NSMutableArray arrayWithCapacity:tempArray.count];
        for (NSDictionary *dict in tempArray)
        {
            MessageModel *model = [MessageModel getModelWithDic: dict];
            [models addObject:model];
        }
        self.modelArray = [models mutableCopy];
        [_tableView reloadData];
    }
    return _modelArray;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [tableView tableViewShowNoDataText:@"暂无消息哦！" img:@"fail_null" rowCount:self.modelArray.count];
    return self.modelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageTableViewCell *cell = [MessageTableViewCell cellWithTableView:tableView cellForRowAtIndexPath:indexPath];
    cell.delegate = self;
    cell.model = self.modelArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

#pragma mark - cell代理
- (void)dealMsgAction:(UITableViewCell *)cell sender:(UIButton *)button
{
    NSIndexPath *index = [self.tableView indexPathForRowAtPoint:cell.center];
    MessageModel *model = [self.modelArray objectAtIndex:index.row];
    if (model.state == 3)
    {
        //跳转地图界面
        return;
    }
    //TODO 根据实际情况修改model参数 网络请求同意绑定申请
    model.state = 1;
    [self.modelArray replaceObjectAtIndex:index.row withObject:model];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:index] withRowAnimation:UITableViewRowAnimationFade];
}

@end
