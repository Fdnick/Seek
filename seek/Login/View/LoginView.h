//
//  LoginView.h
//  seek
//
//  Created by Dan on 2021/2/25.
//  Copyright © 2021 Dan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LoginViewDelegate <NSObject>
- (void)getCodeAction:(UIButton *)sender;
- (void)loginAction:(UIButton *)sender;
- (void)backAction:(UIButton *)sender;
@end

@interface LoginView : UIView<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *telTextField;
@property (nonatomic, strong) UITextField *passTextField;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIButton *getCodeBtn;
@property (nonatomic, strong) UIButton *protocolBtn;
@property (nonatomic, strong) UILabel *timeLb;
@property (nonatomic, strong) UIImageView *popImgView;
@property (nonatomic, weak) id<LoginViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
