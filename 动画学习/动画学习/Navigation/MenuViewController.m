//
//  MenuViewController.m
//  动画学习
//
//  Created by cheng on 14-8-15.
//  Copyright (c) 2014年 cheng. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuButton.h"
#import "CustomBtn.h"

@interface MenuViewController ()

@property (nonatomic,strong) MenuButton *button;
@property (nonatomic,strong) CustomBtn *viewBtn;

@end

@implementation MenuViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:38.0 / 255 green:151.0 / 255 blue:68.0 / 255 alpha:1];
    
    self.button = [[MenuButton alloc]initWithFrame:CGRectMake(133, 133, 54, 54)];
    [self.button addTarget:self action:@selector(toggle:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];
    
    
    _viewBtn = [[CustomBtn alloc]init];
    _viewBtn.frame = CGRectMake(140, 250, 40, 40);
    _viewBtn.itemIndex = 0;
    _viewBtn.layer.cornerRadius = _viewBtn.frame.size.width/2.f;
    _viewBtn.clipsToBounds = YES;
    _viewBtn.imageView.image = [UIImage imageNamed:@"gear"];
    _viewBtn.layer.borderColor = [UIColor colorWithRed:240/255.f green:159/255.f blue:254/255.f alpha:1].CGColor;
    [self.view addSubview:_viewBtn];
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]];
}
- (void)handleTap:(UITapGestureRecognizer *)recognizer {
    CGPoint point = [recognizer locationInView:self.view];
    if (CGRectContainsPoint(_viewBtn.frame, point)) {
        [self didTapItemAtIndex:_viewBtn.itemIndex];
    }
}
- (void)didTapItemAtIndex:(NSUInteger)index {
    CustomBtn *view = _viewBtn;
    
    UIColor *stroke = [UIColor colorWithRed:240/255.f green:159/255.f blue:254/255.f alpha:1];
    if (view.isSelected) {
        view.layer.borderColor = [UIColor colorWithRed:240/255.f green:159/255.f blue:254/255.f alpha:1].CGColor;
        CABasicAnimation *borderAnimation = [CABasicAnimation animationWithKeyPath:@"borderColor"];
        borderAnimation.fromValue = (id)[UIColor clearColor].CGColor;
        borderAnimation.toValue = (id)[UIColor colorWithRed:240/255.f green:159/255.f blue:254/255.f alpha:1].CGColor;
        borderAnimation.duration = 0.5f;
        [view.layer addAnimation:borderAnimation forKey:nil];
    }else{
        view.layer.borderColor = [UIColor clearColor].CGColor;
    }CGRect pathFrame = CGRectMake(-CGRectGetMidX(view.bounds), -CGRectGetMidY(view.bounds), view.bounds.size.width, view.bounds.size.height);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:pathFrame cornerRadius:view.layer.cornerRadius];
    
    // accounts for left/right offset and contentOffset of scroll view
    CGPoint shapePosition = [self.view convertPoint:view.center fromView:self.view];
    
    CAShapeLayer *circleShape = [CAShapeLayer layer];
    circleShape.path = path.CGPath;
    circleShape.position = shapePosition;
    circleShape.fillColor = [UIColor clearColor].CGColor;
    circleShape.opacity = 0;
    circleShape.strokeColor = stroke.CGColor;
    circleShape.lineWidth = 2;
    
    [self.view.layer addSublayer:circleShape];
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(2.5, 2.5, 1)];
    
    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphaAnimation.fromValue = @1;
    alphaAnimation.toValue = @0;
    
    CAAnimationGroup *animation = [CAAnimationGroup animation];
    animation.animations = @[scaleAnimation, alphaAnimation];
    animation.duration = 0.5f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [circleShape addAnimation:animation forKey:nil];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)toggle:(id)sender
{
    if (self.button.isShow) {
        NSLog(@"YES");
    }else if (!self.button.isShow) {
        NSLog(@"NO");
    }
    self.button.isShow = !self.button.isShow;
    [self.button showOrHide:self.button.isShow];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
