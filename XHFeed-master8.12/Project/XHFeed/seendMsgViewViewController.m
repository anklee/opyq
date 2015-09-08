//
//  XHFeedBaseViewController.m
//  XHFeed
//
//  Created by anklee on 8/6/15.
//  Copyright (c) 2015 anklee. All rights reserved.
//

#import "seendMsgViewViewController.h"

@interface seendMsgViewViewController ()

@end

@implementation seendMsgViewViewController

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)addButton {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - Perprotys

- (NSArray *)profileImages {
    if (!_profileImages) {
        _profileImages = [[NSArray alloc] init];
    }
    return _profileImages;
}

- (UITextView *)addinPutView {
    if (!_inPutView) {
        CGFloat padding = 0;
        if ([UIDevice currentDevice].systemVersion.integerValue >= 7.0) {
            padding = 64;
        } else {
            padding = 44;
        }
        _inPutView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - padding)];
        //  _inPutView.delegate = self;
        _inPutView.backgroundColor = [UIColor whiteColor];
        _inPutView.text = @"请输入信息,最多140字。";
        _inPutView.textColor = [UIColor lightGrayColor];
        _inPutView.font =  [UIFont fontWithName:@"Avenir-Book" size:16.0];
        [self.view addSubview:_inPutView];
        
    }
    
    _inPutView.delegate = self;
    return _inPutView;
    
}

- (UIButton *)sendBt {
    if (!_sendBt) {
        CGFloat padding = 0;
        if ([UIDevice currentDevice].systemVersion.integerValue >= 7.0) {
            padding = 64;
        } else {
            padding = 44;
        }
        
        _sendBt =  [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _sendBt.frame = CGRectMake(0, CGRectGetHeight(self.view.frame) - padding, CGRectGetWidth(self.view.frame),60);
        
        [_sendBt setTitle:@"确认发送" forState:UIControlStateNormal];
        //  _sendBt.font = @"Avenir-Black";
        UIColor *btColor = [UIColor colorWithRed:65.0/255 green:75.0/255 blue:89.0/255 alpha:0.7];
        [_sendBt  setBackgroundColor:btColor];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sendPress)];
        [_sendBt addGestureRecognizer:tap];
        
        
        [self.view addSubview:_sendBt];
    }
    return _sendBt;
}

#pragma mark - Left cycle init

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

#endif

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        [self setNeedsStatusBarAppearanceUpdate];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    NSString* boldFontName = @"GillSans-Bold";
    NSDictionary* defaults = [[NSUserDefaults standardUserDefaults] dictionaryRepresentation];
    NSLog(@"Defaults: %@", defaults);
    _user = [defaults objectForKey:@"user"];
    _userGroup = [defaults objectForKey:@"userGroup"];
    _userid = [defaults objectForKey:@"userid"];
    _time = [NSDate date];
    
    
    //存取文件路径
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [path objectAtIndex:0];
    filepath = [documents stringByAppendingPathComponent:@"homeDataList.plist"];
    [self styleNavigationBarWithFontName:boldFontName];
    [self addinPutView];
    [_inPutView becomeFirstResponder];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)styleNavigationBarWithFontName:(NSString*)navigationTitleFont {
    
    
    CGSize size = CGSizeMake(320, 44);
    UIColor* color = [UIColor colorWithRed:65.0/255 green:75.0/255 blue:89.0/255 alpha:1.0];
    
    UIGraphicsBeginImageContext(size);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGRect fillRect = CGRectMake(0,0,size.width,size.height);
    CGContextSetFillColorWithColor(currentContext, color.CGColor);
    CGContextFillRect(currentContext, fillRect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    UINavigationBar* navAppearance = [UINavigationBar appearance];
    
    [navAppearance setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    [navAppearance setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                           [UIColor whiteColor], UITextAttributeTextColor,
                                           [UIFont fontWithName:navigationTitleFont size:18.0f], UITextAttributeFont,
                                           nil]];
    
    UIImageView* searchView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"compose.png"]];
    searchView.frame = CGRectMake(0, 0, 20, 20);
    
    UIBarButtonItem* searchItem = [[UIBarButtonItem alloc] initWithCustomView:searchView];
    UITapGestureRecognizer *tapADD = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sendPress)];
    [searchView addGestureRecognizer:tapADD];
    self.navigationItem.rightBarButtonItem = searchItem;
    
    
    UIImageView* menuView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menu.png"]];
    menuView.userInteractionEnabled = YES;
    menuView.frame = CGRectMake(0, 0, 28, 20);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [menuView addGestureRecognizer:tap];
    
    UIBarButtonItem* menuItem = [[UIBarButtonItem alloc] initWithCustomView:menuView];
    
    self.navigationItem.leftBarButtonItem = menuItem;
}


- (void) saeCloud
{
    //下载文件
    ASIS3ObjectRequest *request = [ASIS3ObjectRequest requestWithBucket:@"akappios02" key:@"homeDataList.plist"];
    [request setDownloadDestinationPath:filepath];
    [request startSynchronous];
    
    if ([request error]) {
        NSLog(@"%@",[[request error] localizedDescription]);
    }
    
    //处理文件
    HomeData =[[NSMutableDictionary alloc] initWithContentsOfFile:filepath];
    NSLog(@"%@", HomeData);
    homeTableArry = [HomeData allValues];
    
}


-(void)sendPress{
    if (_userid != nil) {
        [self saeCloud];
        NSMutableDictionary *sendMsgText = [[NSMutableDictionary alloc]init];
        _text = _inPutView.text;
        [sendMsgText setObject:_userid forKey:@"userid"];
        [sendMsgText setObject:_user forKey:@"user"];
        [sendMsgText setObject:_time forKey:@"time"];
        [sendMsgText setObject:_text forKey:@"text"];
        _msgid = [NSString stringWithFormat:@"msg%d",homeTableArry.count + 1];
        [sendMsgText setObject:_msgid forKey:@"msgid"];
        [HomeData setObject:sendMsgText forKey:_msgid];
        [HomeData writeToFile:filepath atomically:YES];
        
        ASIS3ObjectRequest *upLoadRequest = [ASIS3ObjectRequest PUTRequestForFile:filepath withBucket:@"akappios02" key:@"homeDataList.plist"];
        [upLoadRequest startSynchronous];
        
        if ([listRequest error]) {
            NSLog(@"%@",[[listRequest error] localizedDescription]);
        }
        else{
            [self dismiss];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"reload"object:nil];
        }
    }
    else{
        UIAlertView  *erroAlert = [[UIAlertView alloc]initWithTitle:@"信息" message:@"请先登陆或联系管理员注册用户" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [erroAlert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
}

- (void)alertViewCancel:(UIAlertView *)alertView
{
    
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView

{
    // [NSThread sleepForTimeInterval:2];
    textView.text=@"";
    _inPutView.textColor = [UIColor blackColor];
    return YES;
    
}

- (void)textViewDidChangeSelection:(UITextView *)textView
{
    
}



@end
