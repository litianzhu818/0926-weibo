//
//  LXTabBar.m
//  0926新浪微博
//
//  Created by xinliu on 14-9-27.
//  Copyright (c) 2014年 xinliu. All rights reserved.
//

#import "LXTabBar.h"
#import "LXTabBarButton.h"

#define kLXTabBarButtonStartTag 10

@interface LXTabBar ()

@property (weak,nonatomic) LXTabBarButton   *selectedButton;
@property (weak,nonatomic) UIButton         *plusButton;

@end

@implementation LXTabBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageWithName:@"tabbar_background"]]];
        self.defaultIndex = 1;
        UIButton *plusButton = [self setupPlusButton];
        [self addSubview:plusButton];
        self.plusButton = plusButton;
    }
    return self;
}
#pragma mark - add BarButtonItem
- (void)addBarButtonWithItem:(UITabBarItem *)item
{
    LXTabBarButton *button = [[LXTabBarButton alloc]init];
    button.item = item;
    [button addTarget:self action:@selector(clickOnButton:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:button];
}
- (void)clickOnButton:(LXTabBarButton *)button
{
    if ([self.delegate respondsToSelector:@selector(lxTabBar:didSelectFromIndex:toIndex:)]) {
        [self.delegate lxTabBar:self didSelectFromIndex:self.selectedButton.tag-kLXTabBarButtonStartTag toIndex:button.tag-kLXTabBarButtonStartTag];
    }
    
    _selectedButton.selected = NO;
    _selectedButton = button;
    _selectedButton.selected = YES;
}
#pragma mark - private method
#pragma mark layoutSubviews
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat W = self.bounds.size.width / self.subviews.count;
    CGFloat H = self.bounds.size.height;
    CGFloat Y = 0;
    
    CGFloat plusButtonX = self.subviews.count/2 * W;
    self.plusButton.frame = CGRectMake(plusButtonX, Y, W, H);
    
    for (int i=0; i<self.subviews.count-1; i++) {
        CGFloat X = W * i;
        if (X >= plusButtonX) {
            X += W;
        }
        LXTabBarButton *btn = self.subviews[i+1];
        btn.tag = kLXTabBarButtonStartTag + i;
        btn.frame = CGRectMake(X, Y, W, H);
    }
    
    [self setDefaultIndex:_defaultIndex];
}
#pragma mark defaultIndex
- (void)setDefaultIndex:(NSInteger)defaultIndex
{
    _defaultIndex = defaultIndex;
    if (defaultIndex < self.subviews.count) {
        _selectedButton = self.subviews[defaultIndex];
        _selectedButton.selected = YES;
    }
}
#pragma mark plusButton
- (UIButton *)setupPlusButton
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button_highlighted"] forState:UIControlStateSelected];
    
    [btn setImage:[UIImage imageWithName:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
    [btn setImage:[UIImage imageWithName:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickPlusButton) forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}
- (void)clickPlusButton
{
    if ([self.delegate respondsToSelector:@selector(lxTabBarDidSelectPlusButton:)]) {
        [self.delegate lxTabBarDidSelectPlusButton:self];
    }
}
@end
