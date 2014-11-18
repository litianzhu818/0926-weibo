//
//  LXTabBarButton.m
//  0926新浪微博
//
//  Created by xinliu on 14-9-27.
//  Copyright (c) 2014年 xinliu. All rights reserved.
//

#import "LXTabBarButton.h"
#import "LXBadgeValueView.h"

#define kTabBarButtonImageRation 0.7

@interface LXTabBarButton ()
@property (weak,nonatomic) LXBadgeValueView *badgeView;
@end

@implementation LXTabBarButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.imageView setContentMode:UIViewContentModeCenter];
        
        [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self.titleLabel setFont:[UIFont systemFontOfSize:12]];
        
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        
        [self setBackgroundImage:[UIImage imageWithName:@"tabbar_slider"] forState:UIControlStateSelected];
        
    }
    return self;
}
- (void)setItem:(UITabBarItem *)item
{
    _item = item;
    
    [self setImage:item.image forState:UIControlStateNormal];
    [self setImage:item.selectedImage forState:UIControlStateSelected];
    [self setTitle:item.title forState:UIControlStateNormal];
    
    [item addObserver:self forKeyPath:@"badgeValue" options:0 context:nil];
    [self observeValueForKeyPath:@"badgeValue" ofObject:item change:nil context:nil];
}
- (void)setupBadgeView:(NSString *)badgeValue
{
    NSDictionary *attr = @{
                           NSFontAttributeName : self.badgeView.titleLabel.font
                           };
    CGRect rect = [badgeValue boundingRectWithSize:self.bounds.size options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:attr context:Nil];
    
    CGFloat X = self.imageView.image.size.width+10;
//    CGFloat X = self.frame.size.width / 2.0;
    CGFloat Y = 1.0;
    rect.origin.x = X;
    rect.origin.y = Y;
    self.badgeView.frame = rect;
    
    self.badgeView.badgeValue = badgeValue;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(UITabBarItem *)item change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"badgeValue"]) {
        int value = [item.badgeValue integerValue];
        if (value) {
            if (!self.badgeView) {
                LXBadgeValueView *badgeView = [[LXBadgeValueView alloc]init];
                [self.badgeView setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin];
                [self addSubview:badgeView];
                self.badgeView = badgeView;
            }
            [self setupBadgeView:item.badgeValue];
        }
        else{
            if (self.badgeView) {
                [self.badgeView removeFromSuperview];
            }
        }
    }
}
#pragma mark private method
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat X = 0.0;
    CGFloat Y = 0.0;
    CGFloat W = self.bounds.size.width;
    CGFloat H = self.bounds.size.height * kTabBarButtonImageRation;
    return CGRectMake(X, Y, W, H);
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat X = 0.0;
    CGFloat Y = self.bounds.size.height * kTabBarButtonImageRation - 2.0;
    CGFloat W = self.bounds.size.width;
    CGFloat H = self.bounds.size.height - self.bounds.size.height * kTabBarButtonImageRation;
    return CGRectMake(X, Y, W, H);
}
- (void)setHighlighted:(BOOL)highlighted{}
- (void)dealloc
{
    [self.item removeObserver:self forKeyPath:@"badgeValue"];
}
@end
