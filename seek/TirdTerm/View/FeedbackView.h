//
//  FeedbackView.h
//  seek
//
//  Created by Dan on 2021/3/8.
//  Copyright © 2021 Dan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FeedbackViewDelegate <NSObject>
- (void)submitAction;
@end

@interface FeedbackView : UIView

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, copy) NSString *importStr;
@property (nonatomic, weak) id<FeedbackViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
