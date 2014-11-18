//
//  UIButton+LX.m
//  UIButton
//
//  Created by xinliu on 14-9-28.
//  Copyright (c) 2014年 xinliu. All rights reserved.
//

#import "UIButton+LX.h"

@implementation UIButton (LX)
+ (instancetype)buttonWithImageOnTop:(UIImage *)image string:(NSString *)str font:(UIFont *)font marginHorizon:(CGFloat)marginHorizon marginVertical:(CGFloat)marginVertical
{
    CGSize strSize = [str sizeWithAttributes:@{NSFontAttributeName : font}];
    CGSize imgSize = image.size;
    
    CGFloat btnH = strSize.height + imgSize.height;
    CGFloat btnW = strSize.width > imgSize.width ? strSize.width : imgSize.width;
    CGSize btnSize = CGSizeMake(btnW, btnH);
    
    UIButton *button = [[UIButton alloc]init];
    button.bounds = (CGRect){CGPointZero,btnSize};
    
    [button setBackgroundColor:[UIColor lightGrayColor]];
    [button.titleLabel setFont:font];
    [button setImage:image forState:UIControlStateNormal];
    [button setTitle:str forState:UIControlStateNormal];
    
    CGPoint imgFinalCenter = CGPointMake(btnSize.width*0.5, imgSize.height*0.5);
    CGPoint imgBeginCenter = button.imageView.center;
    CGPoint titleFinalCenter = CGPointMake(btnSize.width*0.5, btnSize.height-strSize.height*0.5);
    CGPoint titleBeginCenter = button.titleLabel.center;
    
    CGFloat titleEdgeInsetsTop = titleFinalCenter.y - titleBeginCenter.y;
    CGFloat titleEdgeInsetsBottom = - titleEdgeInsetsTop;
    CGFloat titleEdgeInsetsLeft = titleFinalCenter.x - titleBeginCenter.x - imgSize.width*0.5;
    CGFloat titleEdgeInsetsRight = - titleEdgeInsetsLeft - imgSize.width;
    
    CGFloat imgEdgeInsetsTop = imgFinalCenter.y - imgBeginCenter.y;
    CGFloat imgEdgeInsetsBottom = -imgEdgeInsetsTop;
    CGFloat imgEdgeInsetsLeft = imgFinalCenter.x - imgBeginCenter.x;
    CGFloat imgEdgeInsetsRight = -imgEdgeInsetsLeft;
    
    button.titleEdgeInsets = UIEdgeInsetsMake(titleEdgeInsetsTop, titleEdgeInsetsLeft, titleEdgeInsetsBottom, titleEdgeInsetsRight);
    button.imageEdgeInsets = UIEdgeInsetsMake(imgEdgeInsetsTop, imgEdgeInsetsLeft, imgEdgeInsetsBottom, imgEdgeInsetsRight);
    
    btnH += 2*marginVertical;
    btnW += 2*marginHorizon;
    btnSize = CGSizeMake(btnW, btnH);
    
    button.bounds = (CGRect){CGPointZero,btnSize};
    
    return button;
}
+ (instancetype)buttonWithImageOnRight:(UIImage *)image string:(NSString *)str font:(UIFont *)font marginHorizon:(CGFloat)marginHorizon marginVertical:(CGFloat)marginVertical
{
    CGSize strSize = [str sizeWithAttributes:@{NSFontAttributeName : font}];
    CGSize imgSize = image.size;
    
    CGFloat btnW = strSize.width + imgSize.width;
    CGFloat btnH = strSize.height > imgSize.height ? strSize.height : imgSize.height;
    CGSize btnSize = CGSizeMake(btnW, btnH);
    
    UIButton *button = [[UIButton alloc]init];
    button.bounds = (CGRect){CGPointZero,btnSize};
    
    [button setBackgroundColor:[UIColor lightGrayColor]];
    [button.titleLabel setFont:font];
    [button setImage:image forState:UIControlStateNormal];
    [button setTitle:str forState:UIControlStateNormal];
    
    CGPoint titleFinalCenter = CGPointMake((btnSize.width-imgSize.width)*0.5, btnSize.height*0.5);
    CGPoint titleBeginCenter = button.titleLabel.center;
    CGPoint imgFinalCenter = CGPointMake(btnSize.width-imgSize.width*0.5, btnSize.height*0.5);
    CGPoint imgBeginCenter = button.imageView.center;
    
    CGFloat titleEdgeInsetsTop = titleFinalCenter.y - titleBeginCenter.y;
    CGFloat titleEdgeInsetsBottom = - titleEdgeInsetsTop;
    CGFloat titleEdgeInsetsLeft = titleFinalCenter.x - titleBeginCenter.x;
    CGFloat titleEdgeInsetsRight = - titleEdgeInsetsLeft;
    
    CGFloat imgEdgeInsetsTop = imgFinalCenter.y - imgBeginCenter.y;
    CGFloat imgEdgeInsetsBottom = -imgEdgeInsetsTop;
    CGFloat imgEdgeInsetsLeft = imgFinalCenter.x - imgBeginCenter.x;
    CGFloat imgEdgeInsetsRight = -imgEdgeInsetsLeft;
    
    button.titleEdgeInsets = UIEdgeInsetsMake(titleEdgeInsetsTop, titleEdgeInsetsLeft, titleEdgeInsetsBottom, titleEdgeInsetsRight);
    button.imageEdgeInsets = UIEdgeInsetsMake(imgEdgeInsetsTop, imgEdgeInsetsLeft, imgEdgeInsetsBottom, imgEdgeInsetsRight);
    
    btnH += 2*marginVertical;
    btnW += 2*marginHorizon;
    btnSize = CGSizeMake(btnW, btnH);
    
    button.bounds = (CGRect){CGPointZero,btnSize};
    
    return button;
}

@end
