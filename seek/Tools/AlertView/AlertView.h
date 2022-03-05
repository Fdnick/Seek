//
//  AlertView.h
//  seek
//
//  Created by Dan on 2021/3/5.
//  Copyright © 2021 Dan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^sureCallback)(NSString *inputString);

@interface AlertView : UIView

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView *alertImgView;
@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UILabel *contentLb;
@property (nonatomic, strong) UITextField *inputTx;
@property (nonatomic, strong) UIButton *sureBtn;
@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, copy) NSString *titleLbStr;
@property (nonatomic, copy) NSString *contentLbStr;
@property (nonatomic, copy) NSString *txStr;
@property (nonatomic, copy) NSString *placeholderStr;
@property (nonatomic, copy) NSString *sureBtnStr;
@property (nonatomic, copy) sureCallback sureBlock;
@property (nonatomic, assign) BOOL titleHidden;
@property (nonatomic, assign) BOOL contentHidden;
@property (nonatomic, assign) BOOL txHidden;
@property (nonatomic, assign) BOOL closeBtnHidden;

- (void)sureClickBlock:(sureCallback)block;

@end

NS_ASSUME_NONNULL_END
