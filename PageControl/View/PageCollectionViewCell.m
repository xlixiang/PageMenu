//
//  PageCollectionViewCell.m
//  PageControl
//
//  Created by lixiang_x on 15/10/16.
//  Copyright © 2015年 lixiang_x. All rights reserved.
//

#import "PageCollectionViewCell.h"

@implementation PageCollectionViewCell

- (void)configCellWithController:(UIViewController *)controller {
    controller.view.frame = self.bounds;
    [self.contentView addSubview:controller.view];
}

@end
