//
//  LXUserUnreadResult.m
//  0926新浪微博
//
//  Created by xinliu on 14-10-18.
//  Copyright (c) 2014年 xinliu. All rights reserved.
//

#import "LXUserUnreadResult.h"

@implementation LXUserUnreadResult

- (NSInteger)totalUnreadMsg
{
    return _cmt + _dm + _mention_cmt + _mention_status;
}
- (NSInteger)totalUnreadCount
{
    return _status + self.totalUnreadMsg;
}

@end
