//
//  LXAccountTool.m
//  0926新浪微博
//
//  Created by xinliu on 14-9-28.
//  Copyright (c) 2014年 xinliu. All rights reserved.
//

#import "LXAccountTool.h"

@implementation LXAccountTool

+ (void)saveAccountWithDict:(NSDictionary *)dict
{
    LXAccount *account = [LXAccount accountWithDict:dict];
    [self saveAccount:account];
}
+ (void)saveAccount:(LXAccount *)account
{
    NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *file = [docDir stringByAppendingPathComponent:@"account.data"];
    [NSKeyedArchiver archiveRootObject:account toFile:file];
}
+ (LXAccount *)requestAccount
{
    NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *file = [docDir stringByAppendingPathComponent:@"account.data"];
    
    LXAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:file];
    if ([account.expiresDate compare:[NSDate date]] == NSOrderedAscending || !account) {
        account = Nil;
    }
    
    return account;
}
+ (LXAccount *)authroizedAccount
{
    return ([self requestAccount]);
}

@end
