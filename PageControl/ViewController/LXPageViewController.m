//
//  LXPageViewController.m
//  PageControl
//
//  Created by lixiang_x on 15/10/16.
//  Copyright © 2015年 lixiang_x. All rights reserved.
//

#import "LXPageViewController.h"
#import "Common.h"
#import "TagCollectionViewCell.h"
#import "PageCollectionViewCell.h"
#import "TagTitleModel.h"

@interface LXPageViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    //tagView Title的相关属性
    UIFont  *_normalFont;
    UIColor *_normalColor;
    UIFont  *_selectedFont;
    UIColor *_selectedColor;
}
//顶部标签View
@property (nonatomic, strong) UICollectionView *tagCollectionView;
@property (nonatomic, assign) CGFloat tagViewHeight;//标签视图的高度
@property (nonatomic, assign) CGFloat tagViewItemWidth;//标签视图Item的宽度
@property (nonatomic, strong) NSMutableArray  *tagTitleModelArray;
//选择指示视图
@property (nonatomic, strong) UIView *selectionIndicator;
//当前选中的标签索引
@property (nonatomic, assign) NSInteger selectedIndex;
//页面展示View
@property (nonatomic, strong) UICollectionView *pageCollectionView;

@end

@implementation LXPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [self initTagProperties];
    [self.view addSubview:self.tagCollectionView];
    [self.view addSubview:self.pageCollectionView];
    
    [self convertTitleToTagTitleModel:self.tagTitleArray];
    
    [self collectionView:self.tagCollectionView didSelectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - init
//初始化标签视图的相关属性
- (void)initTagProperties {
    _normalFont = [UIFont systemFontOfSize:14];
    _normalColor = [UIColor darkGrayColor];
    _selectedFont = [UIFont systemFontOfSize:16];
    _selectedColor = [UIColor redColor];
    self.selectedIndex = -1;
    self.tagViewHeight = 40;
    self.tagViewItemWidth = 50;
}

#pragma mark - pravite method
//将顶部标签视图的title转换到对应的model
- (void)convertTitleToTagTitleModel:(NSArray *)titleArray {
    [self.tagTitleModelArray removeAllObjects];
    for (int i = 0; i < titleArray.count; i++) {
        TagTitleModel *tagModel = [TagTitleModel initModelWithTagTitle:titleArray[i] andNormalFont:_normalFont andNormalColor:_normalColor andSelectedFont:_selectedFont andSelectedColor:_selectedColor];
        [self.tagTitleModelArray addObject:tagModel];
    }
}

#pragma mark -UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.tagTitleModelArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.tagCollectionView) {
        TagCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kTagViewCellIdentify forIndexPath:indexPath];
        TagTitleModel *tagModel = self.tagTitleModelArray[indexPath.item];
        cell.tagTitleModel = tagModel;
        [cell setSelected:(self.selectedIndex == indexPath.item)?YES:NO];
        cell.backgroundColor = [UIColor whiteColor];
        return cell;
    }else if(collectionView == self.pageCollectionView){
        PageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kPageViewCellIdentify forIndexPath:indexPath];
        Class displayClass = self.displaySubClasses[indexPath.item];
        UIViewController *cacheViewController = [[displayClass alloc] init];
        [self addChildViewController:cacheViewController];
        [cell configCellWithController:cacheViewController];
        return cell;
    }
    return nil;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.tagCollectionView) {
        [collectionView deselectItemAtIndexPath:indexPath animated:YES];
        self.selectedIndex = indexPath.item;
        
        UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
        
        if (self.selectionIndicator.center.x != cell.center.x) {
            [UIView animateWithDuration:0.3 animations:^{
                CGPoint center = self.selectionIndicator.center;
                if (cell.center.x > 0) {
                    center.x = cell.center.x;
                }else {
                    center.x = 25;
                }
                
                self.selectionIndicator.center = center;
            }];
        }
        
        [collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
        
        [self.pageCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionRight animated:NO];
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout Protocol Methods
//计算cell的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    if (collectionView == self.tagCollectionView) {     //标签
        return CGSizeMake(self.tagViewItemWidth, self.tagViewHeight);
        
    }else
    {
        return collectionView.frame.size;
    }
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.pageCollectionView) {
        int index = scrollView.contentOffset.x / self.pageCollectionView.frame.size.width;
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
        [self collectionView:self.tagCollectionView didSelectItemAtIndexPath:indexPath];
    }
}

#pragma mark - getter
- (UICollectionView *)tagCollectionView {
    if (_tagCollectionView == nil) {
        UICollectionViewFlowLayout *tagFlowLayout = [[UICollectionViewFlowLayout alloc] init];
        tagFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        tagFlowLayout.minimumLineSpacing = 0;
        tagFlowLayout.minimumInteritemSpacing = 0;
        
        _tagCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, LXScreenWidth, self.tagViewHeight) collectionViewLayout:tagFlowLayout];
        [_tagCollectionView registerClass:[TagCollectionViewCell class] forCellWithReuseIdentifier:kTagViewCellIdentify];
        _tagCollectionView.backgroundColor = [UIColor whiteColor];
        _tagCollectionView.dataSource = self;
        _tagCollectionView.delegate = self;
        _tagCollectionView.showsHorizontalScrollIndicator = NO;
        [_tagCollectionView addSubview:self.selectionIndicator];
    }
    return _tagCollectionView;
}

- (UICollectionView *)pageCollectionView {
    if (_pageCollectionView == nil) {
        UICollectionViewFlowLayout *pageFlowLayout = [[UICollectionViewFlowLayout alloc] init];
        pageFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        pageFlowLayout.minimumInteritemSpacing = 0;
        pageFlowLayout.minimumLineSpacing = 0;
        
        _pageCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.tagViewHeight, LXScreenWidth, self.view.frame.size.height - self.tagViewHeight) collectionViewLayout:pageFlowLayout];
        [_pageCollectionView registerClass:[PageCollectionViewCell class] forCellWithReuseIdentifier:kPageViewCellIdentify];
        _pageCollectionView.backgroundColor = [UIColor purpleColor];
        _pageCollectionView.dataSource = self;
        _pageCollectionView.delegate = self;
        _pageCollectionView.pagingEnabled = YES;
        
    }
    return _pageCollectionView;
}

- (UIView *)selectionIndicator {
    if (_selectionIndicator == nil) {
        _selectionIndicator = [[UIView alloc] init];
        _selectionIndicator.backgroundColor = [UIColor redColor];
        _selectionIndicator.frame = CGRectMake(0, self.tagViewHeight - 2, self.tagViewItemWidth, 2);
    }
    return _selectionIndicator;
}

- (NSMutableArray *)tagTitleModelArray {
    if (_tagTitleModelArray == nil) {
        _tagTitleModelArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _tagTitleModelArray;
}

@end
