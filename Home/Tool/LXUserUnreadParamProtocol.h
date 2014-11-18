//
//  LXUserUnreadParamProtocol.h
//  0926新浪微博
//
//  Created by xinliu on 14-10-18.
//  Copyright (c) 2014年 xinliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LXUserUnreadParamProtocol <NSObject>

@property (strong,nonatomic) NSNumber *uid;
@property (copy,nonatomic) NSString *access_token;

@end
