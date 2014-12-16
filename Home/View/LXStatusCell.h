//
//  LXStatusCell.h
//  0926新浪微博
//
//  Created by xinliu on 14-9-29.
//  Copyright (c) 2014年 xinliu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LXStatusFrame;
@class LXStatusCell;
@class LXStatus;

@protocol LXStatusCellDelegate <NSObject>

- (void)statusCell:(LXStatusCell *)statusCell didClickedStatus:(LXStatus *)status;

@end

@interface LXStatusCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (strong,nonatomic) LXStatusFrame *statusFrame;
@property (weak,nonatomic) id<LXStatusCellDelegate> delegate;

@end
