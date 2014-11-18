//
//  LXWeiboTool.m
//  0926新浪微博
//
//  Created by xinliu on 14-9-28.
//  Copyright (c) 2014年 xinliu. All rights reserved.
//

#import "LXWeiboTool.h"
#import "LXAccountTool.h"
#import "LXMainViewController.h"
#import "LXOAuthViewController.h"

@implementation LXWeiboTool

+ (void)launchApp
{
    UIViewController *main = Nil;
    if ([LXAccountTool authroizedAccount]) {
        main = [[LXMainViewController alloc]init];
    }
    else{
        main = [[LXOAuthViewController alloc]init];
    }
    
    [UIApplication sharedApplication].keyWindow.rootViewController = main;
}

@end
