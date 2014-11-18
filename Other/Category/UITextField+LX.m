//
//  UITextField+LX.m
//  0926新浪微博
//
//  Created by xinliu on 14-9-27.
//  Copyright (c) 2014年 xinliu. All rights reserved.
//

#import "UITextField+LX.h"

@implementation UITextField (LX)

+ (instancetype)searchBar
{
    return [[UITextField alloc]init];
}
- (id)init
{
    self = [super init];
    if (self) {
        CGRect defaultFrame = CGRectMake(0.0, 0.0, 300.0, 30.0);
        self.frame = defaultFrame;
        [self setClearButtonMode:UITextFieldViewModeAlways];
        [self setFont:[UIFont systemFontOfSize:14]];
        
        [self setBackground:[UIImage resizedImage:[UIImage imageWithName:@"searchbar_textfield_background"]]];
        
        UIImage *image = [UIImage imageWithName:@"searchbar_textfield_search_icon"];
        UIImageView *imgView = [[UIImageView alloc]initWithImage:image];
        CGRect tempF = imgView.frame;
        tempF.size.width += 10.0;
        imgView.frame = tempF;
        [imgView setContentMode:UIViewContentModeCenter];
        self.leftView = imgView;
        self.leftViewMode = UITextFieldViewModeAlways;
        
        NSDictionary *attr = @{
                               NSFontAttributeName : [UIFont systemFontOfSize:11],
                               NSForegroundColorAttributeName : [UIColor grayColor]
                               };
        self.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"搜索" attributes:attr];
        
        self.returnKeyType = UIReturnKeySearch;
        self.enablesReturnKeyAutomatically = YES;
    }
    
    return self;
}
@end
