//
//  UIButton+LX.h
//  UIButton
//
//  Created by xinliu on 14-9-28.
//  Copyright (c) 2014年 xinliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (LX)
+ (instancetype)buttonWithImageOnTop:(UIImage *)image string:(NSString *)str font:(UIFont *)font marginHorizon:(CGFloat)marginHorizon marginVertical:(CGFloat)marginVertical;
+ (instancetype)buttonWithImageOnRight:(UIImage *)image string:(NSString *)str font:(UIFont *)font marginHorizon:(CGFloat)marginHorizon marginVertical:(CGFloat)marginVertical;;
@end
