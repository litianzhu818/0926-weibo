//
//  UIImage+LX.h
//  0926新浪微博
//
//  Created by xinliu on 14-9-27.
//  Copyright (c) 2014年 xinliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LX)

+ (UIImage *)imageWithName:(NSString *)imageName;
+ (UIImage *)resizedImage:(UIImage *)image;
+ (UIImage *)resizedImageName:(NSString *)imageName;
+ (UIImage *)resizedImageName:(NSString *)imageName leftCap:(CGFloat)leftCap topCap:(CGFloat)topCap;

@end
