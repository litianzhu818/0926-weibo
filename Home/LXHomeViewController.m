//
//  LXHomeViewController.m
//  0926新浪微博
//
//  Created by xinliu on 14-9-26.
//  Copyright (c) 2014年 xinliu. All rights reserved.
//

#import "LXHomeViewController.h"
#import "UIBarButtonItem+LX.h"
#import "LXTitleView.h"
#import "AFNetworking.h"
#import "LXAccountTool.h"
#import "UIButton+LX.h"

#import "LXStatus.h"
#import "LXUser.h"
#import "LXStatusFrame.h"
#import "LXStatusCell.h"
//#import "MJExtension.h"
#import "LXMsgButton.h"
#import "MJRefresh.h"

#import "LXStatusTool.h"
#import "LXUserUnreadParam.h"
#import "LXUserUnreadResult.h"

#import "NSObject+LXDict.h"

#import "LXRefreshHeaderView.h"
#import "LXRefreshFooterView.h"

#define kMsgButtonHeight 24.0

@interface LXHomeViewController () <MJRefreshBaseViewDelegate,LXRefreshViewDelegate>
{
    NSMutableArray *_dataList;
    void (^_updateDataBlock)();
}
@property (weak,nonatomic) LXMsgButton *msgButton;
@property (weak,nonatomic) LXRefreshHeaderView *header;
@property (weak,nonatomic) LXRefreshFooterView *footer;
@end

