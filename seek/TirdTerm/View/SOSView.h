//
//  SOSView.h
//  seek
//
//  Created by Dan on 2021/3/26.
//  Copyright © 2021 Dan. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@protocol SOSViewDelegate <NSObject>
- (void)deleteAction:(UIButton *)button;
- (void)addSOSAction:(UIButton *)button;
- (void)sendSOSAction:(UIButton *)button;
@end

@interface SOSView : UIView

@property (nonatomic, strong) NSMutableArray *userArray;
@property (nonatomic, weak) id<SOSViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
