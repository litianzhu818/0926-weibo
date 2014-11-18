//
//  LXStatusTool.h
//  0926新浪微博
//
//  Created by xinliu on 14-10-18.
//  Copyright (c) 2014年 xinliu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LXUserUnreadParamProtocol.h"
#import "LXUserUnreadParam.h"
#import "LXUserUnreadResult.h"

@interface LXStatusTool : NSObject

+ (void)unreadCountWithParam:(id<LXUserUnreadParamProtocol>)param success:(void (^)(LXUserUnreadResult *result))success failure:(void (^)(NSError *error))failure;

@end