@implementation LXHomeViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundColor = RGBcolor(226, 226, 226);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _dataList = [NSMutableArray array];
    
    [self setupNavBar];
    [self updateData];
    
    NSTimer *checkMsgTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(checkUnreadMsg) userInfo:Nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:checkMsgTimer forMode:NSRunLoopCommonModes];
}
- (instancetype)initWithUpdateDataBlock:(void (^)())updateDataBlock
{
    self = [super init];
    if (self) {
        _updateDataBlock = updateDataBlock;
    }
    return self;
}
#pragma mark check badgeValue
- (void)checkUnreadMsg
{
    LXUserUnreadParam *param = [LXUserUnreadParam param];
    param.uid = @([LXAccountTool requestAccount].uid) ;
    
    [LXStatusTool unreadCountWithParam:param success:^(LXUserUnreadResult *result) {
        self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.status];
//        self.message.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.totalUnreadMsg];
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark - load Data
- (void)updateData
{
//    [self refreshData];
    [self refreshStatus];
}
- (void)refreshStatus
{
//    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
//    footer.scrollView = self.tableView;
//    
//    footer.delegate = self;
    LXRefreshHeaderView *header = [LXRefreshHeaderView header];
    header.scrollView = self.tableView;
    header.delegate = self;
    [header beginRefresh];
    self.header = header;
    
    LXRefreshFooterView *footer = [LXRefreshFooterView footer];
    footer.scrollView = self.tableView;
    footer.delegate = self;
    self.footer = footer;
}
- (void)refreshViewBeginingRefresh:(LXRefreshView *)refreshView
{
    if ([refreshView isKindOfClass:[LXRefreshFooterView class]]) {
        [self loadOldData];
    }
    else{
        [self loadMoreData];
    }
}
//- (void)refreshView:(MJRefreshBaseView *)refreshView stateChange:(MJRefreshState)state
//{
//    if ([refreshView isKindOfClass:[MJRefreshFooterView class]]) {
//        [self loadOldData:refreshView];
//    }
//}
- (void)loadOldData
{
    LXAccount *account = [LXAccountTool requestAccount];
    
    NSString *maxID = @"0";
    if ([_dataList lastObject]) {
        LXStatusFrame *statusF = _dataList[0];
        LXStatus *status = statusF.status;
        maxID = [status idstr];
    }

    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    NSDictionary *para = @{
                           @"access_token" : account.access_token,
                           @"count" : @1,
                           @"max_id" : maxID
                           };
    
    [mgr GET:LXStatus_urlString parameters:para success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        
        NSArray *statusArr = responseObject[@"statuses"];
        
        for (NSDictionary *dict in statusArr) {
            LXStatus *status = [LXStatus objectWithKeyedDict:dict];
            LXStatusFrame *statusF = [[LXStatusFrame alloc]init];
            statusF.status = status;
            
            [_dataList addObject:statusF];
        }
//        for (int i=0;i<statusArr.count;i++) {
//            NSDictionary *dict =statusArr[i];
//            LXStatus *status = [LXStatus objectWithKeyValues:dict];
//            LXStatusFrame *statusF = [[LXStatusFrame alloc]init];
//            statusF.status = status;
//            
//            [_dataList addObject:statusF];
//        }
        
        [self.tableView reloadData];
        [self.footer endRefreshWithSuccess:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.footer endRefreshWithSuccess:NO];
    }];
}
- (void)refresh
{
//    if([self.tabBarItem.badgeValue integerValue] > 0)
//    {
//        [self loadMoreData:self.refreshControl];
//        [self.tableView scrollRectToVisible:self.tableView.frame animated:YES];
//    }
}
- (void)refreshData
{
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc]init];
    [refreshControl addTarget:self action:@selector(loadMoreData:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    
    [refreshControl beginRefreshing];
    
//    [self loadMoreData:refreshControl];
}
- (void)loadMoreData
{
    LXAccount *account = [LXAccountTool requestAccount];
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    int defaultCount = 10;
    int maxCount = 20;
    
    para[@"access_token"] = account.access_token;
    para[@"since_id"] = @0;
    para[@"count"] = @(defaultCount);
    
    if ([_dataList firstObject]) {
        LXStatusFrame *statusF = _dataList[0];
        LXStatus *status = statusF.status;
        para[@"since_id"] = @([[status idstr] longLongValue]);

        NSInteger unreadCount = [self.tabBarItem.badgeValue integerValue];
        
        if (unreadCount > defaultCount) {
            if(unreadCount < maxCount) para[@"count"] = @(unreadCount);
            else para[@"count"] = @(maxCount);
        }
    }
    else{
        para[@"count"] = @(defaultCount);
    }
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:para success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        
        NSArray *statusArr = responseObject[@"statuses"];
        
//        for (NSDictionary *dict in statusArr) {
//            LXStatus *status = [LXStatus objectWithKeyedDict:dict];
//            LXStatusFrame *statusF = [[LXStatusFrame alloc]init];
//            statusF.status = status;
//            [_dataList insertObject:statusF atIndex:0];
//            
//        }
        for (int i=statusArr.count-1;i>=0;i--) {
            NSDictionary *dict = statusArr[i];
            LXStatus *status = [LXStatus objectWithKeyedDict:dict];
            LXStatusFrame *statusF = [[LXStatusFrame alloc]init];
            statusF.status = status;
            [_dataList insertObject:statusF atIndex:0];
        }
        int showMsgCount = statusArr.count;
        int unreadCount = [self.tabBarItem.badgeValue integerValue];
        if (showMsgCount < unreadCount) showMsgCount = unreadCount;
        
        [self showLoadMsg:showMsgCount];
        [self checkUnreadMsg];
        
        if (_dataList.count > maxCount) {
            for (int i= maxCount; i<_dataList.count-1; i++) {
                [_dataList removeObjectAtIndex:i];
            }
        }
        
        [self.tableView reloadData];
        [self.header endRefreshWithSuccess:YES];
        
//        if ([self.tabBarItem.badgeValue integerValue] > statusArr.count) {
//            for (int i=statusArr.count; i<[self.tabBarItem.badgeValue integerValue]; i++) {
//                [_dataList removeObjectAtIndex:i];
//            }
//        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.header endRefreshWithSuccess:NO];
    }];
}
- (void)updaeDataList
{
    
}
- (void)showLoadMsg:(NSInteger)count
{
    NSString *title = @"没有发现新微博";
    if (count) {
        title = [NSString stringWithFormat:@"更新%d条新微博",count];
    }

    [self.msgButton setTitle:title forState:UIControlStateNormal];
    self.msgButton.hidden = NO;
    
    CGRect frame = self.msgButton.frame;
    CGRect tempF = frame;
    frame.origin.y += kMsgButtonHeight;
    [UIView animateWithDuration:0.5 animations:^{
        self.msgButton.frame = frame;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 delay:0.5 options:UIViewAnimationOptionCurveLinear animations:^{
             self.msgButton.frame = tempF;
        } completion:^(BOOL finished) {
            self.msgButton.hidden = YES;
        }];
    }];
}
- (void)loadStatus
{
    LXAccount *account = [LXAccountTool requestAccount];
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    NSDictionary *para = @{@"access_token" : account.access_token};
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:para success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        
//        _dataList = responseObject[@"statuses"];
        NSArray *statusArr = responseObject[@"statuses"];
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"data2.plist"];
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//        [statusArr writeToFile:path atomically:YES];
        NSLog(@"%@",dict);NSLog(@"%@",path);
        
        
        NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:statusArr.count];
        
        for (NSDictionary *dict in statusArr) {
            LXStatus *status = [LXStatus objectWithKeyedDict:dict];
            LXStatusFrame *statusF = [[LXStatusFrame alloc]init];
            statusF.status = status;
            [arrM addObject:statusF];
        }
        
