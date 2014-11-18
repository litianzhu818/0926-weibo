//
//  LXStatusTool.m
//  0926新浪微博
//
//  Created by xinliu on 14-10-18.
//  Copyright (c) 2014年 xinliu. All rights reserved.
//

#import "LXStatusTool.h"
#import "LXHttpTool.h"
//#import "MJExtension.h"
#import "NSObject+LXDict.h"

@implementation LXStatusTool

+ (void)unreadCountWithParam:(LXUserUnreadParam *)param success:(void (^)(LXUserUnreadResult *))success failure:(void (^)(NSError *))failure
{
    [LXHttpTool getWithURL:kLXUserUnread_urlString params:param.keyedDictFromModel success:^(id responseObject) {
        if (success) {
//            LXUserUnreadResult *result = [LXUserUnreadResult objectWithKeyValues:responseObject];
//            [result setValuesForKeysWithDictionary:responseObject];
            LXUserUnreadResult *result = [LXUserUnreadResult objectWithKeyedDict:responseObject];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
