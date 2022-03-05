//
//  FourthTermView.h
//  seek
//
//  Created by Dan on 2021/3/4.
//  Copyright © 2021 Dan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FourthTermViewDelegate <NSObject>
- (void)editAccountAction:(UIButton *)sender;
- (void)gotoLoginAction:(UIButton *)sender;
- (void)gotoPayAction:(UIButton *)sender;
@end

@interface FourthTermView : UIView

@property (nonatomic, strong) UIButton *editAccountBtn;
@property (nonatomic, copy) NSString *editAccountStr;
@property (nonatomic, assign) BOOL isLogin;

@property (nonatomic, weak) id<FourthTermViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
