//
//  GameHeaderView.m
//  WY_DYZB
//
//  Created by apple on 16/11/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GameHeaderView.h"
#import "AmuseMenuViewCell.h"

#define kAmuseMenuId @"AmuseMenuId"       // 注册cell的ID
#define kItemCount 8                      // 一页cell的个数

@interface GameHeaderView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UIPageControl *pageControl;       // 分页

@end

@implementation GameHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpSubViews];   // 设置子控件
    }
    return self;
}

#pragma mark - 设置子控件
- (void)setUpSubViews{
    [self addSubview:self.collectionView];
    [self addSubview:self.pageControl];
}

#pragma mark - 懒加载
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(self.width, (self.height -30*KPixel));
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;     // 设置水平滑动，默认垂直滑动
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height-30*KPixel) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = kWhiteColor;
        _collectionView.showsHorizontalScrollIndicator = NO;        // 不显示水平滚动条
        _collectionView.pagingEnabled = YES;            // 分页显示
        [_collectionView registerClass:[AmuseMenuViewCell class] forCellWithReuseIdentifier:kAmuseMenuId]; // 注册cell
        
    }
    return _collectionView;
}

- (UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.height - 30*KPixel, self.width, 30*KPixel)];
        _pageControl.currentPageIndicatorTintColor = kOrangeColor;      // 当前页圆点的颜色
        _pageControl.pageIndicatorTintColor = kRGBColor(170, 170, 170);     //  非当前页圆点的颜色
        _pageControl.centerX = self.width/2;
        _pageControl.numberOfPages = 2;     // 分多少页
        _pageControl.currentPage = 0;       // 默认当前第几页
        _pageControl.userInteractionEnabled = NO;       // 设置不可点击
    }
    return _pageControl;
}

#pragma mark - 设置数据源
- (void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    
    [self.collectionView reloadData];
}

#pragma mark - UICollectionDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (_dataArray.count>8) {// 数据源大于8才返回两个cell
        return 2;
    }else if (_dataArray.count>0){
        return 1;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    AmuseMenuViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kAmuseMenuId forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[AmuseMenuViewCell alloc] init];
    }
    
    NSMutableArray *tempDataArray = [[NSMutableArray alloc] init];
    
    NSInteger upperLimit = (_dataArray.count >= ((indexPath.row + 1) * kItemCount)?((indexPath.row + 1) * kItemCount):(_dataArray.count-(indexPath.row * kItemCount))); // 判断当前组数据源是否大于((indexPath.row + 1) * 8)，如果大于等于则上限为((indexPath.row + 1) * 8)，如果不大于，则取_dataArray剩余的数据count为上限
    
    for (NSInteger i = (indexPath.row * kItemCount); i < upperLimit; i++) {
        [tempDataArray addObject:_dataArray[i]];
    }
    
    [cell setDataArray:tempDataArray];
    
    cell.backgroundColor = kWhiteColor;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog_Cus(@"indexPath.row = %ld",indexPath.row);
}

#pragma mark - collectionView 的滑动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.pageControl.currentPage = (NSInteger)(scrollView.contentOffset.x / scrollView.width);
}

@end
