//
//  LXComposeViewController.m
//  0926新浪微博
//
//  Created by xinliu on 14-10-14.
//  Copyright (c) 2014年 xinliu. All rights reserved.
//

#import "LXComposeViewController.h"
#import "LXTextView.h"
#import "AFNetworking.h"
#import "LXAccountTool.h"
#import "MBProgressHUD+MJ.h"

@interface LXComposeViewController ()
@property (weak,nonatomic) LXTextView *textView;
@end

@implementation LXComposeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupNavBar];
    [self setupTextView];
}
#pragma mark - setup view
- (void)setupTextView
{
    LXTextView *textView = [[LXTextView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:textView];
    self.textView = textView;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textViewChanged:) name:UITextViewTextDidChangeNotification object:textView];
}
- (void)textViewChanged:(NSNotification *)notify
{
    self.navigationItem.rightBarButtonItem.enabled = self.textView.text.length;
}
#pragma mark - setup navBar
- (void)setupNavBar
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    self.title = @"发微博";
}
- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)send
{
    NSDictionary *para = @{
                           @"access_token" : [LXAccountTool requestAccount].access_token,
                           @"status" : self.textView.text
                           };
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    [mgr POST:LXStatusCompose_urlString parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
    }];
    
    [self cancel];
}
#pragma mark - private
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.textView becomeFirstResponder];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
