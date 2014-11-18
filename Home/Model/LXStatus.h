//
//  LXStatus.h
//  0926新浪微博
//
//  Created by xinliu on 14-9-29.
//  Copyright (c) 2014年 xinliu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LXUser;

@interface LXStatus : NSObject

@property (copy,nonatomic) NSString *created_at;
@property (copy,nonatomic) NSString *idstr;
@property (copy,nonatomic) NSString *text;
@property (copy,nonatomic) NSString *source;
@property (assign,nonatomic) int reposts_count;
@property (assign,nonatomic) int comments_count;
@property (assign,nonatomic) int attitudes_count;

//@property (copy,nonatomic) NSURL *thumbnail_pic;
@property (strong,nonatomic) NSArray *pic_urls;

@property (strong,nonatomic) LXStatus *retweeted_status;
@property (strong,nonatomic) LXUser *user;

@end
