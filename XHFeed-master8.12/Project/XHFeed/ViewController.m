//
//  ViewController.m
//  XHFeed
//
//  Created by 曾 宪华 on 13-12-12.
//  Copyright (c) 2013年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - Left cycle init

- (void)_loadFeedViewControllers {
    dispatch_async(dispatch_queue_create("Load Feeds", NULL), ^{
        
        NSMutableArray *feeds = [[NSMutableArray alloc] init];
        function = [[NSMutableArray alloc] init];
        [function addObject:@"新鲜事儿"];
        [function addObject:@"跳蚤市场"];
        [function addObject:@"扯淡闲聊"];
        [function addObject:@"登陆注册"];
        [function addObject:@"发布消息"];
        for (int i = 1; i < 5; i ++) {
            NSString *className = [NSString stringWithFormat:@"XHFeedController%d", i];
            [feeds addObject:className];
        }
        [feeds addObject:@"seendMsgViewViewController"];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.profileImages = feeds;
            [self.feedTableView reloadData];
        });
    });
}


- (void) saeCloud
{
    /*SCS 获取文件列表
     ASIS3BucketRequest *listRequest = [ASIS3BucketRequest requestWithBucket:@"akappios02"];
     [listRequest setPrefix:@"img"];
     [listRequest setMaxResultCount:50]; // Max number of results
     [listRequest startSynchronous];
     
     if (![listRequest error]) {
     NSLog(@"%@",[listRequest objects]);
     NSArray *objects = [listRequest objects];
     NSLog(@"%@", objects);
     }
     */
    
    //下载文件
    ASIS3ObjectRequest *request = [ASIS3ObjectRequest requestWithBucket:@"akappios02" key:@"userList.plist"];
    [request setDownloadDestinationPath:filepath];
    [request startSynchronous];
    
    if ([request error]) {
        NSLog(@"%@",[[request error] localizedDescription]);
    }
    
    //处理文件
    userData =[[NSMutableDictionary alloc] initWithContentsOfFile:filepath];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self _loadFeedViewControllers];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    self.title = NSLocalizedString(@"朋友圈公告板", @"");
    self.view.backgroundColor = [UIColor whiteColor];
    self.feedTableView.separatorColor = [UIColor grayColor];
    
    //存取文件路径
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [path objectAtIndex:0];
    filepath = [documents stringByAppendingPathComponent:@"userList.plist"];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)sign{
    signAlert = [[UIAlertView alloc]initWithTitle:@"登录" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    signAlert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    [signAlert show];
}

-(void)sendSign{
    [self saeCloud];
    NSDictionary *inputAC = [userData objectForKey:accoutName];
    if ([userData objectForKey:accoutName]) {
        if ([[inputAC valueForKey:@"userPWD"] isEqualToString:accoutPassword]) {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:accoutName forKey:@"userid"];
            [userDefaults setObject:[inputAC valueForKey:@"user"] forKey:@"user"];
            [userDefaults setObject:[inputAC valueForKey:@"userGroup"] forKey:@"userGroup"];
            [userDefaults synchronize];
            
            NSDictionary *nullDc = [[NSDictionary alloc]init];
            [nullDc writeToFile:filepath atomically:YES];
            
        }
        else{
            NSDictionary *nullDc = [[NSDictionary alloc]init];
            [nullDc writeToFile:filepath atomically:YES];
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:@" " forKey:@"userid"];
            [userDefaults setObject:@" " forKey:@"user"];
            [userDefaults setObject:@" " forKey:@"userGroup"];
            [userDefaults synchronize];
            UIAlertView  *erroAlert = [[UIAlertView alloc]initWithTitle:@"信息" message:@"用户名或密码错误,请联系管理员修改密码或注册用户" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
            [erroAlert show];
            
        }
    }
    else{
        NSDictionary *nullDc = [[NSDictionary alloc]init];
        [nullDc writeToFile:filepath atomically:YES];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:@" " forKey:@"userid"];
        [userDefaults setObject:@" " forKey:@"user"];
        [userDefaults setObject:@" " forKey:@"userGroup"];
        [userDefaults synchronize];
        UIAlertView  *erroAlert = [[UIAlertView alloc]initWithTitle:@"信息" message:@"用户名或密码错误,请联系管理员修改密码或注册用户" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [erroAlert show];
    }
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1 ) {
        UITextField *name=[alertView textFieldAtIndex:0];
        UITextField *pwd=[alertView textFieldAtIndex:1];
        accoutName = name.text;
        accoutPassword = pwd.text;
        [self sendSign];
    }
    else{
        NSDictionary *nullDc = [[NSDictionary alloc]init];
        [nullDc writeToFile:filepath atomically:YES];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:@" " forKey:@"userid"];
        [userDefaults setObject:@" " forKey:@"user"];
        [userDefaults setObject:@" " forKey:@"userGroup"];
        [userDefaults synchronize];
        [self alertViewCancel:alertView];
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
}

- (void)alertViewCancel:(UIAlertView *)alertView
{
    
}
#pragma mark - UITableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.profileImages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSString *className = self.profileImages[indexPath.row];
    NSString *founction = function[indexPath.row];
    cell.textLabel.text = founction;
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", className]];
    
    return cell;
}

#pragma mark - UITableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Class class = NSClassFromString(self.profileImages[indexPath.row]);
    if (indexPath.row == 3) {
        [self sign];
    }
    else{
        id feedController = [[class alloc] init];
        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:feedController] animated:YES completion:NULL];
    }
}

@end
