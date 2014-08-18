//
//  CustomView.m
//  动画学习
//
//  Created by cheng on 14-8-14.
//  Copyright (c) 2014年 cheng. All rights reserved.
//

#import "CustomView.h"
#import <QuartzCore/QuartzCore.h>

#define PI 3.14159265358979323846

@implementation CustomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetRGBFillColor(context, 1, 0, 0, 1.0);
    
    UIFont *font = [UIFont systemFontOfSize:15.0];
    [@"画图:" drawInRect:CGRectMake(10, 20, 80, 20) withFont:font];
    [@"画线和弧线:" drawInRect:CGRectMake(10, 80, 100, 20) withFont:font];
    [@"画矩形：" drawInRect:CGRectMake(10, 120, 80, 20) withFont:font];
    [@"画扇形和椭圆：" drawInRect:CGRectMake(10, 160, 110, 20) withFont:font];
    [@"画三角形：" drawInRect:CGRectMake(10, 220, 80, 20) withFont:font];
    [@"画圆角矩形：" drawInRect:CGRectMake(10, 260, 100, 20) withFont:font];
    [@"画贝塞尔曲线：" drawInRect:CGRectMake(10, 300, 100, 20) withFont:font];
    [@"图片：" drawInRect:CGRectMake(10, 340, 80, 20) withFont:font];
    
    //画圆 边框园
    CGContextSetRGBStrokeColor(context, 1, 1, 1, 1.0);//画笔颜色
    CGContextSetLineWidth(context, 1.0);//画笔宽度
    //弧度＝180°/π （≈57.3°） 度＝弧度×180°/π 360°＝360×π/180 ＝2π 弧度
    // x,y为圆点坐标，radius半径，startAngle为开始的弧度，endAngle为 结束的弧度，clockwise 0为顺时针，1为逆时针。
    //CGContextAddArc(CGContextRef c,CGFloat x, CGFloat y,CGFloat radius,CGFloat startAngle,CGFloat endAngle, int clockwise)
    CGContextAddArc(context, 100, 20, 15, 0, 2*PI, 0);
    CGContextDrawPath(context, kCGPathStroke);//绘制路径
    //无边框园
    CGContextAddArc(context, 150, 30, 30, 0, 2*PI, 0);
    CGContextDrawPath(context, kCGPathFill);//绘制填充
    //有边框，并填充
    UIColor *acolor = [UIColor colorWithRed:1 green:0 blue:0 alpha:1.0];
    CGContextSetFillColorWithColor(context, acolor.CGColor);
    CGContextSetLineWidth(context, 2.0);
    CGContextAddArc(context, 250, 40, 40, 0, 2*PI, 0);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    
    //画线
    CGPoint apoint[2];
    apoint[0] = CGPointMake(100, 80);
    apoint[1] = CGPointMake(130, 80);
    //CGContextAddLines(CGContextRef c, const CGPoint points[],size_t count)
    //points[]坐标数组，和count大小
    CGContextAddLines(context, apoint, 2);
    CGContextDrawPath(context, kCGPathStroke);
    
    //画弧线
    //左右
    CGContextSetRGBStrokeColor(context, 0, 0, 1, 1);
    CGContextMoveToPoint(context, 140, 80);//开始坐标p1
    //CGContextAddArcToPoint(CGContextRef c, CGFloat x1, CGFloat y1,CGFloat x2, CGFloat y2, CGFloat radius)
    //x1,y1跟p1形成一条线的坐标p2，x2,y2结束坐标跟p3形成一条线的p3,radius半径,注意, 需要算好半径的长度,
    CGContextAddArcToPoint(context, 148, 68, 156, 80, 10);
    CGContextStrokePath(context);
    //右
    CGContextMoveToPoint(context, 150, 90);//开始坐标p1
    //CGContextAddArcToPoint(CGContextRef c, CGFloat x1, CGFloat y1,CGFloat x2, CGFloat y2, CGFloat radius)
    //x1,y1跟p1形成一条线的坐标p2，x2,y2结束坐标跟p3形成一条线的p3,radius半径,注意, 需要算好半径的长度,
    CGContextAddArcToPoint(context, 158, 102, 166, 90, 10);
    CGContextStrokePath(context);//绘画路径
    
    
    //画矩形
    CGContextStrokeRect(context, CGRectMake(100, 120, 10, 10));//画方框
    CGContextFillRect(context, CGRectMake(120, 120, 10, 10));//填充框
    CGContextSetLineWidth(context, 2.0);//线宽
    acolor = [UIColor blueColor];
    CGContextSetFillColorWithColor(context, acolor.CGColor);
    acolor = [UIColor yellowColor];
    CGContextSetStrokeColorWithColor(context, acolor.CGColor);
    CGContextAddRect(context, CGRectMake(140, 120, 60, 30));//画方框
    CGContextDrawPath(context, kCGPathFillStroke);//绘路径
    
    
    //画矩形，渐变颜色
    //第一种,在layer层画，不是使用context
    CAGradientLayer *gradient1 = [CAGradientLayer layer];
    gradient1.frame = CGRectMake(240, 120, 60, 30);
    gradient1.colors = [NSArray arrayWithObjects:(id)[UIColor whiteColor].CGColor,
                        (id)[UIColor grayColor].CGColor,
                        (id)[UIColor blackColor].CGColor,
                        (id)[UIColor yellowColor].CGColor,
                        (id)[UIColor blueColor].CGColor,
                        (id)[UIColor redColor].CGColor,
                        (id)[UIColor greenColor].CGColor,
                        (id)[UIColor orangeColor].CGColor,
                        (id)[UIColor brownColor].CGColor,nil];
    [self.layer insertSublayer:gradient1 atIndex:0];
    //第二种
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    CGFloat colors[] =
    {
        1,1,1,1.00,
        1,1,0,1.00,
        1,0,0, 1.00,
        1,0,1, 1.00,
        0,1,1, 1.00,
        0,1,0, 1.00,
        0,0,1, 1.00,
        0,0,0, 1.00,
    };
    CGGradientRef gradien = CGGradientCreateWithColorComponents(rgb, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));
    CGColorSpaceRelease(rgb);
    CGContextSaveGState(context);
    CGContextMoveToPoint(context, 220, 90);
    CGContextAddLineToPoint(context, 240, 90);
    CGContextAddLineToPoint(context, 240, 110);
    CGContextAddLineToPoint(context, 220, 110);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradien, CGPointMake(220, 90), CGPointMake(240, 110), kCGGradientDrawsAfterEndLocation);
    CGContextRestoreGState(context);
    
    //渐变的圆
    CGContextDrawRadialGradient(context, gradien,  CGPointMake(300, 100), 0.0, CGPointMake(300, 100), 10, kCGGradientDrawsBeforeStartLocation);
    
    
    //画扇形
    acolor = [UIColor colorWithRed:0 green:1 blue:1 alpha:1];
    CGContextSetFillColorWithColor(context, acolor.CGColor);
    CGContextMoveToPoint(context, 160, 180);
    CGContextAddArc(context, 160, 180, 30, -60*PI/180, -120*PI/180, 1);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    //画椭圆
    CGContextAddEllipseInRect(context, CGRectMake(160, 180, 20, 8));
    CGContextDrawPath(context, kCGPathFillStroke);
    
    //画三角形
    //得三个点，连起来
    CGPoint spoints[3];
    spoints[0]= CGPointMake(100, 220);
    spoints[1]= CGPointMake(130, 220);
    spoints[2]= CGPointMake(130, 160);
    CGContextAddLines(context, spoints, 3);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    //画圆角矩阵
    float fw=180;
    float fh=280;
    CGContextMoveToPoint(context, fw, fh-20);
    CGContextAddArcToPoint(context, fw, fh, fw-20, fh, 10); // 右下角角度
    CGContextAddArcToPoint(context, 120, fh, 120, fh-20, 10); // 左下角角度
    CGContextAddArcToPoint(context, 120, 250, fw-20, 250, 10); // 左上角
    CGContextAddArcToPoint(context, fw, 250, fw, fh-20, 10); // 右上角
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    //贝塞尔曲线
    //2次曲线
    CGContextMoveToPoint(context, 120, 300);//path的起点
    CGContextAddQuadCurveToPoint(context, 190, 310, 120, 390);
    CGContextStrokePath(context);
    //3次曲线
    CGContextMoveToPoint(context, 200, 300);
    CGContextAddCurveToPoint(context, 250, 280, 250, 400, 280, 300);
    CGContextStrokePath(context);
    
}


@end
