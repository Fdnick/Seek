//
//  UITabBar+Badge.h
//  seek
//
//  Created by Dan on 2021/3/26.
//  Copyright © 2021 Dan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITabBar (Badge)

- (void)showBadgeOnItmIndex:(int)index;
- (void)hideBadgeOnItemIndex:(int)index;

@end

NS_ASSUME_NONNULL_END
