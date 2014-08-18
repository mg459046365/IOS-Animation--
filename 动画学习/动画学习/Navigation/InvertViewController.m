//
//  InvertViewController.m
//  动画学习
//
//  Created by cheng on 14-8-15.
//  Copyright (c) 2014年 cheng. All rights reserved.
//

#import "InvertViewController.h"
#import "ShadowView.h"

@interface InvertViewController ()

@end

@implementation InvertViewController

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
    ShadowView *shadow = [[ShadowView alloc]initWithFrame:CGRectMake(0, 64, 320, 484)];
    [self.view addSubview:shadow];
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
