//
//  Toast.h
//  seek
//
//  Created by Dan on 2021/2/26.
//  Copyright © 2021 Dan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Singleton.h"

NS_ASSUME_NONNULL_BEGIN

@interface Toast : UIView

AS_SINGLETON(Toast);

- (void)showText:(NSString *)text;

- (void)hiddenToast;

@end

NS_ASSUME_NONNULL_END
