//
//  LXAccount.m
//  0926新浪微博
//
//  Created by xinliu on 14-9-28.
//  Copyright (c) 2014年 xinliu. All rights reserved.
//

#import "LXAccount.h"

@implementation LXAccount

+ (LXAccount *)accountWithDict:(NSDictionary *)dict
{
    return [[LXAccount alloc]initWithDict:dict];
}
- (id)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
        NSDate *now = [NSDate date];
        self.expiresDate = [now dateByAddingTimeInterval:self.expires_in];
    }
    return self;
}
#pragma mark - NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeInt64:self.expires_in forKey:@"expires_in"];
    [aCoder encodeInt64:self.uid forKey:@"uid"];
    [aCoder encodeInt64:self.remind_in forKey:@"remind_in"];
    [aCoder encodeObject:self.expiresDate forKey:@"expiresDate"];
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.expiresDate = [aDecoder decodeObjectForKey:@"expiresDate"];
        self.expires_in = [aDecoder decodeInt64ForKey:@"expires_in"];
        self.remind_in = [aDecoder decodeInt64ForKey:@"remind_in"];
        self.uid = [aDecoder decodeInt64ForKey:@"uid"];
    }
    return self;
}
@end
