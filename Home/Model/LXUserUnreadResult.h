//
//  LXUserUnreadResult.h
//  0926新浪微博
//
//  Created by xinliu on 14-10-18.
//  Copyright (c) 2014年 xinliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXUserUnreadResult : NSObject

@property (assign,nonatomic) int status;
@property (assign,nonatomic) int follower;
@property (assign,nonatomic) int cmt;
@property (assign,nonatomic) int dm;
@property (assign,nonatomic) int mention_status;
@property (assign,nonatomic) int mention_cmt;

- (NSInteger)totalUnreadCount;
- (NSInteger)totalUnreadMsg;

@end
