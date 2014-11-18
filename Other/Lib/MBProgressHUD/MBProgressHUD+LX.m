//
//  MBProgressHUD+LX.m
//  0926新浪微博
//
//  Created by xinliu on 14-10-30.
//  Copyright (c) 2014年 xinliu. All rights reserved.
//

#import "MBProgressHUD+LX.h"

@implementation MBProgressHUD (LX)

+ (void)show:(NSString *)text icon:(NSString *)icon toView:(UIView *)view
{
    if (!view) {
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hub.labelText = text;
    hub.mode = MBProgressHUDModeCustomView;
    hub.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:icon]];
    hub.removeFromSuperViewOnHide = YES;
    
    [hub hide:YES afterDelay:0.8];
}
+ (void)showSuccess:(NSString *)success
{
    [self show:success icon:@"MBProgressHUD.bundle/success.png" toView:Nil];
}
+ (void)showError:(NSString *)error
{
    [self show:error icon:@"MBProgressHUD.bundle/error.png" toView:Nil];
}
@end
