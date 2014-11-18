//
//  LXUserUnreadParam.h
//  0926新浪微博
//
//  Created by xinliu on 14-10-18.
//  Copyright (c) 2014年 xinliu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LXBaseParam.h"
#import "LXUserUnreadParamProtocol.h"

@interface LXUserUnreadParam : LXBaseParam  <LXUserUnreadParamProtocol>

@property (strong,nonatomic) NSNumber *uid;

@end
