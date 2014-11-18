//
//  LXTabBar.h
//  0926新浪微博
//
//  Created by xinliu on 14-9-27.
//  Copyright (c) 2014年 xinliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LXTabBar;

@protocol LXTabBarDelegate <NSObject>

@optional
- (void)lxTabBar:(LXTabBar *)tabBar didSelectFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex;
- (void)lxTabBarDidSelectPlusButton:(LXTabBar *)tabBar;

@end

@interface LXTabBar : UIView

@property (weak,nonatomic)id<LXTabBarDelegate> delegate;
@property (assign,nonatomic) NSInteger defaultIndex;

- (void)addBarButtonWithItem:(UITabBarItem *)item;

@end
