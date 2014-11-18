//
//  LXStatus.m
//  0926新浪微博
//
//  Created by xinliu on 14-9-29.
//  Copyright (c) 2014年 xinliu. All rights reserved.
//

#import "LXStatus.h"
#import "NSDate+LX.h"

@implementation LXStatus

- (NSString *)created_at
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    formatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    
    NSDate *theDate = [formatter dateFromString:_created_at];
    NSDate *currentDate = [NSDate date];
    
    NSString *theFormattedDate = Nil;
    if ([NSDate isToday:theDate]) {
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *comps = [calendar components:NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:theDate toDate:currentDate options:0];
        if (comps.hour == 0 && comps.minute == 0) {
            theFormattedDate = @"刚刚";
        }
        else if(comps.hour == 0){
            theFormattedDate = [NSString stringWithFormat:@"%d分钟前",comps.minute];
        }
        else{
            theFormattedDate = [NSString stringWithFormat:@"%d小时前",comps.hour];
        }
    }
    else if([NSDate isThisYear:theDate]){
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat = @"MM-dd HH:mm:ss";
        theFormattedDate =  [formatter stringFromDate:theDate];
    }
    else{
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat = @"yyyy-MM-dd";
        theFormattedDate =  [formatter stringFromDate:theDate];
    }
    
    return theFormattedDate;
}
- (void)setSource:(NSString *)source
{
    if (source.length == 0) {
        source = @"<>未知</>";
    }

    NSRange range1 = [source rangeOfString:@">"];
    NSRange range2 = [source rangeOfString:@"</"];
    
    NSRange range = NSMakeRange(range1.location+1, range2.location-range1.location-1);
    if ([source substringWithRange:range]) {
        _source = [source substringWithRange:range];
    }
    
    NSString *newSource = [NSString stringWithFormat:@"来自%@",_source];
    _source = newSource;
}

@end
