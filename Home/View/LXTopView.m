//
//  LXTopView.m
//  0926新浪微博
//
//  Created by xinliu on 14-10-5.
//  Copyright (c) 2014年 xinliu. All rights reserved.
//

#import "LXTopView.h"
#import "LXStatusFrame.h"
#import "LXStatus.h"
#import "LXUser.h"
#import "UIImageView+WebCache.h"
#import "LXReweetView.h"
#import "LXPhotoView.h"

@interface LXTopView ()

@property (weak,nonatomic) UIImageView *iconView;
@property (weak,nonatomic) UILabel *nameLabel;
@property (weak,nonatomic) UIImageView *vipView;
@property (weak,nonatomic) UILabel *timeLabel;
@property (weak,nonatomic) UILabel *sourceLabel;
@property (weak,nonatomic) UILabel *contentLabel;
@property (weak,nonatomic) LXPhotoView *photoView;

@property (weak,nonatomic) LXReweetView *retweetView;

@end

@implementation LXTopView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        [self setImage:[UIImage resizedImageName:@"timeline_card_top_background"]];
        [self setHighlightedImage:[UIImage resizedImageName:@"timeline_card_top_background_highlighted"]];
        
        [self setupOriginView];
        [self setupRetweetView];
    }
    return self;
}
#pragma mark - addViews
- (void)setupOriginView
{
    UIImageView *iconView = [[UIImageView alloc]init];
    [self addSubview:iconView];
    self.iconView = iconView;
    
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.font = kStatusNameLabelFont;
    [self addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    UIImageView *vipView = [[UIImageView alloc]init];
    [self addSubview:vipView];
    self.vipView = vipView;
    
    UILabel *timeLabel = [[UILabel alloc]init];
    timeLabel.font = kStatusTimeLabelFont;
    [self addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    UILabel *sourceLabel = [[UILabel alloc]init];
    sourceLabel.font = kStatusSourceLabelFont;
    [self addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
    
    UILabel *contentLabel = [[UILabel alloc]init];
    contentLabel.font = kStatusContentLabelFont;
    contentLabel.numberOfLines = 0;
    [self addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    LXPhotoView *photoView = [[LXPhotoView alloc]init];
    [self addSubview:photoView];
    self.photoView = photoView;
}
- (void)setupRetweetView
{
    LXReweetView *retweetView = [[LXReweetView alloc]init];
    
    [self addSubview:retweetView];
    self.retweetView = retweetView;
}
#pragma mark - update data
- (void)setStatusFrame:(LXStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    [self setupOriginViewData];
    [self setupReweetViewData];
}
- (void)setupOriginViewData
{
    LXStatus *status = _statusFrame.status;
    LXUser *user = status.user;
    
    [self.iconView setImageWithURL:status.user.profile_image_url placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    self.iconView.frame = _statusFrame.iconViewF;
    
    self.nameLabel.text = status.user.name;
    self.nameLabel.frame = _statusFrame.nameLabelF;
    
    if (user.mbtype) {
        self.vipView.hidden = NO;
        NSString *name = [NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank];
        if (name) {
            [self.vipView setImage:[UIImage imageWithName:name]];
            self.vipView.frame = _statusFrame.vipViewF;
            
            self.nameLabel.textColor = [UIColor orangeColor];
        }
    }
    else{
        //        self.vipView.frame = CGRectZero;
        self.vipView.hidden = YES;
        
        self.nameLabel.textColor = [UIColor blackColor];
    }
    
    self.timeLabel.text = status.created_at;
    CGFloat timeLabelX = _statusFrame.nameLabelF.origin.x;
    CGFloat timeLabelY = CGRectGetMaxY(_statusFrame.nameLabelF) + kStatusViewMargin;
    CGSize timeLabelSize = [self.timeLabel.text sizeWithAttributes:@{NSFontAttributeName:kStatusTimeLabelFont}];
    self.timeLabel.frame = (CGRect){{timeLabelX,timeLabelY},timeLabelSize};
    
    self.sourceLabel.text = status.source;
    CGFloat sourceLabelX = CGRectGetMaxX(self.timeLabel.frame)+kStatusViewMargin;
    CGFloat sourceLabelY = timeLabelY;
    //    NSString *sourceStr = [NSString stringWithFormat:@"来自%@",status.source];
    CGSize sourceLabelSize = [status.source sizeWithAttributes:@{NSFontAttributeName:kStatusSourceLabelFont}];
    self.sourceLabel.frame = (CGRect){{sourceLabelX,sourceLabelY},sourceLabelSize};
    
    self.contentLabel.text = status.text;
    self.contentLabel.frame = _statusFrame.contentLabelF;
    
    if (status.pic_urls.count) {
        self.photoView.hidden = NO;
//        [self.photoView setImageWithURL:status.thumbnail_pic placeholderImage:Nil];
        self.photoView.frame = _statusFrame.photoViewF;
        self.photoView.photos = status.pic_urls;
    }
    else{
        //        self.photoView.frame = CGRectZero;
        self.photoView.hidden = YES;
    }
    //    self.photoView.frame = _statusFrame.photoViewF;
}
- (void)setupReweetViewData
{
    LXStatus *retweetStatus = _statusFrame.status.retweeted_status;
    if (retweetStatus) {
        self.retweetView.hidden = NO;
        self.retweetView.frame = _statusFrame.retweetViewF;
        self.retweetView.statusFrame = _statusFrame;
    }
    else{
        self.retweetView.hidden = YES;
    }
}
@end
