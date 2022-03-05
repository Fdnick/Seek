//
//  GotoPayAlertView.h
//  seek
//
//  Created by Dan on 2021/3/30.
//  Copyright © 2021 Dan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol GotoPayAlertViewDelegate <NSObject>
- (void)gotoPayAction;
@end

@interface GotoPayAlertView : UIView

@property (nonatomic, weak) id<GotoPayAlertViewDelegate> delegate;

- (void)showInView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
