//
//  LXStatusFrame.m
//  0926新浪微博
//
//  Created by xinliu on 14-9-29.
//  Copyright (c) 2014年 xinliu. All rights reserved.
//

#import "LXStatusFrame.h"
#import "LXStatus.h"
#import "LXUser.h"
#import "LXPhotoView.h"

@implementation LXStatusFrame
- (void)setStatus:(LXStatus *)status
{
    _status = status;
    [self setupFrame];
}
- (void)setupFrame
{
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width - 2*kStatusTableBorder;
    
    CGFloat topViewX = 0.0;
    CGFloat topViewY = 0.0;
    CGFloat topViewW = cellW;
    CGFloat topViewH = 0.0;
    
    CGFloat iconViewX = kStatusCellBorder;
    CGFloat iconViewY = kStatusCellBorder;
    _iconViewF = CGRectMake(iconViewX, iconViewY, kStatusIconWH, kStatusIconWH);
    
    CGFloat nameLabelX = CGRectGetMaxX(_iconViewF) + kStatusViewMargin;
    CGFloat nameLabelY = iconViewY;
    CGSize nameLabelSize = [_status.user.name sizeWithAttributes:@{NSFontAttributeName:kStatusNameLabelFont}];
    _nameLabelF = (CGRect){{nameLabelX,nameLabelY},nameLabelSize};
    
    if (_status.user.mbtype) {
        CGFloat vipViewX = CGRectGetMaxX(_nameLabelF) + kStatusViewMargin;
        CGFloat vipViewY = nameLabelY;
        _vipViewF = CGRectMake(vipViewX, vipViewY, kStatusVipIconWH, kStatusVipIconWH);
    }
//    else{
//        _vipViewF = CGRectZero;
//    }
    
    CGFloat timeLabelX = nameLabelX;
    CGFloat timeLabelY = CGRectGetMaxY(_nameLabelF) + kStatusViewMargin;
    CGSize timeLabelSize = [_status.created_at sizeWithAttributes:@{NSFontAttributeName:kStatusTimeLabelFont}];
    _timeLabelF = (CGRect){{timeLabelX,timeLabelY},timeLabelSize};

//    CGFloat sourceLabelX = CGRectGetMaxX(_timeLabelF)+kStatusViewMargin;
//    CGFloat sourceLabelY = timeLabelY;
//    CGSize sourceLabelSize = [_status.source sizeWithAttributes:@{NSFontAttributeName:kStatusSourceLabelFont}];
//    _sourceLabelF = (CGRect){{sourceLabelX,sourceLabelY},sourceLabelSize};
    
    CGFloat contentLabelX = iconViewX;
    CGFloat contentLabelY = MAX(CGRectGetMaxY(_iconViewF), CGRectGetMaxY(_timeLabelF)) + kStatusViewMargin;
    CGFloat maxW = topViewW - 2*kStatusCellBorder;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    CGRect contentLabelRect = [_status.text boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kStatusContentLabelFont} context:Nil];
    _contentLabelF = (CGRect){{contentLabelX,contentLabelY},contentLabelRect.size};
    
    topViewH = CGRectGetMaxY(_contentLabelF);
    if (_status.pic_urls.count) {
        CGFloat photoViewX = kStatusCellBorder;
        CGFloat photoViewY = CGRectGetMaxY(_contentLabelF)+kStatusViewMargin;
        CGSize size = [LXPhotoView sizeWithPhotoCount:_status.pic_urls.count];
        _photoViewF = (CGRect){{photoViewX, photoViewY},size};
        topViewH = CGRectGetMaxY(_photoViewF);
    }
//    else{
//        _photoViewF = CGRectZero;
//    }
    _topViewF = CGRectMake(topViewX, topViewY, topViewW, topViewH+kStatusCellBorder);
    
    CGFloat retweetViewX = contentLabelX;
    CGFloat retweetViewY = CGRectGetMaxY(_topViewF);
    CGFloat retweetViewW = maxW;
    CGFloat retweetViewH = 0.0;
    
    if (_status.retweeted_status) {
        LXStatus *retweetStatus = _status.retweeted_status;
        
/** */
//        CGFloat retweetNameLabelX = iconViewX;
        CGFloat retweetNameLabelX = kStatusCellBorder;
        
//        CGFloat retweetNameLabelY = CGRectGetMaxY(_topViewF) + kStatusViewMargin;
        CGFloat retweetNameLabelY = kStatusCellBorder;
        
        NSString *retweetUserName = [NSString stringWithFormat:@"@%@",retweetStatus.user.name];
        CGSize retweetNameLabelSize = [retweetUserName sizeWithAttributes:@{NSFontAttributeName:kStatusNameLabelFont}];
        _retweetNameLabelF = (CGRect){{retweetNameLabelX,retweetNameLabelY},retweetNameLabelSize};
        
        CGFloat retweetContentLabelX = retweetNameLabelX;
        CGFloat retweetContentLabelY = CGRectGetMaxY(_retweetNameLabelF) + kStatusCellBorder;
        CGSize retweetContentMaxSize = CGSizeMake(retweetViewW-2*kStatusViewMargin, MAXFLOAT);
        CGRect retweetContentLabelRect = [retweetStatus.text boundingRectWithSize:retweetContentMaxSize options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kStatusContentLabelFont} context:Nil];
        _retweetContentLabelF = (CGRect){{retweetContentLabelX,retweetContentLabelY},retweetContentLabelRect.size};
        
        retweetViewH = CGRectGetMaxY(_retweetContentLabelF);
        if (retweetStatus.pic_urls.count) {
            CGFloat retweetPhotoViewX = retweetNameLabelX;
            CGFloat retweetPhotoViewY = CGRectGetMaxY(_retweetContentLabelF) + kStatusViewMargin;
//            CGFloat retweetPhotoViewWH = kStatusPhotoWH;
            CGSize size = [LXPhotoView sizeWithPhotoCount:retweetStatus.pic_urls.count];
            _retweetPhotoViewF = (CGRect){retweetPhotoViewX, retweetPhotoViewY, size};
            retweetViewH = CGRectGetMaxY(_retweetPhotoViewF);
        }
        _retweetViewF = CGRectMake(retweetViewX, retweetViewY, retweetViewW, retweetViewH);
        
        topViewH = CGRectGetMaxY(_retweetViewF)+kStatusCellBorder;
        _topViewF = CGRectMake(topViewX, topViewY, topViewW, topViewH);
    }
//    else{
//        _retweetViewF = CGRectZero;
//    }
    
    CGFloat toolBarX = 0.0;
    CGFloat toolBarY = CGRectGetMaxY(_topViewF);
    CGFloat toolBarW = cellW;
    CGFloat toolBarH = kStatusToolBarH;
    _toolBarViewF = CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);
    
    _statusHeight = CGRectGetMaxY(_toolBarViewF) + kStatusTableBorder;
}
@end
