//
//  RecommendViewController.m
//  WY_DYZB
//
//  Created by apple on 16/10/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "RecommendViewController.h"
#import "RecommendReusableView.h"
#import "RecommendCollectionViewCell.h"
#import "RecommendYanzhiCell.h"
#import "WYCarouselView.h"
#import "RecommendGameView.h"

#define kItemMargin 10                                  // cell的间距
#define kItemW ((kScreenWidth - 3 * kItemMargin) / 2)   // cell的宽度
#define kNormalItemH (kItemW * 3 / 4)   // 普通cell的高度
#define kPrettyItemH (kItemW * 4 / 3)   // 颜值cell的高度
#define kHeaderViewH 80*KPixel           // collectionViewHeader的高度
#define kFooterViewH 10             // collectionView的footer高度
#define kCycleHeight 220*KPixel     // 无限轮播图片的高度
#define kGameHeight 130*KPixel     // 游戏展览的高度

#define kNormalCellId @"CollectionNormalCellId"
#define kYanZhiCellId @"CollectionYanZhiCellId"
#define kNormalHeaderId @"CollectionNormalHeaderId"
#define kNormalFooterId @"CollectionNormalFooterId"

@interface RecommendViewController () <UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSArray *_headerTitleArray; // 标题数组
    NSMutableArray *_recommendCycleImgUrlArray;    // 无限轮播的图片url数组
    NSMutableArray *_recommendCycleImgDescribeArray;   // 无限轮播的图片描述数组
    NSArray *_hotArray;         // 最热数据
    NSArray *_yanzhiArray;      // 颜值数据
    NSArray *_otherArray;      // 其他数据
}

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) WYCarouselView *recommendCycleView;       // 图片轮播的View
@property (strong, nonatomic) RecommendGameView *recommendGameView;     // 游戏展览

@end

@implementation RecommendViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:kRedColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self initData];        // 初始化数据
    [self sendRequest];     // 发送请求得到推荐数据
    
    // Do any additional setup after loading the view.
}

#pragma mark  - 初始化数据
- (void)initData{
    _headerTitleArray = @[@"最热",@"颜值",@"英雄联盟",@"户外",@"守望先锋",@"数码科技",@"皇室战争",@"星秀",@"鱼教",@"炉石传说",@"DOTA2"];
    _recommendCycleImgUrlArray = [[NSMutableArray alloc] init];
    _recommendCycleImgDescribeArray = [[NSMutableArray alloc] init];
}

#pragma mark - 发送请求得到推荐数据
- (void)sendRequest{
    [[NetworkSingleton sharedManager] getRecommendCycleDataWithSuccessBlock:^(id response) {
        NSArray *dataArray = [response objectForKey:@"data"];
        for (int i = 0; i < dataArray.count; i++) {
            NSDictionary *dicInfo = dataArray[i];
            [_recommendCycleImgUrlArray addObject:[dicInfo objectForKey:@"pic_url"]];
            [_recommendCycleImgDescribeArray addObject:[NSString stringWithFormat:@"    %@",[dicInfo objectForKey:@"title"]]];
        }
        
        _recommendCycleView.imageArray = _recommendCycleImgUrlArray;
        _recommendCycleView.describeArray = _recommendCycleImgDescribeArray;
        
    } failureBlock:^(NSString *error) {
        NSLog_Cus(@"error = %@",error);
    }];
    
    [[NetworkSingleton sharedManager] getRecommendDataWithSuccessBlock:^(id response) {
        NSArray *dataArray = response;
        
        NSLog_Cus(@"dataArray.count=====%ld",dataArray.count);
        
        if (dataArray.count>0) {
            _hotArray = dataArray[0];
            _yanzhiArray = dataArray[1];
            _otherArray = dataArray[2];
        }
        
        [self setUpSubViews];   // 设置子控件

        [self.collectionView reloadData];   // 刷新界面
        
    } failureBlock:^(NSString *error) {
        
    }];
}

#pragma mark - 设置子控件
- (void)setUpSubViews
{
    [self.view addSubview:self.collectionView];
    [self.collectionView addSubview:self.recommendCycleView];
    [self.collectionView addSubview:self.recommendGameView];
    self.recommendGameView.dataArray = _otherArray;
    self.collectionView.contentInset = UIEdgeInsetsMake(kCycleHeight + kGameHeight, 0, 0, 0);
}

