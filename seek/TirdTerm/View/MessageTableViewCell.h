//
//  MessageTableViewCell.h
//  seek
//
//  Created by Dan on 2021/3/23.
//  Copyright © 2021 Dan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MessageCellDelegate <NSObject>
- (void)dealMsgAction:(UITableViewCell *)cell sender:(UIButton *)button;
@end

@interface MessageTableViewCell : UITableViewCell

@property (nonatomic, assign) int state;
@property (nonatomic, strong) MessageModel *model;
@property (nonatomic, weak) id<MessageCellDelegate> delegate;

+ (instancetype)cellWithTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
