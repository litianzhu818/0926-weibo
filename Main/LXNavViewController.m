//
//  LXNavViewController.m
//  0926新浪微博
//
//  Created by xinliu on 14-9-27.
//  Copyright (c) 2014年 xinliu. All rights reserved.
//

#import "LXNavViewController.h"

@interface LXNavViewController ()

@end

@implementation LXNavViewController
+ (void)initialize
{
    [self setupTabBarApperance];
    [self setupButtonApperance];
}
#pragma mark - setup apperance
+ (void)setupTabBarApperance
{
    UINavigationBar *bar = [UINavigationBar appearance];
    NSDictionary *attr = @{
                           NSFontAttributeName : [UIFont boldSystemFontOfSize:19]
                           };
    bar.titleTextAttributes = attr;
}
+ (void)setupButtonApperance
{
    UIBarButtonItem *button = [UIBarButtonItem appearance];
    NSDictionary *attr = @{
                           NSFontAttributeName : [UIFont boldSystemFontOfSize:14],
                           NSForegroundColorAttributeName : [UIColor orangeColor]
                           };
    [button setTitleTextAttributes:attr forState:UIControlStateNormal];
    [button setTitleTextAttributes:attr forState:UIControlStateHighlighted];
    
    NSDictionary *disableAttr = @{NSForegroundColorAttributeName: [UIColor lightGrayColor]};
    [button setTitleTextAttributes:disableAttr forState:UIControlStateDisabled];
}
#pragma mark - private method
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}
@end
