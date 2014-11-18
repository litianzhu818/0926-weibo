//
//  LXPhotoView.m
//  0926新浪微博
//
//  Created by xinliu on 14-10-18.
//  Copyright (c) 2014年 xinliu. All rights reserved.
//

#import "LXPhotoView.h"
#import "LXPhotoImageView.h"
#import "UIImageView+WebCache.h"
#import "LXPhotoBrowserViewController.h"

#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

#define kPhotoViewPhotoCount    9
#define kPhotoViewPhotoW        90.0
#define kPhotoViewPhotoH        kPhotoViewPhotoW
#define kPhotoViewPhotoMargin   5.0

@interface LXPhotoView ()
@end

@implementation LXPhotoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        for (int i=0; i<kPhotoViewPhotoCount; i++) {
            LXPhotoImageView *imageView = [[LXPhotoImageView alloc]init];
            imageView.userInteractionEnabled = YES;
            [self addSubview:imageView];
            [imageView setContentMode:UIViewContentModeScaleAspectFill];
            [imageView setClipsToBounds:YES];
            imageView.hidden = YES;
            imageView.tag = i;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showPhotoBrowserView:)];
            [imageView addGestureRecognizer:tap];
        }
    }
    return self;
}
- (void)showPhotoBrowserView:(UITapGestureRecognizer *)recognizer
{
//    int count = self.photos.count;
//    
//    // 1.封装图片数据
//    NSMutableArray *myphotos = [NSMutableArray arrayWithCapacity:count];
//    for (int i = 0; i<count; i++) {
//        // 一个MJPhoto对应一张显示的图片
//        MJPhoto *mjphoto = [[MJPhoto alloc] init];
//        
//        mjphoto.srcImageView = self.subviews[i]; // 来源于哪个UIImageView
//        
//        LXPhotoImageView *iwphoto = self.photos[i];
//        NSString *photoUrl = [self.photos[i][@"thumbnail_pic"] stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
//        mjphoto.url = [NSURL URLWithString:photoUrl]; // 图片路径
//        
//        [myphotos addObject:mjphoto];
//    }
//    
//    // 2.显示相册
//    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
//    browser.currentPhotoIndex = recognizer.view.tag; // 弹出相册时显示的第一张图片是？
//    browser.photos = myphotos; // 设置所有的图片
//    [browser show];
    
    LXPhotoBrowserViewController *controller = [[LXPhotoBrowserViewController alloc]init];
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:self.photos.count];
    for (int i=0;i<self.photos.count;i++) {
        LXPhotoBrowserModel *model = [[LXPhotoBrowserModel alloc]init];
        LXPhotoImageView *imageView = self.subviews[i];
        model.srcImageView = imageView;
        NSString *photoUrl = [self.photos[i][@"thumbnail_pic"] stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        model.urlString = photoUrl;
        [arr addObject:model];
    }
//    UIView *sup = self.superview.superview.superview.superview.superview.superview;
//    controller.originScrollView = sup;
    
    
    [controller showPhotoBrowserWithPhotoList:arr photoIndex:recognizer.view.tag];
}
- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    
    if (!photos) return;
    int count = photos.count;
    int maxCol = ((count == 4) ? 2 : 3);
//    CGFloat margin = (self.bounds.size.width - kPhotoViewPhotoCount*kPhotoViewPhotoW) / (kPhotoViewPhotoCount+1);
    for (int i=0; i<kPhotoViewPhotoCount; i++) {
        LXPhotoImageView *imageView = self.subviews[i];
        if (i<count) {
            int col = i % maxCol;
            int row = i / maxCol;
            CGFloat X = kPhotoViewPhotoMargin + col * (kPhotoViewPhotoMargin + kPhotoViewPhotoW);
            CGFloat Y = kPhotoViewPhotoMargin + row * (kPhotoViewPhotoMargin + kPhotoViewPhotoH);
            imageView.hidden = NO;
            imageView.frame = CGRectMake(X, Y, kPhotoViewPhotoW, kPhotoViewPhotoH);
            [imageView setImageWithURL:photos[i][@"thumbnail_pic"]];
        }
        else{
            imageView.hidden = YES;
        }
    }
}
+ (CGSize)sizeWithPhotoCount:(NSInteger)count
{
    int maxCol = ((count == 4) ? 2 : 3);
    int cols = (maxCol > count ? maxCol : count);
    int rows = (count + maxCol-1) / maxCol;
    
    CGFloat W = kPhotoViewPhotoMargin + (kPhotoViewPhotoW+kPhotoViewPhotoMargin)*cols;
    CGFloat H = kPhotoViewPhotoMargin + (kPhotoViewPhotoH+kPhotoViewPhotoMargin)*rows;
    return (CGSize){W,H};
}
@end
