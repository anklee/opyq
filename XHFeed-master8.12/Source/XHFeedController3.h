//
//  XHFeedController3.h
//  XHFeed
//
//  Created by anklee on 8/6/15.
//  Copyright (c) 2015 anklee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHFeedBaseViewController.h"
#import "ASIKit/ASIKit.h"
#import "BTViewController.h"
#import "seendMsgViewViewController.h"
@interface XHFeedController3 : XHFeedBaseViewController <UIActionSheetDelegate>
{
    NSString  *filepath;
    NSMutableDictionary *HomeData;
    NSMutableArray *homeTableArry;
    NSUserDefaults *userDefaults;
    NSMutableDictionary *likeMD;
}
@end
