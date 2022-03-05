//
//  AlertToast.h
//  seek
//
//  Created by Dan on 2021/3/8.
//  Copyright © 2021 Dan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^AlertHander)(UIAlertAction *action);

@interface AlertToast : NSObject

@property (nonatomic, copy)  AlertHander handler;

+ (void)showSheetActionWithViewController:(UIViewController *)viewController title:(NSString *)title action1Title:(NSString *)title1 action2Title:(NSString *)title2 action1Handler:(AlertHander)handler1 action2Handler:(AlertHander)handler2;

+ (void)showDeleteDecideWithController:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message sureHandler:(AlertHander)sureHandler;

+ (void)showDecideWithController:(UIViewController *)viewController title:(NSString *)title sureStr:(NSString *)sureStr message:(NSString *)message;

@end

NS_ASSUME_NONNULL_END
