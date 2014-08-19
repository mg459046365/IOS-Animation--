//
//  BlurViewController.m
//  动画学习
//
//  Created by cheng on 14-8-18.
//  Copyright (c) 2014年 cheng. All rights reserved.
//

#import "BlurViewController.h"
#import "UIImage+vImage.h"

@interface BlurViewController ()

@end

@implementation BlurViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"两张模糊,直方图均衡化";
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIImage *img = [UIImage imageNamed:@"Stars.png"];
    UIImage *imgBlur = [img gaussianBlur];
    self.imageBlur.image = imgBlur;
    
    UIImage *imageblur1 = [img blurryImagewithLevel:1.0];
    self.imageBlur1.image = imageblur1;
    UIImage *imageequal = [img equalization];
    self.equalization.image = imageequal;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
