//
//  BTViewController.m
//  XHFeed
//
//  Created by anklee on 8/7/15.
//  Copyright (c) 2015 anklee. All rights reserved.
//

#import "BTViewController.h"

@interface BTViewController ()

@end

@implementation BTViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange:) name:UITextViewTextDidChangeNotification object:_textTFd];
    //存取文件路径
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [path objectAtIndex:0];
    filepath = [documents stringByAppendingPathComponent:@"answerDataList.plist"];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    _clickMsg =  [userDefaults valueForKey:@"clickMsgDic"];
    _clickMsgid = [_clickMsg valueForKey:@"msgid"];
    _user = [userDefaults valueForKey:@"user"];
    [self saeCloud];
    [self addView];
    
    UIImageView* seendView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"compose.png"]];
    seendView.frame = CGRectMake(0, 0, 22, 22);
    
    UIBarButtonItem* seendViewItem = [[UIBarButtonItem alloc] initWithCustomView:seendView];
    UITapGestureRecognizer *tapADD = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seendMsgBT)];
    [seendView addGestureRecognizer:tapADD];
    self.navigationItem.rightBarButtonItem = seendViewItem;
    self.title = @"评论";
    
    _textTFd.layer.cornerRadius = 5 ;
    _textTFd.layer.masksToBounds = YES;
    _textTFd.layer.borderColor = [UIColor grayColor].CGColor;
    _textTFd.layer.borderWidth =0.4;
    _textTFd.delegate = self;
   // [_textTFd becomeFirstResponder];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)awakeFromNib
{
    self.textTFd.layer.borderWidth = 1.6;
    _textTFd.layer.borderColor = SYFColor(173, 210, 252).CGColor;
    _textTFd.layer.cornerRadius = 3;
}

- (IBAction)cleanClicked:(SYFCustomButton *)sender {
    
    [sender setTitle:@"140" forState:UIControlStateNormal];
    _textTFd.text = nil;
}



- (void)textChange:(NSNotification *)nori
{
    UITextView * textFd = nori.object;
    NSLog(@"%@",textFd.text);
    NSUInteger strACout = 140 - textFd.text.length;
    NSString * str = [NSString stringWithFormat:@"%ld",strACout];
    [self.CheckBtn setTitle:str forState:UIControlStateNormal];
}

#pragma mark textView 的代理方法
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
    {
        
        [_textTFd resignFirstResponder];
        return NO;
    }
    return YES;
}

//在UITextField 编辑之前调用方法
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [self animatetextView: _textTFd up: YES];
}
//在UITextField 编辑完成调用方法
- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self animatetextView: _textTFd up: NO];
}
//视图上移的方法
- (void) animatetextView: (UITextView *) textView up: (BOOL) up
{
    //设置视图上移的距离，单位像素
    const int movementDistance = 248; // tweak as needed
    //三目运算，判定是否需要上移视图或者不变
    int movement = (up ? -movementDistance : movementDistance);
    //设置动画的名字
    [UIView beginAnimations: @"Animation" context: nil];
    //设置动画的开始移动位置
    [UIView setAnimationBeginsFromCurrentState: YES];
    //设置动画的间隔时间
    [UIView setAnimationDuration: 0.20];
    //设置视图移动的位移
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    //设置动画结束
    [UIView commitAnimations];
}

//点击屏幕，让键盘弹回
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


