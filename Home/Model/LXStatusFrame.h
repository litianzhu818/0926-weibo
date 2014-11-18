//
//  LXStatusFrame.h
//  0926新浪微博
//
//  Created by xinliu on 14-9-29.
//  Copyright (c) 2014年 xinliu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LXStatus;

@interface LXStatusFrame : NSObject

@property (assign,readonly,nonatomic) CGFloat statusHeight;
@property (strong,nonatomic) LXStatus *status;

@property (assign,readonly,nonatomic) CGRect topViewF;
@property (assign,readonly,nonatomic) CGRect iconViewF;
@property (assign,readonly,nonatomic) CGRect nameLabelF;
@property (assign,readonly,nonatomic) CGRect vipViewF;
@property (assign,readonly,nonatomic) CGRect timeLabelF;
@property (assign,readonly,nonatomic) CGRect sourceLabelF;
@property (assign,readonly,nonatomic) CGRect contentLabelF;
@property (assign,readonly,nonatomic) CGRect photoViewF;

@property (assign,readonly,nonatomic) CGRect retweetViewF;
@property (assign,readonly,nonatomic) CGRect retweetNameLabelF;
@property (assign,readonly,nonatomic) CGRect retweetContentLabelF;
@property (assign,readonly,nonatomic) CGRect retweetPhotoViewF;

@property (assign,readonly,nonatomic) CGRect toolBarViewF;

@end
