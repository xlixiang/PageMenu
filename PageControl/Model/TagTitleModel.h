//
//  TagTitleModel.h
//  PageControl
//
//  Created by lixiang_x on 15/10/16.
//  Copyright © 2015年 lixiang_x. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TagTitleModel : NSObject

@property (nonatomic, copy) NSString  *tagTitle;
//正常状态相关属性
@property (nonatomic, strong) UIFont  *normalTitleFont;
@property (nonatomic, strong) UIColor *normalTitleColor;
//选中状态相关属性
@property (nonatomic, strong) UIFont  *selectedTitleFont;
@property (nonatomic, strong) UIColor *selectedTitleColor;

+ (TagTitleModel *)initModelWithTagTitle:(NSString *)title
                           andNormalFont:(UIFont *)normalFont
                          andNormalColor:(UIColor *)normalColor
                         andSelectedFont:(UIFont *)selectedFont
                        andSelectedColor:(UIColor *)selectedColor;

@end
