//
//  PayView.h
//  seek
//
//  Created by Dan on 2021/3/19.
//  Copyright © 2021 Dan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PayViewDelegate <NSObject>
- (void)gotoPayAction:(UIButton *)sender;
@end

@interface PayView : UIView

@property (nonatomic, copy) NSString *timeStr;
@property (nonatomic, copy) NSString *priceStr;
@property (nonatomic, copy) NSString *priceDiscountStr;
@property (nonatomic, assign) BOOL isPay;

@property (nonatomic, weak) id<PayViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
