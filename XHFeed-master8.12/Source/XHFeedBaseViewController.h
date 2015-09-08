//
//  XHFeedBaseViewController.h
//  XHFeed
//
//  Created by anklee on 8/6/15.
//  Copyright (c) 2015 anklee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XHFeedBaseViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView* feedTableView;

@property (nonatomic, strong) NSArray* profileImages;

- (void)styleNavigationBarWithFontName:(NSString*)navigationTitleFont;

@end