//        for (NSDictionary *dict in statusArr) {
//            LXStatus *status = [LXStatus objectWithKeyValues:dict];
//            LXStatusFrame *statusF = [[LXStatusFrame alloc]init];
//            statusF.status = status;
//            [arrM addObject:statusF];
//        }
        _dataList = arrM;
        BOOL result = [statusArr writeToFile:path atomically:YES];
        NSLog(@"%d",result);
        [self.tableView reloadData];
 
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
#pragma mark - setup Navigation bar
- (void)setupNavBar
{
    [self addBarButton];
    [self addTitleView];
}
#pragma mark add TitleView
- (void)addTitleView
{
//    CGRect F = CGRectMake(0.0, 0.0, 140.0, 40.0);
//    LXTitleView *titleV = [[LXTitleView alloc]initWithFrame:F];
//    [titleV setTitle:@"这是无敌流" forState:UIControlStateNormal];
    
    UIImage *image = [UIImage imageWithName:@"navigationbar_arrow_up"];
    UIButton *titleV = [UIButton buttonWithImageOnRight:image string:@"这是无敌流" font:[UIFont systemFontOfSize:16.0] marginHorizon:5.0 marginVertical:2.0];
    
//    [self changeArrowOnTitleView:titleV];
    [titleV addTarget:self action:@selector(clickOnTitleView:) forControlEvents:UIControlEventTouchDown];
    
    self.navigationItem.titleView = titleV;
}
- (void)clickOnTitleView:(LXTitleView *)titleView
{
    titleView.selected = !titleView.selected;
    [self changeArrowOnTitleView:titleView];
}
- (void)changeArrowOnTitleView:(LXTitleView *)titleView
{
    if (titleView.selected) {
        [titleView setImage:[UIImage imageWithName:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    }
    else{
        [titleView setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    }
}
#pragma mark add BarButton
- (void)addBarButton
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:@"navigationbar_friendsearch" selected:@"navigationbar_friendsearch_highlighted" target:self action:@selector(clickOnFriendSearch)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:@"navigationbar_pop" selected:@"navigationbar_pop_highlighted" target:self action:@selector(clickOnPop)];
}
- (void)clickOnFriendSearch
{
    NSLog(@"clickOn friendsearch");
}
- (void)clickOnPop
{
    NSLog(@"click on click");
}
#pragma mark - tableView datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LXStatusCell *cell = [LXStatusCell cellWithTableView:tableView];
    cell.statusFrame = _dataList[indexPath.row];
    
    return cell;
}
#pragma mark - tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LXStatusFrame *statusF = _dataList[indexPath.row];
    return statusF.statusHeight;
}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UIViewController *vc = [[UIViewController alloc]init];
//    vc.view.backgroundColor = [UIColor blueColor];
//    [self.navigationController pushViewController:vc animated:YES];
//}
#pragma mark - private
- (LXMsgButton *)msgButton
{
    if (!_msgButton) {
        LXMsgButton *btn = [[LXMsgButton alloc]init];
        [self.navigationController.view insertSubview:btn belowSubview:self.navigationController.navigationBar];
        CGFloat Y = CGRectGetMaxY(self.navigationController.navigationBar.frame);
        CGRect frame = CGRectMake(0.0, Y-kMsgButtonHeight, self.tableView.frame.size.width, kMsgButtonHeight);
        [btn setFrame:frame];
        
        _msgButton = btn;
    }
    return _msgButton;
}
#pragma mark - test
- (void)test
{
    UIButton *add = [UIButton buttonWithType:UIButtonTypeContactAdd];
    add.frame = CGRectMake(100.0, 80.0, 100.0, 40.0);
    [add addTarget:self action:@selector(addBadge) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *remove = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    remove.frame = CGRectMake(100.0, 180.0, 100.0, 40.0);
    [remove addTarget:self action:@selector(removeBadge) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:add];
    [self.view addSubview:remove];
}
- (void)removeBadge
{
    self.tabBarItem.badgeValue = Nil;
}
- (void)addBadge
{
    self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",arc4random_uniform(200)];
}
@end
