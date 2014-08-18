//
//  MenuButton.m
//  动画学习
//
//  Created by cheng on 14-8-15.
//  Copyright (c) 2014年 cheng. All rights reserved.
//

#import "MenuButton.h"
#import <QuartzCore/QuartzCore.h>

@interface MenuButton ()

@end
@interface CALayer ()

- (void)ocb_applyAnimation:(CABasicAnimation*)animation;

@end
@implementation MenuButton
@synthesize isShow = _isShow;
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        isShow = YES;
        shortStroke = CGPathCreateMutable();
        CGPathMoveToPoint(shortStroke, nil, 2, 2);
        CGPathAddLineToPoint(shortStroke, nil, 28, 2);
        
        outline = CGPathCreateMutable();
        CGPathMoveToPoint(outline, nil, 10, 27);
        CGPathAddCurveToPoint(outline, nil, 12.00, 27.00, 28.02, 27.00, 40, 27);
        CGPathAddCurveToPoint(outline, nil, 55.92, 27.00, 50.47,  2.00, 27,  2);
        CGPathAddCurveToPoint(outline, nil, 13.16,  2.00,  2.00, 13.16,  2, 27);
        CGPathAddCurveToPoint(outline, nil,  2.00, 40.84, 13.16, 52.00, 27, 52);
        CGPathAddCurveToPoint(outline, nil, 40.84, 52.00, 52.00, 40.84, 52, 27);
        CGPathAddCurveToPoint(outline, nil, 52.00, 13.16, 42.39,  2.00, 27,  2);
        CGPathAddCurveToPoint(outline, nil, 13.16,  2.00,  2.00, 13.16,  2, 27);
        
        menuStrokeEnd = 0.9;
        menuStrokeStart = 0.325;
        hamburgerStrokeStart = 0.028;
        hamburgerStrokeEnd = 0.111;
        
        self.top = [[CAShapeLayer alloc]init];
        self.middle = [[CAShapeLayer alloc]init];
        self.bottom = [[CAShapeLayer alloc]init];
        
        self.top.path = shortStroke;
        self.middle.path = outline;
        self.bottom.path = shortStroke;
        NSArray *array = [NSArray arrayWithObjects:self.top,self.middle,self.bottom, nil];
        for (CAShapeLayer *layer in array) {
            layer.fillColor  = nil;
            layer.strokeColor = [UIColor whiteColor].CGColor;
            layer.lineWidth = 4;
            layer.miterLimit = 4;
            layer.lineCap = kCALineCapRound;
            layer.masksToBounds = true;
            
            CGPathRef strokingPath = CGPathCreateCopyByStrokingPath(layer.path, nil, 4, kCGLineCapRound, kCGLineJoinMiter, 4);
            layer.bounds = CGPathGetBoundingBox(strokingPath);
            layer.actions =[NSDictionary dictionaryWithObjectsAndKeys:[NSNull null],@"strokeStart",[NSNull null] ,@"strokeEnd",[NSNull null],@"transform", nil];
            
            [self.layer addSublayer:layer];
        }
        self.top.anchorPoint = CGPointMake(28.0/30.0, 0.5);
        self.top.position = CGPointMake(40, 18);
        
        self.middle.position = CGPointMake(27, 27);
        self.middle.strokeStart = hamburgerStrokeStart;
        self.middle.strokeEnd = hamburgerStrokeEnd;
        
        self.bottom.anchorPoint = CGPointMake(28.0 / 30.0, 0.5);
        self.bottom.position = CGPointMake(40, 36);
    }
    return self;
}
- (void)showOrHide:(BOOL)is
{
    isShow = is;
    CABasicAnimation *strokeStart = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    CABasicAnimation *strokeEnd = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    
    if (is) {
        strokeStart.toValue = [NSNumber numberWithFloat:menuStrokeStart];
        strokeStart.duration = 0.5;
        strokeStart.timingFunction = [[CAMediaTimingFunction alloc]initWithControlPoints:0.25 :-0.4 :0.5 :1];
        
        strokeEnd.toValue = [NSNumber numberWithFloat:menuStrokeEnd];
        strokeEnd.duration = 0.6;
        strokeEnd.timingFunction = [[CAMediaTimingFunction alloc]initWithControlPoints:0.25 :-0.4 :0.5 :1];
    } else {
        strokeStart.toValue = [NSNumber numberWithFloat:hamburgerStrokeStart];
        strokeStart.duration = 0.5;
        strokeStart.timingFunction = [[CAMediaTimingFunction alloc]initWithControlPoints:0.25 :0 :0.5 :1.2];
        strokeStart.beginTime = CACurrentMediaTime() + 0.1;
        strokeStart.fillMode = kCAFillModeBackwards;
        
        strokeEnd.toValue = [NSNumber numberWithFloat:hamburgerStrokeEnd];
        strokeEnd.duration = 0.6;
        strokeEnd.timingFunction = [[CAMediaTimingFunction alloc]initWithControlPoints:0.25 :0.3 :0.5 :0.9];
    }
    
    CABasicAnimation *copy2 = strokeStart.copy;
    if (!copy2.fromValue) {
        copy2.fromValue = [[self.middle presentationLayer] valueForKey:copy2.keyPath];
    }
    [self.middle addAnimation:copy2 forKey:copy2.keyPath];
    [self.middle setValue:copy2.toValue forKey:copy2.keyPath];
    
    CABasicAnimation *copy3 = strokeEnd.copy;
    if (!copy3.fromValue) {
        copy3.fromValue = [[self.middle presentationLayer] valueForKey:copy3.keyPath];
    }
    [self.middle addAnimation:copy3 forKey:copy3.keyPath];
    [self.middle setValue:copy3.toValue forKey:copy3.keyPath];
    
    
    CABasicAnimation *topTransform = [CABasicAnimation animationWithKeyPath:@"transform"];
    topTransform.timingFunction = [[CAMediaTimingFunction alloc]initWithControlPoints:0.25 :-0.8 :0.5 :1.85];
    topTransform.duration = 0.4;
    topTransform.fillMode = kCAFillModeBackwards;
    
    CABasicAnimation *bottomTransform = [topTransform copy];
    
    if (is) {
        CATransform3D translation = CATransform3DMakeTranslation(-4, 0, 0);
        
        topTransform.toValue = [NSValue valueWithCATransform3D:CATransform3DRotate(translation, -0.7853975, 0, 0, 1)];
        topTransform.beginTime = CACurrentMediaTime() + 0.25;
        
        bottomTransform.toValue = [NSValue valueWithCATransform3D:CATransform3DRotate(translation, 0.7853975, 0, 0, 1)];
        bottomTransform.beginTime = CACurrentMediaTime() + 0.25;
    } else {
        topTransform.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
        topTransform.beginTime = CACurrentMediaTime() + 0.05;
        
        bottomTransform.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
        bottomTransform.beginTime = CACurrentMediaTime() + 0.05;
    }
    
    
    CABasicAnimation *copy = topTransform.copy;
    if (!copy.fromValue) {
        copy.fromValue = [[self.top presentationLayer] valueForKey:copy.keyPath];
    }
    [self.top addAnimation:copy forKey:topTransform.keyPath];
    [self.top setValue:copy.toValue forKey:copy.keyPath];
    
    CABasicAnimation *copy1 = bottomTransform.copy;
    if (!copy1.fromValue) {
        copy1.fromValue = [[self.bottom presentationLayer] valueForKey:copy1.keyPath];
    }
    [self.bottom addAnimation:copy1 forKey:bottomTransform.keyPath];
    [self.bottom setValue:copy1.toValue forKey:copy1.keyPath];
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

