//
//  LXBaseParam.m
//  0926新浪微博
//
//  Created by xinliu on 14-10-18.
//  Copyright (c) 2014年 xinliu. All rights reserved.
//

#import "LXBaseParam.h"
#import "LXAccountTool.h"

@implementation LXBaseParam
- (id)init
{
    self = [super init];
    if (self) {
        self.access_token = [LXAccountTool requestAccount].access_token;
    }
    return self;
}
+ (instancetype)param
{
    return [[self alloc]init];
}
@end