-(void)addView
{
    UIColor* mainColor = [UIColor colorWithRed:28.0/255 green:158.0/255 blue:121.0/255 alpha:1.0f];
    UIColor* neutralColor = [UIColor colorWithWhite:0.4 alpha:1.0];
    UIColor* mainColorLight = [UIColor colorWithRed:28.0/255 green:158.0/255 blue:121.0/255 alpha:0.4f];
  //  UIColor* lightColor = [UIColor colorWithWhite:0.7 alpha:1.0];
    
    NSString* fontName = @"Avenir-Book";
    NSString* boldItalicFontName = @"Avenir-BlackOblique";
    NSString* boldFontName = @"Avenir-Black";
    
    _profileImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    //        _profileImageView.layer.cornerRadius = 10.0f;
    
    UIFont *nameLabelFont = [UIFont fontWithName:boldFontName size:(isIpad ? 35.0f : 17.0f)];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _nameLabel.textColor =  mainColor;
    _nameLabel.font = nameLabelFont;
    
    UIFont *updateLabelFont = [UIFont fontWithName:fontName size:(isIpad ? 24.0f : 12.0f)];
    _updateLabel = [[UITextView alloc] initWithFrame:CGRectZero];
   // _updateLabel.delegate = self;
    // _updateLabel.numberOfLines = 0;
    // _updateLabel.lineBreakMode = NSLineBreakByCharWrapping;
    _updateLabel.textColor =  neutralColor;
    _updateLabel.font = updateLabelFont;
     _updateLabel.scrollEnabled = YES;
    
    
    UIFont *countLabelFont = [UIFont fontWithName:boldItalicFontName size:(isIpad ? 20.0f : 10.0f)];
    _commentCountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _commentCountLabel.textColor = mainColorLight;
    _commentCountLabel.font = countLabelFont;
    
    _likeCountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _likeCountLabel.textColor = mainColorLight;
    _likeCountLabel.font = countLabelFont;
    
#define profileImageViewX (isIpad ? 40 :20)
#define profileImageViewY (isIpad ? 22 :11)
#define profileImageViewSize (isIpad ? 80 :40)
    
#define nameLabelX (isIpad ? 170 : 68)
#define nameLabelWidth (isIpad ? 432 : 216)
#define nameLabelHeight (isIpad ? 42 : 21)
    
    // 内容的
#define updateLabelY (isIpad ? 108 : 54)
#define updateLabelWidth (isIpad ? 560 : 280)
#define updateLabelHeight (isIpad ? 960 : 480)
    
#define commentCountLabelY (isIpad ? 112 : 56)
#define commentCountLabelWidth (isIpad ? 160 : 80)
#define commentCountLabelHeight (isIpad ? 42 : 21)
    
#define likeCountLabelSpeator (isIpad ? 40 : 10)
    
#define dateLabelSpeator (isIpad ? 10 : 5)
    
    _profileImageView.frame = CGRectMake(profileImageViewX, profileImageViewY, profileImageViewSize, profileImageViewSize);
    _nameLabel.frame = CGRectMake(nameLabelX, _profileImageView.frame.origin.y, nameLabelWidth, nameLabelHeight);
    //屏幕尺寸
    CGRect rect = [ UIScreen mainScreen ].applicationFrame;
    CGSize size = rect.size;
    //    CGFloat width = size.width;
    //    CGFloat height = size.height;
    heightFour = size.height;
    
    if (heightFour == 460 ) {
        _updateLabel.frame = CGRectMake(20, updateLabelY, updateLabelWidth, 310);
    }
    else if (heightFour == 548){
    _updateLabel.frame = CGRectMake(20, updateLabelY, updateLabelWidth, 390);
    }
    else  {
        _updateLabel.frame = CGRectMake(20, updateLabelY, updateLabelWidth, 390);
    }
    
    _commentCountLabel.frame = CGRectMake(72, 32, commentCountLabelWidth, commentCountLabelHeight);
    _likeCountLabel.frame = CGRectMake( 72+commentCountLabelWidth, 32, _commentCountLabel.frame.size.width, _commentCountLabel.frame.size.height);
    _nameLabel.text = [NSString stringWithFormat:@"评论%@",[_clickMsg valueForKey:@"user"]];
    _updateLabel.editable = NO;
    _updateLabel.text = [_clickAnswerData valueForKey:@"text"];
    _commentCountLabel.text =[NSString stringWithFormat:@"%@ 热度",[_clickMsg valueForKey:@"answer"]];
    _likeCountLabel.text = [NSString stringWithFormat:@"%@ 赞",[_clickMsg valueForKey:@"likes"]];
    _profileImageView.image = [UIImage imageNamed:@"profile.jpg"];
   // [self.view addSubview:self.profileImageView];
   // [self.view addSubview:self.nameLabel];
   // [self.view addSubview:self.updateLabel];
   // [self.view addSubview:self.commentCountLabel];
   // [self.view addSubview:self.likeCountLabel];
    
    [self.view insertSubview:self.profileImageView atIndex:0];
    [self.view insertSubview:self.nameLabel atIndex:0];
    [self.view insertSubview:self.updateLabel atIndex:0];
    [self.view insertSubview:self.commentCountLabel atIndex:0];
    [self.view insertSubview:self.likeCountLabel atIndex:0];
    
}

- (void) saeCloud
{
    //下载文件
    ASIS3ObjectRequest *request = [ASIS3ObjectRequest requestWithBucket:@"akappios02" key:@"answerDataList.plist"];
    [request setDownloadDestinationPath:filepath];
    [request startSynchronous];
    
    if ([request error]) {
        NSLog(@"%@",[[request error] localizedDescription]);
    }
    
    //处理文件
    answerData =[[NSMutableDictionary alloc] initWithContentsOfFile:filepath];
    answerTableArry = [answerData allValues];
    _clickAnswerData = [answerData valueForKey:_clickMsgid];
    
}



-(void) seendMsgBT
{
    [self saeCloud];
    if (_clickMsgid != nil & _user != nil) {
        _seendMsg = [[NSMutableDictionary alloc]init];
        NSString *addText = [[answerData valueForKey:_clickMsgid] valueForKey:@"text"];
        if (addText == NULL) {
            addText = @"";
        }
        [_seendMsg setObject:_clickMsgid forKey:@"msgid"];
        [_seendMsg setObject:[NSString stringWithFormat:@"%@%@:%@\n",addText,_user,_textTFd.text] forKey:@"text"];
        [_seendMsg setObject:_user forKey:@"user"];
        [_seendMsg setObject:[NSDate date] forKey:@"time"];
        
        [answerData setObject:_seendMsg forKey:_clickMsgid];
        [answerData writeToFile:filepath atomically:YES];
        ASIS3ObjectRequest *upLoadRequest = [ASIS3ObjectRequest PUTRequestForFile:filepath withBucket:@"akappios02" key:@"answerDataList.plist"];
        [upLoadRequest startSynchronous];
        
        if ([upLoadRequest error]) {
            NSLog(@"%@",[[upLoadRequest error] localizedDescription]);
        }
        else{
            [self dismissViewControllerAnimated:YES completion:NULL];
        }
    }
    else{
        UIAlertView  *erroAlert = [[UIAlertView alloc]initWithTitle:@"信息" message:@"请先登陆或联系管理员注册用户" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [erroAlert show];

    }
    
}

@end
