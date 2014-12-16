//
//  LXTopView.h
//  0926新浪微博
//
//  Created by xinliu on 14-10-5.
//  Copyright (c) 2014年 xinliu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LXStatusFrame;
@class LXTopView;
@class LXStatus;

@protocol LXTopViewDelegate <NSObject>

- (void)topView:(LXTopView *)topView didClickedStatus:(LXStatus *)status;

@end

@interface LXTopView : UIImageView

@property (strong,nonatomic) LXStatusFrame *statusFrame;
@property (weak,nonatomic) id<LXTopViewDelegate> delegate;

@end
