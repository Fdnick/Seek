//
//  Toast+Category.h
//  seek
//
//  Created by Dan on 2021/2/26.
//  Copyright © 2021 Dan. All rights reserved.
//

#import "Toast.h"

NS_ASSUME_NONNULL_BEGIN

@interface Toast (Category)

+ (void)alertWithTitleBottom:(NSString *)title;

//隐藏Toast
+ (void)hiddenToast;

@end

NS_ASSUME_NONNULL_END
