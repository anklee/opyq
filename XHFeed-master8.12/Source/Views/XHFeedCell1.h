//
//  XHFeedCell1.h
//  XHFeed
//
//  Created by anklee on 8/6/15.
//  Copyright (c) 2015 anklee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XHFeedCell1 : UITableViewCell

@property (nonatomic, strong) UIImageView* picImageView;

@property (nonatomic, strong) UIView* feedContainer;

@property (nonatomic, strong) UILabel* nameLabel;

@property (nonatomic, strong) UILabel* updateLabel;

@property (nonatomic, strong) UILabel* dateLabel;

@property (nonatomic, strong) UILabel* commentCountLabel;

@property (nonatomic, strong) UILabel* likeCountLabel;

@property (nonatomic, strong) UIImageView* commentIconImageView;

@property (nonatomic, strong) UIImageView* likeIconImageView;

@property (nonatomic, strong) UIColor *contentColor;

@end
