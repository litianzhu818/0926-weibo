//
//  LXToolBarView.h
//  0926新浪微博
//
//  Created by xinliu on 14-10-5.
//  Copyright (c) 2014年 xinliu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LXStatus;

@interface LXToolBarView : UIImageView

+ (instancetype)toolBarView;
@property (strong,nonatomic) LXStatus *status;

@end
