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

#define kItemMargin 10
#define kItemW ((kScreenWidth - 3 * kItemMargin) / 2)
#define kNormalItemH (kItemW * 3 / 4)
#define kPrettyItemH (kItemW * 4 / 3)
#define kHeaderViewH 40
#define kFooterViewH 10
#define kNormalCellId @"CollectionNormalCellId"
#define kYanZhiCellId @"CollectionYanZhiCellId"
#define kNormalHeaderId @"CollectionNormalHeaderId"
#define kNormalFooterId @"CollectionNormalFooterId"

@interface RecommendViewController () <UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSArray *_hotArray;         // 最热数据
    NSArray *_yanzhiArray;      // 颜值数据
    NSArray *_otherArray;      // 其他数据
}
@property (strong, nonatomic) UICollectionView *collectionView;

@end

@implementation RecommendViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:kRedColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setUpSubViews];   // 设置子控件
    
    // Do any additional setup after loading the view.
}

#pragma mark - 设置子控件
- (void)setUpSubViews
{
    [self.view addSubview:self.collectionView];
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
        layout.footerReferenceSize = CGSizeMake(kScreenWidth, kFooterViewH);
        layout.sectionInset = UIEdgeInsetsMake(0, kItemMargin, 0, kItemMargin);
        
        // 创建collectionview
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kTabbarH - kNavigationBarH - kStatusBarH - 68*KPixel) collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = kWhiteColor;
        [_collectionView registerClass:[RecommendCollectionViewCell class] forCellWithReuseIdentifier:kNormalCellId];  // 注册collectionViewCell
        [_collectionView registerClass:[RecommendYanzhiCell class] forCellWithReuseIdentifier:kYanZhiCellId];  // 注册collectionViewCell
        [_collectionView registerClass:[RecommendReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kNormalHeaderId];  // 注册UICollectionReusableView
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kNormalFooterId];  // 注册UICollectionFooterView
    }
    
    return _collectionView;
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
//    UICollectionReusableView *headerView = [_collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"" forIndexPath:indexPath];
//    if(headerView == nil)
//    {
//        headerView = [[UICollectionReusableView alloc] init];
//    }
//    headerView.backgroundColor = [UIColor grayColor];
//    
//    return headerView;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
        RecommendReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kNormalHeaderId forIndexPath:indexPath];
        
        if(headerView == nil){
            headerView = [[RecommendReusableView alloc] init];
        }
        
        headerView.backgroundColor = kWhiteColor;
        
        return headerView;
    }
    else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kNormalFooterId forIndexPath:indexPath];
        
        if(headerView == nil){
            headerView = [[UICollectionReusableView alloc] init];
        }
        if (indexPath.section == 11){
            headerView.backgroundColor = kWhiteColor;
        }else{
            headerView.backgroundColor = kRGBColor(234, 234, 234);
        }
        
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
    [[NetworkSingleton sharedManager] getRecommendDataWithSuccessBlock:^(id response) {
        NSArray *dataArray = response;
        
        NSLog_Cus(@"dataArray.count=====%ld",dataArray.count);
        
        if (dataArray.count>0) {
            _hotArray = dataArray[0];
            _yanzhiArray = dataArray[1];
            _otherArray = dataArray[2];
        }
        
        [self.collectionView reloadData];   // 刷新界面
        
    } failureBlock:^(NSString *error) {
        
    }];
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
