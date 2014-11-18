//
//  LXMsgButton.m
//  0926新浪微博
//
//  Created by xinliu on 14-10-12.
//  Copyright (c) 2014年 xinliu. All rights reserved.
//

#import "LXMsgButton.h"

@implementation LXMsgButton

- (id)init
{
    self = [super init];
    if (self) {
        [self setBackgroundImage:[UIImage resizedImageName:@"timeline_new_status_background"] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [self.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
        self.userInteractionEnabled = NO;
    }
    return self;
}

@end
