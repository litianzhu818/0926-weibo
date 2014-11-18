//
//  LXPhotoView.h
//  0926新浪微博
//
//  Created by xinliu on 14-10-18.
//  Copyright (c) 2014年 xinliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXPhotoView : UIView

@property (strong,nonatomic) NSArray *photos;

+ (CGSize)sizeWithPhotoCount:(NSInteger)count;

@end
