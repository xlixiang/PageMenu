//
//  ViewController.m
//  PageControl
//
//  Created by lixiang_x on 15/10/16.
//  Copyright © 2015年 lixiang_x. All rights reserved.
//

#import "ViewController.h"
#import "LXPageViewController.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    LXPageViewController *pageVC = [[LXPageViewController alloc] init];
    
    NSArray *array = @[@"hello", @"one", @"two", @"three", @"four", @"five", @"six", @"seven", @"eight"];
    
    pageVC.tagTitleArray = array;
    
    NSArray *VCArray = @[
                         [OneViewController class],
                         [TwoViewController class],
                         [ThreeViewController class],
                         [OneViewController class],
                         [TwoViewController class],
                         [ThreeViewController class],
                         [OneViewController class],
                         [TwoViewController class],
                         [ThreeViewController class],
                         ];
    pageVC.displaySubClasses = VCArray;
    
    [self addChildViewController:pageVC];
    [self.view addSubview:pageVC.view];

}
//隐藏状态栏
- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
