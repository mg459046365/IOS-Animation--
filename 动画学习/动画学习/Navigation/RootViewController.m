//
//  RootViewController.m
//  动画学习
//
//  Created by cheng on 14-8-14.
//  Copyright (c) 2014年 cheng. All rights reserved.
//

#import "RootViewController.h"
#import "DrawViewController.h"
#import "AnimationViewController.h"
#import "MenuViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"root";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)click1:(id)sender
{
    [self.navigationController pushViewController:[[DrawViewController alloc]init] animated:YES];
}

- (void)click2:(id)sender
{
    [self.navigationController pushViewController:[[AnimationViewController alloc]init] animated:YES];
    
}

- (void)click3:(id)sender
{
    [self.navigationController pushViewController:[[MenuViewController alloc]init] animated:YES];
    
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
