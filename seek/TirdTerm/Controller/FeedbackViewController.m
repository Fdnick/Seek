//
//  FeedbackViewController.m
//  seek
//
//  Created by Dan on 2021/3/8.
//  Copyright © 2021 Dan. All rights reserved.
//

#import "FeedbackViewController.h"
#import "FeedbackView.h"

@interface FeedbackViewController ()<FeedbackViewDelegate>

@property (nonatomic, strong) FeedbackView *feedbackView;
@property (nonatomic, copy) NSString *importStr;

@end

@implementation FeedbackViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initViews];
}

- (void)initViews
{
    self.importStr = @"输入内容不超过200个字符";
    _feedbackView = [[FeedbackView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    _feedbackView.importStr = self.importStr;
    _feedbackView.textView.text = self.importStr;
    _feedbackView.delegate = self;
    [self.view addSubview:_feedbackView];
}

- (void)submitAction
{
    [AlertToast showDeleteDecideWithController:self title:@"提示" message:@"确定提交吗？" sureHandler:^(UIAlertAction * _Nonnull action) {
        //TODO 网络请求
        self.feedbackView.textView.text = self.importStr;
        self.feedbackView.textView.textColor = kPlaceholderColor;
        [Toast alertWithTitleBottom:@"提交成功！"];
    }];
}

@end
