//
//  TabBarViewController.m
//  seek
//
//  Created by Dan on 2021/2/25.
//  Copyright © 2021 Dan. All rights reserved.
//

#import "TabBarViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //TODO 动态获取添加
    NSArray *controllerArry = @[@"FirstTermViewController", @"SecondTermViewController", @"ThirdTermViewController", @"FourthTermViewController"];
    NSArray *titleArry = @[@"添加定位", @"轨迹查询", @"联系消息", @"详细内容"];
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for(int i = 0; i < controllerArry.count; i++)
    {
        Class cl = NSClassFromString(controllerArry[i]);
        UIViewController *controller = [[cl alloc]init];
        [array addObject:controller];
    }
    self.viewControllers = array;
    self.tabBar.tintColor = KGeenColor;
    NSInteger index = 0;
    for (UITabBarItem *item in [self.tabBar items])
    {
        item.title = titleArry[index];
        item.image = [[UIImage imageNamed:[NSString stringWithFormat:@"tabbar_icon%ld",(long)index + 1]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"tabbar_icon%ld_sel",(long)index + 1]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        index++;
    }
}

@end
