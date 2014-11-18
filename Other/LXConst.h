#define IOS7    ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
#define is4Inch ([UIScreen mainScreen].applicationFrame.size.height == 568.0)

#define RGBcolor(r,g,b)     [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define RGBAcolor(r,g,b,a)  [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

// Status Frame
#define kStatusNameLabelFont    [UIFont systemFontOfSize:14]
#define kStatusTimeLabelFont    [UIFont systemFontOfSize:11]
#define kStatusSourceLabelFont  [UIFont systemFontOfSize:11]
#define kStatusContentLabelFont [UIFont systemFontOfSize:13]

#define kStatusViewMargin   2.0
#define kStatusTableBorder  5.0
#define kStatusToolBarH     35.0
#define kStatusCellBorder   5.0

#define kStatusIconWH       40.0
#define kStatusVipIconWH    14.0
#define kStatusPhotoWH      70.0

// OAuth
#define LXOAuthRedirect_uri                 @"http://weibo.com/u/1840304183/home"
#define LXOAuthClient_secret                @"f0423ed0618bd360d5b30a616aa49fcf"
#define LXOAuthApp_key                      @"3455878978"
#define LXOAuthAccess_token_urlString       @"https://api.weibo.com/oauth2/access_token"

#define LXOauthRequestAccess_string         [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",LXOAuthApp_key,LXOAuthRedirect_uri]

// Get Status
#define LXStatus_urlString @"https://api.weibo.com/2/statuses/friends_timeline.json"

//send Status
#define LXStatusCompose_urlString @"https://api.weibo.com/2/statuses/update.json"

//LXUser
#define kLXUserUnread_urlString @"https://rm.api.weibo.com/2/remind/unread_count.json"