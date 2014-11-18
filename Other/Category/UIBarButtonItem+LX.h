//
//  UIBarButtonItem+LX.h
//  0926新浪微博
//
//  Created by xinliu on 14-9-27.
//  Copyright (c) 2014年 xinliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (LX)

+ (instancetype)barButtonItemWithImage:(NSString *)imageName selected:(NSString *)selectedImage target:(id)target action:(SEL)action;

@end
