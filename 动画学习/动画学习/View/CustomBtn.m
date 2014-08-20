//
//  CustomBtn.m
//  动画学习
//
//  Created by cheng on 14-8-20.
//  Copyright (c) 2014年 cheng. All rights reserved.
//

#import "CustomBtn.h"

@implementation CustomBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (instancetype)init
{
    if (self = [super init]) {
        _imageView = [[UIImageView alloc]init];
        _imageView.backgroundColor = [UIColor clearColor];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_imageView];
        
        _isSelected = NO;
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat inset = self.bounds.size.height/2;
    self.imageView.frame = CGRectMake(0, 0, inset, inset);
    self.imageView.center = CGPointMake(inset, inset);
    NSLog(@"%f",inset);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
