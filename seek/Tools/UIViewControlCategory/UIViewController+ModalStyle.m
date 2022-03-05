//
//  UIViewController+ModalStyle.m
//  seek
//
//  Created by Dan on 2021/3/5.
//  Copyright © 2021 Dan. All rights reserved.
//

#import "UIViewController+ModalStyle.h"
#import <objc/runtime.h>

static const char *LL_automaticallySetModalPresentationStyleKey;

@implementation UIViewController (ModalStyle)

+ (void)load
{
    Method originAddObserverMethod = class_getInstanceMethod(self, @selector(presentViewController:animated:completion:));
    Method swizzledAddObserverMethod = class_getInstanceMethod(self, @selector(LL_presentViewController:animated:completion:));
    method_exchangeImplementations(originAddObserverMethod, swizzledAddObserverMethod);
}

- (void)setLL_automaticallySetModalPresentationStyle:(BOOL)LL_automaticallySetModalPresentationStyle
{
    objc_setAssociatedObject(self, LL_automaticallySetModalPresentationStyleKey, @(LL_automaticallySetModalPresentationStyle), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)LL_automaticallySetModalPresentationStyle
{
    id obj = objc_getAssociatedObject(self, LL_automaticallySetModalPresentationStyleKey);
    if (obj)
    {
        return [obj boolValue];
    }
    return [self.class LL_automaticallySetModalPresentationStyle];
}

+ (BOOL)LL_automaticallySetModalPresentationStyle
{
    if ([self isKindOfClass:[UIImagePickerController class]] || [self isKindOfClass:[UIAlertController class]])
    {
        return NO;
    }
    return YES;
}

- (void)LL_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    if (@available(iOS 13.0, *))
    {
        if (viewControllerToPresent.LL_automaticallySetModalPresentationStyle)
        {
            viewControllerToPresent.modalPresentationStyle = UIModalPresentationFullScreen;
        }
        [self LL_presentViewController:viewControllerToPresent animated:flag completion:completion];
    }
    else
    {
        [self LL_presentViewController:viewControllerToPresent animated:flag completion:completion];
    }
}

@end