#pragma mark - 懒加载
- (UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        // 创建布局
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        layout.itemSize = CGSizeMake(kItemW, kNormalItemH);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = kItemMargin;
        layout.headerReferenceSize = CGSizeMake(kScreenWidth, kHeaderViewH);
//        layout.footerReferenceSize = CGSizeMake(kScreenWidth, kFooterViewH);
        layout.sectionInset = UIEdgeInsetsMake(0, kItemMargin, 0, kItemMargin);
        
        // 创建collectionview
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kTabbarH - kNavigationBarH - kStatusBarH - 68*KPixel) collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = kWhiteColor;
        [_collectionView registerClass:[RecommendCollectionViewCell class] forCellWithReuseIdentifier:kNormalCellId];  // 注册collectionViewCell
        [_collectionView registerClass:[RecommendYanzhiCell class] forCellWithReuseIdentifier:kYanZhiCellId];  // 注册collectionViewCell
        [_collectionView registerClass:[RecommendReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kNormalHeaderId];  // 注册UICollectionReusableView
//        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kNormalFooterId];  // 注册UICollectionFooterView
    }
    
    return _collectionView;
}
#pragma mark - 无限轮播的图片
- (WYCarouselView *)recommendCycleView{
    if (!_recommendCycleView) {
        _recommendCycleView = [WYCarouselView wyCarouselWithFrame:CGRectMake(0, -(kCycleHeight+kGameHeight), kScreenWidth, kCycleHeight) imgArray:_recommendCycleImgUrlArray describeArray:_recommendCycleImgDescribeArray imageClickBlock:^(NSInteger currentIndex) {
            NSLog(@"点击的索引=======%ld",currentIndex);
        }];
        
        // 设置轮播时间,默认3s
        _recommendCycleView.time = 2;
        // 设置图片描述向左对齐，默认居中显示
        _recommendCycleView.describeLab.textAlignment = NSTextAlignmentLeft;
        //设置分页控件的frame，默认在下方居中
        _recommendCycleView.pageControl.frame = CGRectMake(_recommendCycleView.frame.size.width - _recommendCycleImgUrlArray.count * 20 - 0, _recommendCycleView.frame.size.height - 20 - 5, _recommendCycleImgUrlArray.count * 20, 20);
    }
    return _recommendCycleView;
}

- (RecommendGameView *)recommendGameView{
    if (!_recommendGameView) {
        _recommendGameView = [[RecommendGameView alloc] initWithFrame:CGRectMake(0, -kGameHeight, kScreenWidth, kGameHeight)];
    }
    return _recommendGameView;
}

#pragma mark - UICollectionViewDatasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1 + 1 + _otherArray.count - 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0){
        return 8;
    }
    
    return 4;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
        RecommendReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kNormalHeaderId forIndexPath:indexPath];
        
        if(headerView == nil){
            headerView = [[RecommendReusableView alloc] init];
        }
        if (indexPath.section == 0) {// 最热
            headerView.iconImageView.image = [UIImage imageNamed:@"home_header_hot"];
        }else if (indexPath.section == 1){// 颜值
            headerView.iconImageView.image = [UIImage imageNamed:@"columnYanzhiIcon"];
        }else{// 其他
            headerView.iconImageView.image = [UIImage imageNamed:@"home_header_normal"];
        }
        headerView.titleLab.text = _headerTitleArray[indexPath.section];
        headerView.backgroundColor = kWhiteColor;
//        headerView.backgroundColor = kBlackColor;

        return headerView;
    }
    return nil;
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return CGSizeMake(kItemW, kPrettyItemH);
    }
    return CGSizeMake(kItemW, kNormalItemH);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        RecommendCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kNormalCellId forIndexPath:indexPath];
        
        if (!cell) {
            cell = [[RecommendCollectionViewCell alloc] init];
        }
        
        NSDictionary *dic = _hotArray[indexPath.row];
        
        YanZhiModel *model = [YanZhiModel objectWithKeyValues:dic];
        
        [cell setYanzhiModel:model];
        
        cell.backgroundColor = [UIColor whiteColor];
        
        return cell;
        
    }else if (indexPath.section == 1) {
        RecommendYanzhiCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kYanZhiCellId forIndexPath:indexPath];
        
        if (!cell) {
            cell = [[RecommendYanzhiCell alloc] init];
        }
        NSDictionary *dic = _yanzhiArray[indexPath.row];
        
        YanZhiModel *model = [YanZhiModel objectWithKeyValues:dic];
        
        [cell setYanzhiModel:model];
        
        cell.backgroundColor = [UIColor whiteColor];
        
        return cell;
    }else{
        RecommendCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kNormalCellId forIndexPath:indexPath];
        
        if (!cell) {
            cell = [[RecommendCollectionViewCell alloc] init];
        }
        NSDictionary *dic;
        if (indexPath.section == 2) {
            dic = [_otherArray[0] objectForKey:@"room_list"][indexPath.row];
        }else{
            dic = [_otherArray[indexPath.section - 1] objectForKey:@"room_list"][indexPath.row];
        }
        
        YanZhiModel *model = [YanZhiModel objectWithKeyValues:dic];
        
        [cell setYanzhiModel:model];
        
        cell.backgroundColor = [UIColor whiteColor];
        
        return cell;
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
