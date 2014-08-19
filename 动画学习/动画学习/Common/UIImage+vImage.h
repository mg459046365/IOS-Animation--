//
//  UIImage+vImage.h
//  动画学习
//
//  Created by cheng on 14-8-19.
//  Copyright (c) 2014年 cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage(vImage)

- (UIImage *)gaussianBlur;
- (UIImage *)blurryImagewithLevel:(CGFloat)blur;

- (UIImage *)equalization;

@end
