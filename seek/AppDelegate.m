//
//  AppDelegate.m
//  seek
//
//  Created by Dan on 2021/2/25.
//  Copyright © 2021 Dan. All rights reserved.
//

#import "AppDelegate.h"
#import "TabBarViewController.h"
#import <AvoidCrash.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[TabBarViewController alloc] init];
    [self.window makeKeyAndVisible];
    
    [AvoidCrash becomeEffective];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dealwithCrashMessage:) name:AvoidCrashNotification object:nil];
    return YES;
}

#pragma mark - 崩溃信息
- (void)dealwithCrashMessage:(NSNotification *)note
{
    NSLog(@"crash=%@",note.userInfo);
}


- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

@end
