//
//  ViewController.h
//  XHFeed
//
//  Created by 曾 宪华 on 13-12-12.
//  Copyright (c) 2013年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "XHFeedBaseViewController.h"
#import "ASIKit/ASIKit.h"
@interface ViewController : XHFeedBaseViewController<UIAlertViewDelegate>
{
    NSMutableArray *function;
    NSString *filepath;
    NSMutableDictionary *userData;
    NSMutableArray *userArry;
    UIAlertView *signAlert;
    NSString* accoutName;
    NSString* accoutPassword;
}
@end
