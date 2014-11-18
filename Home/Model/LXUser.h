//
//  LXUser.h
//  0926新浪微博
//
//  Created by xinliu on 14-9-29.
//  Copyright (c) 2014年 xinliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXUser : NSObject

@property (copy,nonatomic) NSString *idstr;
@property (copy,nonatomic) NSString *name;
@property (copy,nonatomic) NSURL *profile_image_url;
@property (assign,nonatomic,getter = isVip) BOOL vip;


@property (nonatomic, assign) int mbrank;
@property (nonatomic, assign) int mbtype;

@end
