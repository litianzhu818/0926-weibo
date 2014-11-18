//
//  LXAccountTool.h
//  0926新浪微博
//
//  Created by xinliu on 14-9-28.
//  Copyright (c) 2014年 xinliu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LXAccount.h"

@interface LXAccountTool : NSObject

+ (void)saveAccount:(LXAccount *)account;
+ (void)saveAccountWithDict:(NSDictionary *)dict;
+ (LXAccount *)requestAccount;
+ (LXAccount *)authroizedAccount;

@end
