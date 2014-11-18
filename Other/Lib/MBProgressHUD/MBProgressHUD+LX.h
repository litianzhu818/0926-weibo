//
//  MBProgressHUD+LX.h
//  0926新浪微博
//
//  Created by xinliu on 14-10-30.
//  Copyright (c) 2014年 xinliu. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (LX)

+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;

+ (void)showError:(NSString *)error toView:(UIView *)view;

@end
