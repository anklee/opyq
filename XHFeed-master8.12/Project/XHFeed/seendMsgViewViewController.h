//
//  seendMsgViewViewController.h
//  XHFeed
//
//  Created by anklee on 8/6/15.
//  Copyright (c) 2015 anklee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIKit/ASIKit.h"
@interface seendMsgViewViewController : UIViewController<UIAlertViewDelegate,UITextViewDelegate>
{
        NSString  *filepath;
        NSMutableDictionary *HomeData;
        NSMutableArray *homeTableArry;
    ASIS3BucketRequest *listRequest;
}

@property (nonatomic, strong) UITableView* feedTableView;
@property (nonatomic, strong) UITextView* inPutView;
@property (nonatomic, strong) UIButton* sendBt;
@property (nonatomic, strong) NSArray* profileImages;
@property  NSString *userid;
@property  NSString *user;
@property  NSString *userGroup;
@property (nonatomic, strong) NSDate *time;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *msgid;

- (void)styleNavigationBarWithFontName:(NSString*)navigationTitleFont;
- (void) saeCloud;
-(void)sendPress;
@end
