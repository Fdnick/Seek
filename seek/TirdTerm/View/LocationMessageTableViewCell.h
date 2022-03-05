//
//  LocationMessageTableViewCell.h
//  seek
//
//  Created by Dan on 2021/3/24.
//  Copyright © 2021 Dan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationMessageModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol LocationMessageCellDelegate <NSObject>
- (void)deleteAction:(UITableViewCell *)cell sender:(UIButton *)button;
- (void)msgSwitchChange:(UITableViewCell *)cell sender:(UISwitch *)msgSwitch;
@end

@interface LocationMessageTableViewCell : UITableViewCell

@property (nonatomic, strong) LocationMessageModel *model;
@property (nonatomic, weak) id<LocationMessageCellDelegate> delegate;

+ (instancetype)cellWithTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
