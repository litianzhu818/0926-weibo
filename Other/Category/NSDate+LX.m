//
//  NSDate+LX.m
//  0926新浪微博
//
//  Created by xinliu on 14-10-3.
//  Copyright (c) 2014年 xinliu. All rights reserved.
//

#import "NSDate+LX.h"

@implementation NSDate (LX)

+ (BOOL)isToday:(NSDate *)theDate
{
    NSDate *currentDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:theDate toDate:currentDate options:0];
    return (comps.year == 0 && comps.month == 0 && comps.day == 0);
}
+ (BOOL)isThisYear:(NSDate *)theDate
{
    NSDate *currentDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:NSCalendarUnitYear fromDate:theDate toDate:currentDate options:0];
    return (comps.year == 0);
}
+ (BOOL)isYesterday:(NSDate *)theDate
{
    NSDateComponents *comps = [[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:theDate toDate:[NSDate date] options:0];
    
    return (comps.day == 1);
    
}
@end
