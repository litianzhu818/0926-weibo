//
//  LXMainViewController.m
//  0926新浪微博
//
//  Created by xinliu on 14-9-26.
//  Copyright (c) 2014年 xinliu. All rights reserved.
//

#import "LXMainViewController.h"
#import "LXNavViewController.h"
#import "LXHomeViewController.h"
#import "LXProfileViewController.h"
#import "LXMessageViewController.h"
#import "LXDiscoverViewController.h"
#import "LXComposeViewController.h"

#import "LXTabBar.h"

#import "LXAccountTool.h"

@interface LXMainViewController () <LXTabBarDelegate>

@property (weak,nonatomic) LXTabBar *customTabBar;
@property (weak,nonatomic) LXHomeViewController *home;
@property (weak,nonatomic) LXMessageViewController *message;
@property (weak,nonatomic) LXProfileViewController *profile;

@end

@implementation LXMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addCustomTabBar];
    [self addViewControllers];
}
#pragma mark - custom tabbar
#pragma mark add CustomTabbar
- (void)addCustomTabBar
{
    LXTabBar *customTabBar = [[LXTabBar alloc]init];
    customTabBar.frame = self.tabBar.bounds;
    customTabBar.delegate = self;
    [self.tabBar addSubview:customTabBar];
    _customTabBar = customTabBar;
}
#pragma mark remove system tabbarButton
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}
#pragma mark customTabbar delegate
- (void)lxTabBar:(LXTabBar *)tabBar didSelectFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex
{
    self.selectedIndex = toIndex;
    if (toIndex == 0) {
        [self.home refresh];
    }
}
- (void)lxTabBarDidSelectPlusButton:(LXTabBar *)tabBar
{
    LXComposeViewController *compose = [[LXComposeViewController alloc]init];
    LXNavViewController *nav = [[LXNavViewController alloc]initWithRootViewController:compose];
    [self presentViewController:nav animated:YES completion:Nil];
}

#pragma mark - add viewController
- (void)addViewControllers
{
    LXHomeViewController *home = [[LXHomeViewController alloc]initWithUpdateDataBlock:^{
//        [self checkUnreadMsg];
    }];
    self.home = home;
//     home.tabBarItem.badgeValue = @"8";
    [self setupChildController:home Title:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    
    LXMessageViewController *message = [[LXMessageViewController alloc]init];
    self.message = message;
//    message.tabBarItem.badgeValue = @"898";
    [self setupChildController:message Title:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    
    LXDiscoverViewController *discover = [[LXDiscoverViewController alloc]init];
//    discover.tabBarItem.badgeValue = @"18";
    [self setupChildController:discover Title:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    
    LXProfileViewController *profile = [[LXProfileViewController alloc]init];
    self.profile = profile;
    [self setupChildController:profile Title:@"我" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
}
- (void)setupChildController:(UIViewController *)controller Title:(NSString *)title image:(NSString *)imageName selectedImage:(NSString *)selectedImageName
{
    controller.title = title;
    controller.tabBarItem.image = [[UIImage imageWithName:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.tabBarItem.selectedImage = [[UIImage imageWithName:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    LXNavViewController *nav = [[LXNavViewController alloc]initWithRootViewController:controller];
    [self addChildViewController:nav];
    
    [self.customTabBar addBarButtonWithItem:controller.tabBarItem];
}

@end
