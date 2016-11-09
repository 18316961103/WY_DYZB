//
//  RecommendGameView.m
//  WY_DYZB
//
//  Created by apple on 16/11/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "RecommendGameView.h"
#import "RecommendGameCell.h"

#define kRecommendGameCellId @"RecommendGameCellId"

#define kItemW 130*KPixel        // item的宽度

@interface RecommendGameView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) UICollectionView *collectionView;

@end

@implementation RecommendGameView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
//        self.autoresizingMask = UIViewAutoresizingNone;
        [self setUpSubViews];   // 设置子控件
    }
    return self;
}

#pragma mark - 设置子控件
- (void)setUpSubViews{
    
    [self addSubview:self.collectionView];
}

#pragma mark - 懒加载
- (UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        // 创建布局
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        layout.itemSize = CGSizeMake(kItemW, self.height);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;     // 设置水平滑动,默认垂直滑动
    
//        layout.headerReferenceSize = CGSizeMake(kScreenWidth, kHeaderViewH);
//        layout.footerReferenceSize = CGSizeMake(kScreenWidth, kFooterViewH);
//        layout.sectionInset = UIEdgeInsetsMake(0, kItemMargin, 0, kItemMargin);
        
        // 创建collectionview
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height) collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = kWhiteColor;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[RecommendGameCell class] forCellWithReuseIdentifier:kRecommendGameCellId];  // 注册collectionViewCell
    }
    
    return _collectionView;
}

- (void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    
    [self.collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(kItemW, self.height);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    RecommendGameCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kRecommendGameCellId forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[RecommendGameCell alloc] init];
    }
    
    RecommendGameModel *model = [RecommendGameModel objectWithKeyValues:_dataArray[indexPath.row]];
    
    [cell setRecommendGameModel:model];
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog_Cus(@"indexPath.row = %ld",indexPath.row);
}

@end
