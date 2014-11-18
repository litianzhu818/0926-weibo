//
//  LXMessageViewController.m
//  0926新浪微博
//
//  Created by xinliu on 14-9-26.
//  Copyright (c) 2014年 xinliu. All rights reserved.
//

#import "LXMessageViewController.h"

@interface LXMessageViewController ()

@end

@implementation LXMessageViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发消息" style:UIBarButtonItemStyleDone target:Nil action:nil];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    return cell;
}

@end
