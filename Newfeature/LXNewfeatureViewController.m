//
//  LXNewfeatureViewController.m
//  0926新浪微博
//
//  Created by xinliu on 14-9-27.
//  Copyright (c) 2014年 xinliu. All rights reserved.
//

#import "LXNewfeatureViewController.h"

#define kNewFeaturePageCount 3

@interface LXNewfeatureViewController () <UIScrollViewDelegate>
@property (weak,nonatomic) UIPageControl *pageControl;
@end

@implementation LXNewfeatureViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:scroll];
    scroll.pagingEnabled = YES;
    scroll.bounces = NO;
    scroll.delegate = self;
    
    CGFloat scrollW = scroll.bounds.size.width;
    CGFloat scrollH = scroll.bounds.size.height;
    
    for (int i=0; i<kNewFeaturePageCount; i++) {
        NSString *name = [NSString stringWithFormat:@"new_feature_%d",i+1];
        if (is4Inch) {
            name = [NSString stringWithFormat:@"new_feature_%d-568h@2x",i+1];
        }
        UIImage *image = [UIImage imageNamed:name];
        UIImageView *imgView = [[UIImageView alloc]initWithImage:image];
        imgView.frame = (CGRect){CGPointMake(i*scrollW, 0.0),scroll.bounds.size};
        [scroll addSubview:imgView];
    }
    scroll.contentSize = CGSizeMake(kNewFeaturePageCount*scrollW, 0.0);
    
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
    
    pageControl.center = CGPointMake(scrollW * 0.5, scrollH-30.0);
    pageControl.bounds = CGRectMake(0.0, 0.0, 100.0, 30.0);
    pageControl.numberOfPages = kNewFeaturePageCount;
    pageControl.currentPage = scroll.contentOffset.x/scrollW;
    
    pageControl.currentPageIndicatorTintColor = RGBcolor(252.0, 99.0, 42.0);
    pageControl.pageIndicatorTintColor = [UIColor colorWithRed:189.0/255.0 green:189.0/255.0 blue:189.0/255.0 alpha:1.0];
    
}
#pragma mark - scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageNo = scrollView.contentOffset.x / scrollView.bounds.size.width;
    int pageInt = (int)(pageNo+0.5);
    self.pageControl.currentPage = pageInt;
}
@end
