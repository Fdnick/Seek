//
//  UIViewController+ModalStyle.h
//  seek
//
//  Created by Dan on 2021/3/5.
//  Copyright © 2021 Dan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (ModalStyle)

@property (nonatomic, assign) BOOL LL_automaticallySetModalPresentationStyle;

+ (BOOL)LL_automaticallySetModalPresentationStyle;

@end

NS_ASSUME_NONNULL_END
