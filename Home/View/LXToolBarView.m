//
//  LXToolBarView.m
//  0926新浪微博
//
//  Created by xinliu on 14-10-5.
//  Copyright (c) 2014年 xinliu. All rights reserved.
//

#import "LXToolBarView.h"
#import "LXStatus.h"

@interface LXToolBarView ()

@property (strong,nonatomic) NSMutableArray *toolBarViews;
@property (strong,nonatomic) NSMutableArray *toolBarDividerViews;

@property (weak,nonatomic) UIButton *repostBtn;
@property (weak,nonatomic) UIButton *commentBtn;
@property (weak,nonatomic) UIButton *attitudeBtn;

@end

@implementation LXToolBarView
+ (instancetype)toolBarView
{
    return [[self alloc]init];
}
- (id)init
{
    self = [super init];
    if (self) {
        [self setImage:[UIImage resizedImage:[UIImage imageWithName:@"timeline_card_bottom_background" ]]];
        //    [self.toolBarView setImage:[UIImage imageWithName:@"timeline_card_bottom_background"]];
        [self setHighlightedImage:[UIImage resizedImage:[UIImage imageWithName:@"timeline_card_bottom_background_highlighted"]]];
        
         self.commentBtn = [self setupToolBarSubViewWithImageName:@"timeline_icon_comment" title:@"评论" hightedImageName:@"timeline_card_leftbottom_highlighted"];
         self.repostBtn = [self setupToolBarSubViewWithImageName:@"timeline_icon_retweet" title:@"转发" hightedImageName:@"timeline_card_middlebottom_highlighted"];
         self.attitudeBtn = [self setupToolBarSubViewWithImageName:@"timeline_icon_unlike" title:@"赞" hightedImageName:@"timeline_card_rightbottom_highlighted"];
        
        [self setupToolBarDividerView:@"timeline_card_bottom_line" hightedImae:@"timeline_card_bottom_line_highlighted"];
        [self setupToolBarDividerView:@"timeline_card_bottom_line" hightedImae:@"timeline_card_bottom_line_highlighted"];
    }
    return self;
}

- (void)setupToolBarDividerView:(NSString *)imageName hightedImae:(NSString *)hightedImage
{
    UIImage *image = [UIImage imageWithName:imageName];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    [imageView setHighlightedImage:[UIImage imageWithName:hightedImage]];
    [self addSubview:imageView];
    [self.toolBarDividerViews addObject:imageView];
    
}
- (UIButton *)setupToolBarSubViewWithImageName:(NSString *)imageName title:(NSString *)title hightedImageName:(NSString *)hightedImageName
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:btn];
    [self.toolBarViews addObject:btn];
    
    [btn setImage:[UIImage imageWithName:imageName] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage resizedImageName:hightedImageName] forState:UIControlStateHighlighted];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 5.0, 0.0, 0.0)];
    
    return btn;
}
- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    CGFloat toolH = self.frame.size.height;
    CGFloat dividerViewH = toolH;
    CGFloat dividerViewY = 0.0;
    CGFloat dividerViewW = 2.0;
    CGFloat btnY = 0.0;
    CGFloat btnH = toolH;
    CGFloat btnW = (self.frame.size.width-self.toolBarDividerViews.count*dividerViewW) / self.toolBarViews.count;
    
    for (int i=0; i<self.toolBarViews.count; i++) {
        UIButton *btn = self.toolBarViews[i];
        CGFloat btnX = i * (btnW+dividerViewW);
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
    
    for (int j=0; j<self.toolBarDividerViews.count; j++) {
        UIImageView *dividerView = self.toolBarDividerViews[j];
        CGFloat dividerViewX = CGRectGetMaxX([self.toolBarViews[j] frame]);
        dividerView.frame = CGRectMake(dividerViewX, dividerViewY, dividerViewW, dividerViewH);
    }
}
- (void)setStatus:(LXStatus *)status
{
    _status = status;

    if (status.reposts_count) {
        NSString *reposts = [self formatResult:status.reposts_count];
        [self.repostBtn setTitle:reposts forState:UIControlStateNormal];
    }
    
    
    if (status.comments_count) {
        NSString *comments = [self formatResult:status.comments_count];
        [self.commentBtn setTitle:comments forState:UIControlStateNormal];
    }
    
    if (status.attitudes_count) {
        NSString *attitudes = [self formatResult:status.attitudes_count];
        [self.attitudeBtn setTitle:attitudes forState:UIControlStateNormal];
    }
}
- (NSString *)formatResult:(int)count
{
    NSString *result = [NSString stringWithFormat:@"%d",count];
    if (count > 10000) {
        float f = count / 10000.0;
        result = [NSString stringWithFormat:@"%.1f万",f];
        result = [result stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }
    
    return result;
}
- (NSMutableArray *)toolBarViews
{
    if (!_toolBarViews) {
        _toolBarViews = [NSMutableArray arrayWithCapacity:3];
    }
    return _toolBarViews;
}
- (NSMutableArray *)toolBarDividerViews
{
    if (!_toolBarDividerViews) {
        _toolBarDividerViews = [NSMutableArray arrayWithCapacity:2];
    }
    return _toolBarDividerViews;
}
@end
