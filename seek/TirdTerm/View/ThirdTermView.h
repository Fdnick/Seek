//
//  ThirdTermView.h
//  seek
//
//  Created by Dan on 2021/3/2.
//  Copyright © 2021 Dan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThirdCellButton.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ThirdTermViewDelegate <NSObject>
- (void)cellAction:(ThirdCellButton *)sender;
- (void)sosAction:(UIButton *)sender;
@end

@interface ThirdTermView : UIView

@property (nonatomic, assign) BOOL isHideBadge;
@property (nonatomic, weak) id<ThirdTermViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
