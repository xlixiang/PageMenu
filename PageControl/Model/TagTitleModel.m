//
//  TagTitleModel.m
//  PageControl
//
//  Created by lixiang_x on 15/10/16.
//  Copyright © 2015年 lixiang_x. All rights reserved.
//

#import "TagTitleModel.h"

@implementation TagTitleModel

+ (TagTitleModel *)initModelWithTagTitle:(NSString *)title
                           andNormalFont:(UIFont *)normalFont
                          andNormalColor:(UIColor *)normalColor
                         andSelectedFont:(UIFont *)selectedFont
                        andSelectedColor:(UIColor *)selectedColor {
    TagTitleModel *tagModel = [[self alloc] init];
    tagModel.tagTitle = title;
    tagModel.normalTitleFont = normalFont;
    tagModel.normalTitleColor = normalColor;
    tagModel.selectedTitleColor = selectedColor;
    tagModel.selectedTitleFont = selectedFont;
    return tagModel;
}

@end
