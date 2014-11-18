//
//  NSDate+LX.h
//  0926新浪微博
//
//  Created by xinliu on 14-10-3.
//  Copyright (c) 2014年 xinliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (LX)

+ (BOOL)isToday:(NSDate *)theDate;
+ (BOOL)isThisYear:(NSDate *)theDate;
+ (BOOL)isYesterday:(NSDate *)theDate;

@end
