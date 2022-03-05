//
//  LocationMessageTableHeaderView.h
//  seek
//
//  Created by Dan on 2021/3/24.
//  Copyright © 2021 Dan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LocationMessageHeaderDelegate <NSObject>
- (void)chooseAction:(UIButton *)button;
@end

@interface LocationMessageTableHeaderView : UITableViewHeaderFooterView

@property (nonatomic, copy) NSString *headStr;
@property (nonatomic, weak) id<LocationMessageHeaderDelegate> delegate;

+ (instancetype)headerViewWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
