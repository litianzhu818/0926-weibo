//
//  LXOAuthViewController.m
//  0926新浪微博
//
//  Created by xinliu on 14-9-28.
//  Copyright (c) 2014年 xinliu. All rights reserved.
//

#import "LXOAuthViewController.h"
#import "AFNetworking.h"
#import "LXAccountTool.h"
#import "MBProgressHUD.h"
#import "LXWeiboTool.h"

@interface LXOAuthViewController () <UIWebViewDelegate>

@end

@implementation LXOAuthViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self requestAccess];
}
#pragma mark - request access
- (void)requestAccess
{
    UIWebView *webV = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:webV];
    webV.delegate = self;
    
    NSURL *url = [NSURL URLWithString:LXOauthRequestAccess_string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webV loadRequest:request];
}
#pragma mark webView delegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *requestStr = request.URL.absoluteString;
    NSRange range = [requestStr rangeOfString:@"code="];
    if (range.location != NSNotFound) {
        NSString *code = [requestStr substringFromIndex:range.location+range.length];
        [self accessToken:code];
//        return NO;
    }
    return YES;
}
- (void)accessToken:(NSString *)code
{
    NSDictionary *para = @{
                           @"client_id" : LXOAuthApp_key,
                           @"redirect_uri" : LXOAuthRedirect_uri,
                           @"client_secret" : LXOAuthClient_secret,
                           @"grant_type" : @"authorization_code",
                           @"code" : code
                           };
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    [mgr POST:LXOAuthAccess_token_urlString parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [LXAccountTool saveAccountWithDict:responseObject];
        
        [LXWeiboTool launchApp];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}
@end
