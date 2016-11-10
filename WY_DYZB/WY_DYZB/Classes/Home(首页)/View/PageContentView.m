//
//  PageContentView.m
//  WY_DYZB
//
//  Created by apple on 16/10/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "PageContentView.h"

#define kContentCellId @"ContentCellID"

@interface PageContentView () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIViewController *parentController;
@property (nonatomic, strong) NSArray *childVCArray;
@property (nonatomic, assign) CGFloat startOffsetX;
@property (nonatomic, assign) BOOL isForbidScroll;

@end

@implementation PageContentView

#pragma mark - 懒加载
- (UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        // 1.创建布局对象
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        // 设置单元格的尺寸大小
        layout.itemSize = self.bounds.size;
        // 设置行间距
        layout.minimumLineSpacing = 0;
        // flowLayout的属性，设置横向滑动
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        // 2.创建UICollectionView
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollsToTop = NO;  // scrollsToTop是UIScrollView的一个属性，主要用于点击设备的状态栏时，是scrollsToTop == YES的控件滚动返回至顶部
        
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kContentCellId];
    }
    return _collectionView;
}

- (instancetype)initWithFrame:(CGRect)frame parentController:(UIViewController *)parentController childVCArray:(NSArray *)childVCArray
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        
        self.childVCArray = childVCArray;
        self.parentController = parentController;
        
        [self setUpUI]; // 设置界面
    }
    
    return self;
}

#pragma mark - 初始化数据
- (void)initData
{
    _startOffsetX = 0;
    _isForbidScroll = NO;
}

#pragma mark - 设置界面
- (void)setUpUI
{
    // 1.将所有的子控制器添加到父控制器中
    for (UIViewController *child in _childVCArray)
    {
        [_parentController addChildViewController:child];
    }
    
    // 2.添加UICollectionView，用于在cell中存放控制器的View
    [self addSubview:self.collectionView];          // collectionView必须用self.collectionView,否则不会进入懒加载模式
    self.collectionView.frame = self.bounds;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.childVCArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 创建cell
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kContentCellId forIndexPath:indexPath];
    
    // 设置内容前先情况复用的数据
    for (UIView *view in cell.contentView.subviews)
    {
        [view removeFromSuperview];
    }
    
    UIViewController *childVC = _childVCArray[indexPath.row];
    childVC.view.frame = cell.contentView.bounds;
    [cell.contentView addSubview:childVC.view];
    
    return cell;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _isForbidScroll = NO;
    _startOffsetX = scrollView.contentOffset.x;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 判断是否是点击事件
    if (_isForbidScroll){
        return;
    }
    
    // 定义获取需要的数据
    CGFloat progress = 0;   // 当前滚动的进度
    NSInteger sourceIndex = 0;   // 起始位置下标
    NSInteger targetIndex = 0;    // 目标位置下标

    // 判断是左滑还是右滑
    CGFloat currentOffsetX = scrollView.contentOffset.x;
    CGFloat scrollViewW = scrollView.bounds.size.width;
    if (currentOffsetX > _startOffsetX){ // 左滑
        // 1、计算进度progress
        progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW);
        
        // 2、计算起始位置下标sourceIndex
        sourceIndex = (NSInteger)(currentOffsetX / scrollViewW);
        
        // 3、计算targetIndex
        targetIndex = sourceIndex + 1;
        
        if (targetIndex >= self.childVCArray.count){
            targetIndex = self.childVCArray.count - 1;
        }
        
        // 4、完全划过去
        if (currentOffsetX - _startOffsetX == scrollViewW){
            progress = 1;
            targetIndex = sourceIndex;
        }
    }else{  // 右滑
        // 1、计算进度progress
        progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW));
        
        // 2、计算目标位置下标targetIndex
        targetIndex = (NSInteger)(currentOffsetX / scrollViewW);
        
        // 3、计算初始位置下标sourceIndex
        sourceIndex = targetIndex + 1;
        
        if (sourceIndex >= self.childVCArray.count){
            sourceIndex = self.childVCArray.count - 1;
        }
    }
    
    // 将progress/sourceIndex/targetIndex传递给titleView
    if ([_delegate respondsToSelector:@selector(contentScrollWithProgress:sourceIndex:targetIndex:)]){
        [_delegate contentScrollWithProgress:progress sourceIndex:sourceIndex targetIndex:targetIndex];
    }
}

#pragma mark - 对外暴露的方法
- (void)setCurrentIndex:(NSInteger)currentIndex
{
    _isForbidScroll = YES;      // 设置禁止滑动
    
    // 滚动到正确位置
    CGFloat offsetX = currentIndex * _collectionView.frame.size.width;
    [_collectionView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
