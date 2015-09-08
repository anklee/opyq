//
//  XHFeedCell4.h
//  XHFeed
//
//  Created by anklee on 8/6/15.
//  Copyright (c) 2015 anklee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XHFeedCell4 : UITableViewCell
@property (nonatomic, strong) UIImageView* picImageView;

@property (nonatomic, strong) UIImageView* profileImageView;

@property (nonatomic, strong) UIView* feedContainer;

@property (nonatomic, strong) UILabel* nameLabel;

@property (nonatomic, strong) UILabel* updateLabel;

@property (nonatomic, strong) UILabel* dateLabel;

@property (nonatomic, strong) UILabel* commentCountLabel;

@property (nonatomic, strong) UILabel* likeCountLabel;

@property (nonatomic, strong) UIView* socialContainer;
@end
