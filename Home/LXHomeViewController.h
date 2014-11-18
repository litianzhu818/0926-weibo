//
//  LXHomeViewController.h
//  0926新浪微博
//
//  Created by xinliu on 14-9-26.
//  Copyright (c) 2014年 xinliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXHomeViewController : UITableViewController

- (instancetype)initWithUpdateDataBlock:(void (^)())updateDataBlock;
- (void)refresh;

@end
