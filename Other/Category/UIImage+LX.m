//
//  UIImage+LX.m
//  0926新浪微博
//
//  Created by xinliu on 14-9-27.
//  Copyright (c) 2014年 xinliu. All rights reserved.
//

#import "UIImage+LX.h"

@implementation UIImage (LX)

+ (UIImage *)imageWithName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];

    if (IOS7) {
        NSString *name = [NSString stringWithFormat:@"%@_os7",imageName];
        UIImage *imageOS7 = [UIImage imageNamed:name];
        if (imageOS7) {
            return imageOS7;
        }
    }
    return image;
}
+ (UIImage *)resizedImage:(UIImage *)image
{
    return [image stretchableImageWithLeftCapWidth:image.size.width*0.5 topCapHeight:image.size.height*0.5];
}
+ (UIImage *)resizedImageName:(NSString *)imageName
{
    return [self resizedImage:[UIImage imageWithName:imageName]];
}
+ (UIImage *)resizedImageName:(NSString *)imageName leftCap:(CGFloat)leftCap topCap:(CGFloat)topCap
{
    UIImage *image = [UIImage imageWithName:imageName];
    return [image stretchableImageWithLeftCapWidth:image.size.width*leftCap topCapHeight:image.size.height*topCap];
}

@end
