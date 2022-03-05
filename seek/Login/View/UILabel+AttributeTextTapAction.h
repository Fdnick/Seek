//
//  UILabel+AttributeTextTapAction.h
//  seek
//
//  Created by Dan on 2021/2/26.
//  Copyright © 2021 Dan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AttributeTapActionDelegate <NSObject>
@optional
/**
 *  AttributeTapActionDelegate
 *
 *  @param string  点击的字符串
 *  @param range   点击的字符串range
 *  @param index 点击的字符在数组中的index
 */
- (void)tapAttributeInLabel:(UILabel *)label string:(NSString *)string range:(NSRange)range index:(NSInteger)index;
@end

@interface UILabel (AttributeTextTapAction)

//是否打开点击效果，默认是打开
@property (nonatomic, assign) BOOL enabledTapEffect;
//是否扩大点击范围，默认是打开
@property (nonatomic, assign) BOOL enlargeTapArea;
//点击高亮色 默认是[UIColor lightGrayColor] 需打开enabledTapEffect才有效
@property (nonatomic, strong) UIColor *tapHighlightedColor;

/**
 *  给文本添加点击事件Block回调
 *
 *  @param strings  需要添加的字符串数组
 *  @param tapClick 点击事件回调
 */
- (void)addAttributeTapActionWithStrings:(NSArray <NSString *> *)strings
                                 tapClicked:(void (^) (UILabel *label, NSString *string, NSRange range, NSInteger index))tapClick;

/**
 *  给文本添加点击事件delegate回调
 *
 *  @param strings  需要添加的字符串数组
 *  @param delegate delegate
 */
- (void)addAttributeTapActionWithStrings:(NSArray <NSString *> *)strings
                                   delegate:(id <AttributeTapActionDelegate> )delegate;

/**
 *  根据range给文本添加点击事件Block回调
 *
 *  @param ranges  需要添加的Range字符串数组
 *  @param tapClick 点击事件回调
 */
- (void)addAttributeTapActionWithRanges:(NSArray <NSString *> *)ranges
                                 tapClicked:(void (^) (UILabel *label, NSString *string, NSRange range, NSInteger index))tapClick;

/**
 *  根据range给文本添加点击事件delegate回调
 *
 *  @param ranges  需要添加的Range字符串数组
 *  @param delegate delegate
 */
- (void)addAttributeTapActionWithRanges:(NSArray <NSString *> *)ranges
                                   delegate:(id <AttributeTapActionDelegate> )delegate;

/**
 *  删除label上的点击事件
 */
- (void)removeAttributeTapActions;

@end

NS_ASSUME_NONNULL_END
