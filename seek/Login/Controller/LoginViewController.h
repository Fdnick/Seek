//
//  LoginViewController.h
//  seek
//
//  Created by Dan on 2021/2/25.
//  Copyright © 2021 Dan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LoginBackDelegate <NSObject>
-(void)backValue:(NSString *)value;
@end

@interface LoginViewController : UIViewController

@property (nonatomic, weak) id<LoginBackDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
