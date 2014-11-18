//
//  LXStatusCell.h
//  0926新浪微博
//
//  Created by xinliu on 14-9-29.
//  Copyright (c) 2014年 xinliu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LXStatusFrame;

@interface LXStatusCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (strong,nonatomic) LXStatusFrame *statusFrame;

@end
