//
//  LXReweetView.m
//  0926新浪微博
//
//  Created by xinliu on 14-10-5.
//  Copyright (c) 2014年 xinliu. All rights reserved.
//

#import "LXReweetView.h"
#import "LXStatusFrame.h"
#import "LXStatus.h"
#import "LXUser.h"
#import "UIImageView+WebCache.h"
#import "LXPhotoView.h"

@interface LXReweetView ()

@property (weak,nonatomic) UILabel *retweetNameLabel;
@property (weak,nonatomic) UILabel *retweetContentLabel;
@property (weak,nonatomic) LXPhotoView *retweetPhotoView;

@end

@implementation LXReweetView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        UIImage *image = [UIImage resizedImageName:@"timeline_retweet_background" leftCap:0.9 topCap:0.8];
        self.image = image;
        
        UILabel *retweetNameLabel = [[UILabel alloc]init];
        retweetNameLabel.font = kStatusNameLabelFont;
        [self addSubview:retweetNameLabel];
        self.retweetNameLabel = retweetNameLabel;
        
        UILabel *retweetContentLabel = [[UILabel alloc]init];
        retweetContentLabel.numberOfLines = 0;
        retweetContentLabel.font = kStatusContentLabelFont;
        [self addSubview:retweetContentLabel];
        self.retweetContentLabel = retweetContentLabel;
        
        LXPhotoView *retweetPhotoView = [[LXPhotoView alloc]init];
        [self addSubview:retweetPhotoView];
        self.retweetPhotoView = retweetPhotoView;
    }
    return self;
}
- (void)setStatusFrame:(LXStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    LXStatus *retweetStatus = statusFrame.status.retweeted_status;
    
    self.retweetNameLabel.text = [NSString stringWithFormat:@"@%@",retweetStatus.user.name];
    self.retweetNameLabel.frame = _statusFrame.retweetNameLabelF;
    
    self.retweetContentLabel.text = retweetStatus.text;
    self.retweetContentLabel.frame = _statusFrame.retweetContentLabelF;
    
    if (retweetStatus.pic_urls.count) {
        self.retweetPhotoView.hidden = NO;
//        [self.retweetPhotoView setImageWithURL:retweetStatus.thumbnail_pic placeholderImage:Nil];
        self.retweetPhotoView.frame = _statusFrame.retweetPhotoViewF;
        self.retweetPhotoView.photos = retweetStatus.pic_urls;
    }
    else{
        self.retweetPhotoView.hidden = YES;
    }
}

@end
