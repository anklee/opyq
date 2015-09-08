//
//  SYFCustomButton.m
//  自定义的button
//
//  Created by anklee on 8/6/15.
//  Copyright (c) 2015 anklee. All rights reserved.
//

#import "SYFCustomButton.h"

#define BtnImageW 20

@implementation SYFCustomButton
-(void)awakeFromNib
{
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self setImage:[UIImage imageNamed:@"378-close"] forState:UIControlStateNormal];
    [self setTitle:@"140" forState:UIControlStateNormal];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.layer.cornerRadius = 2;
}

+ (instancetype)titleButton
{
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        // 高亮的时候不要自动调整图标
       self.adjustsImageWhenHighlighted = NO;
       // self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
          [self setImage:[UIImage imageNamed:@"378-close"] forState:UIControlStateNormal];
        //self.titleLabel.textAlignment = NSTextAlignmentCenter;
        // 背景
        //[self setBackgroundImage:[UIImage resizedImageWithName:@"navigationbar_filter_background_highlighted_os7@2x"] forState:UIControlStateHighlighted];
     //   [self setTitleColor:[UIColor colorWithRed:146/255.0 green:146/255.0 blue:146/255.0 alpha:1.0] forState:UIControlStateNormal];
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imgY = 0;
    CGFloat imgW = 15;
    CGFloat imgX =25;
    CGFloat imgH = contentRect.size.height;
    return CGRectMake(imgX, imgY, imgW, imgH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = 0;
    CGFloat titleX = 0;
    CGFloat titleW = 25;
    CGFloat titleH = contentRect.size.height;
    return CGRectMake(titleX, titleY, titleW, titleH);
}
@end
