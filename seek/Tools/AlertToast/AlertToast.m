//
//  AlertToast.m
//  seek
//
//  Created by Dan on 2021/3/8.
//  Copyright © 2021 Dan. All rights reserved.
//

#import "AlertToast.h"

@implementation AlertToast

#pragma mark - 添加2个选项点击,自带"取消"
+ (void)showSheetActionWithViewController:(UIViewController *)viewController title:(NSString *)title action1Title:(NSString *)title1 action2Title:(NSString *)title2 action1Handler:(AlertHander)handler1 action2Handler:(AlertHander)handler2
{
     [[AlertToast alloc] initWithSheetActionWithViewController:viewController title:title action1Title:title1 action2Title:title2 action1Handler:handler1 action2Handler:handler2];
}

- (void)initWithSheetActionWithViewController:(UIViewController *)viewController title:(NSString *)title action1Title:(NSString *)title1 action2Title:(NSString *)title2 action1Handler:(AlertHander)handler1 action2Handler:(AlertHander)handler2;
{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:title1 style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        !handler1 ? : handler1(action);
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:title2 style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        !handler2 ? : handler2(action);
    }]];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [viewController presentViewController:actionSheet animated:YES completion:nil];
    });
}

#pragma mark - 确定删除样式
+ (void)showDeleteDecideWithController:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message sureHandler:(AlertHander)sureHandler
{
    [[AlertToast alloc] initWithDeleteDecideWithController:viewController title:title message:message sureHandler:sureHandler];
}

- (void)initWithDeleteDecideWithController:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message sureHandler:(AlertHander)sureHandler
{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionDone = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        !sureHandler ? : sureHandler(action);
    }];
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    [alertVc addAction:actionDone];
    [alertVc addAction:actionCancel];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [viewController presentViewController:alertVc animated:YES completion:nil];
    });
}

#pragma mark - 确定样式
+ (void)showDecideWithController:(UIViewController *)viewController title:(NSString *)title sureStr:(NSString *)sureStr message:(NSString *)message
{
    [[AlertToast alloc]initWithDecideWithController:viewController title:title sureStr:sureStr message:message];
}

- (void)initWithDecideWithController:(UIViewController *)viewController title:(NSString *)title sureStr:(NSString *)sureStr message:(NSString *)message
{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:sureStr style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    [alertVc addAction:actionCancel];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [viewController presentViewController:alertVc animated:YES completion:nil];
    });
}

@end
