//
//  BTViewController.h
//  XHFeed
//
//  Created by anklee on 8/6/15.
//  Copyright (c) 2015 anklee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYFCustomButton.h"
#import "XHFeedBaseViewController.h"
#import "ASIKit/ASIKit.h"
#import <QuartzCore/QuartzCore.h>
@interface BTViewController : XHFeedBaseViewController <UITextViewDelegate,UIAlertViewDelegate>{
    NSString  *filepath;
    NSMutableDictionary *answerData;
    NSMutableArray *answerTableArry;
    int heightFour;
}
@property (weak, nonatomic) IBOutlet UITextView *textTFd;
@property (weak, nonatomic) IBOutlet  SYFCustomButton * CheckBtn;
@property (nonatomic, strong) UIButton* sendBt;
@property (nonatomic, strong) UIImageView* profileImageView;
@property (nonatomic, strong) UILabel* nameLabel;
@property (nonatomic, strong) UITextView* updateLabel;
@property (nonatomic, strong) UILabel* commentCountLabel;
@property (nonatomic, strong) UILabel* likeCountLabel;
@property  NSMutableDictionary *clickMsg;
@property  NSMutableDictionary *clickAnswerData;
@property  NSString *clickMsgid;
@property  NSString *user;
@property  NSString *accountID;
@property  NSMutableDictionary *seendMsg;

@end
