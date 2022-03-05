//
//  UITableView+NoData.m
//  seek
//
//  Created by Dan on 2021/3/24.
//  Copyright © 2021 Dan. All rights reserved.
//

#import "UITableView+NoData.h"

@implementation UITableView (NoData)

#pragma mark - 列表没有数据或者加载失败缺省界面
- (void)tableViewShowNoDataText:(NSString *)showText img:(NSString *)showImg rowCount:(NSUInteger)rowCount
{
    self.backgroundView = nil;
    if (rowCount != 0)
        return;
    
    UIView *bgView = [UIView new];
    
    UIImage *bgImg = [UIImage imageNamed:showImg];
    CGFloat imgViewHeight = bgImg.size.height * 120 / bgImg.size.width;
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 - 60, kHeight / 2 - imgViewHeight / 2 - 100, 120, imgViewHeight)];
    bgImgView.image = bgImg;
    [bgView addSubview:bgImgView];
    
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(bgImgView.frame) + 30, self.frame.size.width, 20)];
    messageLabel.text = showText;
    messageLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    messageLabel.textColor = kDeepGrayColor;
    messageLabel.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:messageLabel];
    
    self.backgroundView = bgView;
}

@end
