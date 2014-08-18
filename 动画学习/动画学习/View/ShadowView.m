//
//  ShadowView.m
//  动画学习
//
//  Created by cheng on 14-8-15.
//  Copyright (c) 2014年 cheng. All rights reserved.
//

#import "ShadowView.h"

@implementation ShadowView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self addview];
    }
    return self;
}

- (void)addview
{
    [self.layer setBackgroundColor:[UIColor colorWithRed:0.634 green:0.63 blue:0.63 alpha:1].CGColor];
    UIImage *img = [UIImage imageNamed:@"8.png"];
    CALayer *toplayer = [[CALayer alloc]init];
    [toplayer setBounds:CGRectMake(0, 0, 320, 240)];
    [toplayer setPosition:CGPointMake(160, 120)];
    [toplayer setContents:(id)[img CGImage]];
    [self.layer addSublayer:toplayer];
    
    CALayer *reflectionLayer = [[CALayer alloc]init];
    [reflectionLayer setBounds:CGRectMake(0, 0, 320, 240)];
    [reflectionLayer setPosition:CGPointMake(158, 362)];
    [reflectionLayer setContents:[toplayer contents]];
    reflectionLayer.transform = CATransform3DMakeRotation(M_PI, 1, 0, 0);
    
    CAGradientLayer*gradientLayer = [[CAGradientLayer alloc] init];
    [gradientLayer setBounds:[reflectionLayer bounds]];
    [gradientLayer setPosition:
     CGPointMake([reflectionLayer bounds].size.width/2, [reflectionLayer bounds].size.height/2)];
    [gradientLayer setColors:[NSArray arrayWithObjects: (id)[[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5] CGColor],
                             (id)[[UIColor blackColor]CGColor], nil]];
    // Override the default startand end points to give the gradient // the right look
    [gradientLayer setStartPoint:CGPointMake(0.5,0.35)];
    [gradientLayer setEndPoint:CGPointMake(0.5,1.0)];
    // Set the reflection layer’smask to the gradient layer
    [reflectionLayer setMask:gradientLayer];
    // Add the reflection layerto the view
    [[self layer]addSublayer:reflectionLayer];
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
