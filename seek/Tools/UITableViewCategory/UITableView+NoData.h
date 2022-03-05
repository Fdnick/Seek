//
//  UITableView+NoData.h
//  seek
//
//  Created by Dan on 2021/3/24.
//  Copyright © 2021 Dan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (NoData)

- (void)tableViewShowNoDataText:(NSString *)showText img:(NSString *)showImg rowCount:(NSUInteger)rowCount;

@end

NS_ASSUME_NONNULL_END
