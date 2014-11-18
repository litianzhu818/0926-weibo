//
//  LXBaseParam.h
//  0926新浪微博
//
//  Created by xinliu on 14-10-18.
//  Copyright (c) 2014年 xinliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXBaseParam : NSObject

@property (copy,nonatomic) NSString *access_token;

+ (instancetype)param;

@end
