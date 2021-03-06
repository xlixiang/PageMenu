//
//  TagCollectionViewCell.m
//  PageControl
//
//  Created by lixiang_x on 15/10/16.
//  Copyright © 2015年 lixiang_x. All rights reserved.
//

#import "TagCollectionViewCell.h"
#import "TagTitleModel.h"
@interface TagCollectionViewCell()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation TagCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_titleLabel];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    if (highlighted) {
        self.titleLabel.font = self.tagTitleModel.selectedTitleFont;
        self.titleLabel.textColor = self.tagTitleModel.selectedTitleColor;
    }else {
        self.titleLabel.font = self.tagTitleModel.normalTitleFont;
        self.titleLabel.textColor = self.tagTitleModel.normalTitleColor;
    }
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if (selected) {
        self.titleLabel.font = self.tagTitleModel.selectedTitleFont;
        self.titleLabel.textColor = self.tagTitleModel.selectedTitleColor;
    }else {
        self.titleLabel.font = self.tagTitleModel.normalTitleFont;
        self.titleLabel.textColor = self.tagTitleModel.normalTitleColor;
    }
}

- (void)setTagTitleModel:(TagTitleModel *)tagTitleModel {
    _tagTitleModel = tagTitleModel;
    [self updateUI];
}

- (void)updateUI {
    self.titleLabel.text = self.tagTitleModel.tagTitle;
    self.titleLabel.font = self.tagTitleModel.normalTitleFont;
    self.titleLabel.textColor = self.tagTitleModel.normalTitleColor;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.frame = self.bounds;
}

@end
