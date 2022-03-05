//
//  BottomAlertView.h
//  seek
//
//  Created by Dan on 2021/3/25.
//  Copyright © 2021 Dan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BottomAlertViewDelegate <NSObject>
- (void)didSelectRowAction:(NSString *)tel;
@end

@interface BottomAlertView : UIView

@property (nonatomic, strong) NSMutableArray *bindArray;
@property (nonatomic, weak) id<BottomAlertViewDelegate> delegate;

- (void)showInView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
