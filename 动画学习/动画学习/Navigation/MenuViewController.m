//
//  MenuViewController.m
//  动画学习
//
//  Created by cheng on 14-8-15.
//  Copyright (c) 2014年 cheng. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuButton.h"

@interface MenuViewController ()

@property (nonatomic,strong) MenuButton *button;

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
