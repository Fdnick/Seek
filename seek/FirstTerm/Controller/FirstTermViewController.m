//
//  FirstTermViewController.m
//  seek
//
//  Created by Dan on 2021/2/25.
//  Copyright © 2021 Dan. All rights reserved.
//

#import "FirstTermViewController.h"
#import "UITabBar+Badge.h"

@interface FirstTermViewController ()

@end

@implementation FirstTermViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setMsgBadge];
}

#pragma mark - 初始化第一个控制器的时候就要获取是否有消息，然后设置是否显示红点
- (void)setMsgBadge
{
    //TODO 如果有消息Tabbar要添加红点提醒
    UIViewController *tabbarCtr = [self.tabBarController.viewControllers objectAtIndex:2];
    [tabbarCtr.tabBarController.tabBar showBadgeOnItmIndex:2];
}

@end
