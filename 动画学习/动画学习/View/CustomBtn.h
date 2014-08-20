//
//  CustomBtn.h
//  动画学习
//
//  Created by cheng on 14-8-20.
//  Copyright (c) 2014年 cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomBtn : UIView

@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,assign) NSInteger itemIndex;
@property (nonatomic,strong) UIColor *orginalBackgroundColor;
@property (nonatomic,assign) BOOL isSelected;

@end
