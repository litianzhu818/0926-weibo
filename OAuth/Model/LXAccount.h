//
//  LXAccount.h
//  0926新浪微博
//
//  Created by xinliu on 14-9-28.
//  Copyright (c) 2014年 xinliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXAccount : NSObject <NSCoding>

@property (copy,nonatomic) NSString *access_token;
@property (assign,nonatomic) long long expires_in;
@property (assign,nonatomic) long long remind_in;
@property (assign,nonatomic) long long uid;

@property (strong,nonatomic) NSDate *expiresDate;

+ (LXAccount *)accountWithDict:(NSDictionary *)dict;

@end
