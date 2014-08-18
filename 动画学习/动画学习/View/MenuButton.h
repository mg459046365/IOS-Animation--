//
//  MenuButton.h
//  动画学习
//
//  Created by cheng on 14-8-15.
//  Copyright (c) 2014年 cheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

@interface MenuButton : UIButton
{
    struct CGPath *shortStroke;
    struct CGPath *outline;
    
    CGFloat menuStrokeStart;
    CGFloat menuStrokeEnd;
    CGFloat hamburgerStrokeStart;
    CGFloat hamburgerStrokeEnd;
    
    BOOL isShow;
}

@property (nonatomic,strong) CAShapeLayer *top;
@property (nonatomic,strong) CAShapeLayer *bottom;
@property (nonatomic,strong) CAShapeLayer *middle;
@property (nonatomic,assign) BOOL isShow;

- (void)showOrHide:(BOOL)is;

@end
