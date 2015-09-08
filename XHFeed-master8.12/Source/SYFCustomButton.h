//
//  SYFCustomButton.h
//  自定义的button
//
//  Created by anklee on 8/6/15.
//  Copyright (c) 2015 anklee. All rights reserved.
//
#define SYFWidth [UIScreen mainScreen].bounds.size.width
#define SYFHeight [UIScreen mainScreen].bounds.size.height
#define  SYFColor(x,y,z)  [UIColor colorWithRed:x/255.0 green:y/255.0 blue:z/255.0 alpha:1.0]
#import <UIKit/UIKit.h>

@interface SYFCustomButton : UIButton
+ (instancetype)titleButton;
@end
