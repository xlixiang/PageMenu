//
//  LXPageViewController.h
//  PageControl
//
//  Created by lixiang_x on 15/10/16.
//  Copyright © 2015年 lixiang_x. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXPageViewController : UIViewController

//要显示的子控制器的类名数组
@property (nonatomic, strong) NSArray *displaySubClasses;
//自控制器对应的标签页数组
@property (nonatomic, strong) NSArray *tagTitleArray;

@end
