//
//  LXStatusCell.m
//  0926新浪微博
//
//  Created by xinliu on 14-9-29.
//  Copyright (c) 2014年 xinliu. All rights reserved.
//

#import "LXStatusCell.h"
#import "LXStatusFrame.h"
#import "LXToolBarView.h"
#import "LXTopView.h"

@interface LXStatusCell ()<LXTopViewDelegate>

@property (weak,nonatomic) LXTopView *topView;
@property (weak,nonatomic) LXToolBarView *toolBarView;

@end

@implementation LXStatusCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        
        [self setupTopView];
        [self setupToolBar];
    }
    return self;
}
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *CellID = @"statusCell";
    LXStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (!cell) {
        cell = [[LXStatusCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellID];
    }
    
    return cell;
}
- (void)setFrame:(CGRect)frame
{
    frame.origin.x = kStatusTableBorder;
    frame.origin.y += kStatusTableBorder;
    frame.size.width -= 2*kStatusTableBorder;
    frame.size.height -= kStatusTableBorder;
    
    [super setFrame:frame];
}
#pragma mark - setup frame
- (void)setStatusFrame:(LXStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    LXStatus *status = _statusFrame.status;
    
    [self setOriginViewFrame:status];
    [self setToolBarFrame];
}
- (void)setToolBarFrame
{
    self.toolBarView.frame = _statusFrame.toolBarViewF;

    self.toolBarView.status = _statusFrame.status;
}
- (void)setOriginViewFrame:(LXStatus *)status
{
    self.topView.frame = _statusFrame.topViewF;
    
    self.topView.statusFrame = _statusFrame;
}

#pragma mark - add subViews
- (void)setupTopView
{
    LXTopView *topView = [[LXTopView alloc]init];
    [self.contentView addSubview:topView];
    self.topView = topView;
    topView.delegate = self;
}

- (void)setupToolBar
{
    LXToolBarView *toolBarView = [LXToolBarView toolBarView];
    [self.contentView addSubview:toolBarView];
    self.toolBarView = toolBarView;
    self.toolBarView.userInteractionEnabled = YES;
}
#pragma mark - topView delegate
- (void)topView:(LXTopView *)topView didClickedStatus:(LXStatus *)status
{
    if ([self.delegate respondsToSelector:@selector(statusCell:didClickedStatus:)]) {
        [self.delegate statusCell:self didClickedStatus:status];
    }
}
@end
