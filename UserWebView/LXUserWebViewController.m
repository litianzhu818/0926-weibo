//
//  LXUserWebViewController.m
//  0926sinaweibo
//
//  Created by xinliu on 14-12-15.
//  Copyright (c) 2014年 xinliu. All rights reserved.
//

#import "LXUserWebViewController.h"

@interface LXUserWebViewController ()<UIWebViewDelegate>
@property (weak,nonatomic) UIWebView *webV;
@property (weak,nonatomic) UIActivityIndicatorView *loadIndicator;
@end

@implementation LXUserWebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIWebView *webV = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:webV];
    webV.delegate = self;
    self.webV = webV;
    
    UIActivityIndicatorView *loadIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    loadIndicator.center = self.view.center;
    loadIndicator.color = [UIColor blueColor];
    self.loadIndicator = loadIndicator;
    [self.view addSubview:loadIndicator];
    loadIndicator.hidesWhenStopped = YES;
    
    [self loadRequest];
}
- (void)setUrl:(NSString *)url
{
    _url = url;
    if (!url || !self.view.window) return;
    
    [self loadRequest];
}
- (void)loadRequest
{
    NSURL *userUrl = [NSURL URLWithString:self.url];
    NSURLRequest *request = [NSURLRequest requestWithURL:userUrl];
    [self.webV loadRequest:request];
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.loadIndicator startAnimating];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.loadIndicator stopAnimating];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self.loadIndicator stopAnimating];
    NSLog(@"%@",error);
}
@end
