//
//  UIBarButtonItem+LX.m
//  0926新浪微博
//
//  Created by xinliu on 14-9-27.
//  Copyright (c) 2014年 xinliu. All rights reserved.
//

#import "UIBarButtonItem+LX.h"

@implementation UIBarButtonItem (LX)

+ (UIBarButtonItem *)barButtonItemWithImage:(NSString *)imageName selected:(NSString *)selectedImage target:(id)target action:(SEL)action
{
    UIButton *button = [[UIButton alloc]init];
    [button setImage:[UIImage imageWithName:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageWithName:selectedImage] forState:UIControlStateHighlighted];
    
    button.bounds = (CGRect){CGPointZero,button.imageView.image.size};
    [button addTarget:target action:action forControlEvents:UIControlEventTouchDown];
    
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}

@end
