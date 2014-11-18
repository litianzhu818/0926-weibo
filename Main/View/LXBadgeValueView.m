//
//  LXBadgeValueView.m
//  0926新浪微博
//
//  Created by xinliu on 14-9-27.
//  Copyright (c) 2014年 xinliu. All rights reserved.
//

#import "LXBadgeValueView.h"

@implementation LXBadgeValueView

- (id)init
{
    self = [super init];
    if (self) {
        [self setBackgroundImage:[UIImage resizedImage:[UIImage imageWithName:@"main_badge"]] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:11.0];
        self.userInteractionEnabled = NO;
    }
    return self;
}
- (void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = badgeValue;
    
    CGRect frame = self.frame;
    frame.size = self.currentBackgroundImage.size;
    self.frame = frame;
    
    [self setTitle:badgeValue forState:UIControlStateNormal];
    if (badgeValue.length > 2) {
        [self setTitle:@"99+" forState:UIControlStateNormal];
        CGSize size = [badgeValue sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16]}];
        frame.size = size;
        self.frame = frame;
    }
}
@end
