//
//  DrawViewController.m
//  动画学习
//
//  Created by cheng on 14-8-14.
//  Copyright (c) 2014年 cheng. All rights reserved.
//

#import "DrawViewController.h"
#import "CustomView.h"

@interface DrawViewController ()

@end

@implementation DrawViewController

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
    CustomView *custom = [[CustomView alloc] initWithFrame:CGRectMake(0, 80, 320, 488)];
    [self.view addSubview:custom];
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
