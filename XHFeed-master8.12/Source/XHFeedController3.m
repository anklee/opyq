//
//  XHFeedController3.m
//  XHFeed
//
//  Created by anklee on 8/6/15.
//  Copyright (c) 2015 anklee. All rights reserved.
//

#import "XHFeedController3.h"
#import "XHFeedCell3.h"

@interface XHFeedController3 ()

@end

@implementation XHFeedController3

#pragma mark - Left cycle init

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
    
    userDefaults = [NSUserDefaults standardUserDefaults];
	
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(reloadTab) name:@"reload" object:nil];
    
    NSString* boldFontName = @"Avenir-Black";
    [self styleNavigationBarWithFontName:boldFontName];
    
    UIImageView* seendView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"compose.png"]];
    seendView.frame = CGRectMake(0, 0, 22, 22);
    UIBarButtonItem* seendViewItem = [[UIBarButtonItem alloc] initWithCustomView:seendView];
    UITapGestureRecognizer *tapADD = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seendMsgClick)];
    [seendView addGestureRecognizer:tapADD];
    self.navigationItem.rightBarButtonItem = seendViewItem;
    
    self.title = @"朋友圈";
    
    self.feedTableView.separatorColor = [UIColor colorWithWhite:0.9 alpha:0.6];
    
    [self.view addSubview:self.feedTableView];
    
    self.profileImages = [NSArray arrayWithObjects:@"profile.jpg", @"profile-1.jpg", @"profile-2.jpg", @"profile-3.jpg", nil];
    
    //存取文件路径
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [path objectAtIndex:0];
    filepath = [documents stringByAppendingPathComponent:@"homeDataList.plist"];
    [self saeCloud];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return isIpad ? 250 : 125;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [homeTableArry count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"FeedCell3";
    XHFeedCell3* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[XHFeedCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    //sae数据处理
    NSMutableDictionary *msg = [[NSMutableDictionary alloc]init];
    int i=[homeTableArry count]-[indexPath row];
    NSString *valueStr = [NSString stringWithFormat:@"msg%d",i];
    msg = [HomeData objectForKey:valueStr];
    
    cell.nameLabel.text = [msg objectForKey:@"user"];
    cell.updateLabel.text = [msg objectForKey:@"text"];
    
    cell.dateLabel.text = [NSString stringWithFormat:@"%@",[msg objectForKey:@"time"]];
    cell.likeCountLabel.text = [NSString stringWithFormat:@"%@ 赞",[msg objectForKey:@"likes"]];
    cell.commentCountLabel.text = [NSString stringWithFormat:@"%@ 热度",[msg objectForKey:@"answer"]];
    
    NSString* profileImageName = self.profileImages[indexPath.row%self.profileImages.count];
    cell.profileImageView.image = [UIImage imageNamed:profileImageName];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int selectIndex = [homeTableArry count]-indexPath.row ;
    NSDictionary *clickMsgDic =[HomeData valueForKey:[NSString stringWithFormat:@"msg%d",selectIndex]];
    
    [userDefaults setObject:clickMsgDic forKey:@"clickMsgDic"];
    [self someButtonClicked];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


- (void)someButtonClicked {
    UIActionSheet * sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"赞" otherButtonTitles:@"评论", nil];
    sheet.destructiveButtonIndex = 1;
    [sheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        
        likeMD = [userDefaults objectForKey:@"clickMsgDic"];
        NSMutableDictionary *md = [[NSMutableDictionary alloc]initWithDictionary:likeMD];
        int like = [[likeMD valueForKey:@"answer"]intValue] + 1;
        NSString *likeStr = [NSString stringWithFormat:@"%d",like];
        [md setObject:likeStr forKey:@"answer"];
        [userDefaults setObject:md forKey:@"clickMsgDic"];
        [HomeData setObject:md forKey:[md valueForKey:@"msgid"]];
        [HomeData writeToFile:filepath atomically:YES];
        
        ASIS3ObjectRequest *upLoadRequest = [ASIS3ObjectRequest PUTRequestForFile:filepath withBucket:@"akappios02" key:@"homeDataList.plist"];
        [upLoadRequest startSynchronous];
        
        if ([upLoadRequest error]) {
            NSLog(@"%@",[[upLoadRequest error] localizedDescription]);
        }
        else{
            [self.feedTableView reloadData];
        }
        
        id feedController = [[BTViewController alloc] init];
        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:feedController] animated:YES completion:NULL];
    }
    else if (buttonIndex == 0){
        likeMD = [userDefaults objectForKey:@"clickMsgDic"];
        NSMutableDictionary *md = [[NSMutableDictionary alloc]initWithDictionary:likeMD];
        int like = [[likeMD valueForKey:@"likes"]intValue] + 1;
        NSString *likeStr = [NSString stringWithFormat:@"%d",like];
        [md setObject:likeStr forKey:@"likes"];
        [userDefaults setObject:md forKey:@"clickMsgDic"];
        [HomeData setObject:md forKey:[md valueForKey:@"msgid"]];
        [HomeData writeToFile:filepath atomically:YES];
        
        ASIS3ObjectRequest *upLoadRequest = [ASIS3ObjectRequest PUTRequestForFile:filepath withBucket:@"akappios02" key:@"homeDataList.plist"];
        [upLoadRequest startSynchronous];
        
        if ([upLoadRequest error]) {
            NSLog(@"%@",[[upLoadRequest error] localizedDescription]);
        }
        else{
            [self.feedTableView reloadData];
        }
        
    }
}


-(void) seendMsgClick
{
    
    id feedController = [[seendMsgViewViewController alloc] init];
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:feedController] animated:YES completion:NULL];
    
}

-(void)reloadTab{
    [self saeCloud];
    [self.feedTableView reloadData];
}
@end
