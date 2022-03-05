//
//  WebViewController.m
//  seek
//
//  Created by Dan on 2021/3/5.
//  Copyright © 2021 Dan. All rights reserved.
//

#import "WebViewController.h"
#import "NavigationView.h"

@interface WebViewController ()<WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, copy) NSString *webUrl;

@end

@implementation WebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initViews];
}

- (void)initViews
{
    NavigationView *naviView = [[NavigationView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kNavigationHeight)];
    naviView.titleLb.text = self.titleStr;
    [self.view addSubview:naviView];
    
    WKWebView *webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(naviView.frame), kWidth, kHeight - CGRectGetHeight(naviView.frame))];
    webView.navigationDelegate = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([self.title isEqualToString:@"用户协议"])
            {
                //TODO 修改地址
                self.webUrl = @"https://api.app.beijingzhaobang.com:8083/protocol/ZB_AZ_PROTOCOL.html";
            }
            else
            {
                //TODO 修改地址
                self.webUrl = @"https://api.app.beijingzhaobang.com:8083/privacy/ZB_AZ_PRIVACY.html";
            }
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.webUrl]];
            NSString *htmlStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            htmlStr = [self filterHtmlString:htmlStr];
            [webView loadHTMLString:htmlStr baseURL:nil];
        });
    });
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webUrl]]];
    [self.view addSubview:webView];
    self.webView = webView;
}

#pragma mark - webView delegate
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [webView evaluateJavaScript:@"document.documentElement.style.webkitUserSelect='none';" completionHandler:nil];
    [webView evaluateJavaScript:@"document.activeElement.blur();" completionHandler:nil];
    [webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '200%'" completionHandler:nil];
}

- (NSString *)filterHtmlString:(NSString *)htmlString
{
    NSScanner *theScanner;
    theScanner = [NSScanner scannerWithString:htmlString];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"（appName）"] withString:app_Name];
    return htmlString;
}

@end
