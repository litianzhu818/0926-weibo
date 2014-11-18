//
//  LXTitleView.m
//  0926新浪微博
//
//  Created by xinliu on 14-9-27.
//  Copyright (c) 2014年 xinliu. All rights reserved.
//

#import "LXTitleView.h"

#define kTitleViewImageWidth 20.0

@implementation LXTitleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundImage:[UIImage resizedImage:[UIImage imageWithName:@"navigationbar_filter_background_highlighted"]] forState:UIControlStateHighlighted];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.titleLabel setTextAlignment:NSTextAlignmentRight];
        
        [self.imageView setContentMode:UIViewContentModeCenter];
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat X = contentRect.size.width - kTitleViewImageWidth;
    CGFloat Y = 0.0;
    CGFloat W = kTitleViewImageWidth;
    CGFloat H = contentRect.size.height;
    return CGRectMake(X, Y, W, H);
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat X = 0.0;
    CGFloat Y = 0.0;
    CGFloat W = contentRect.size.width - kTitleViewImageWidth;
    CGFloat H = contentRect.size.height;
    return CGRectMake(X, Y, W, H);
}
@end
