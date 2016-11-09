//
//  GameViewController.m
//  WY_DYZB
//
//  Created by apple on 16/10/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GameViewController.h"
#import "RecommendReusableView.h"
#import "RecommendCollectionViewCell.h"
#import "ReusableModel.h"

#define kItemMargin 10                                  // cell的间距
#define kItemW ((kScreenWidth - 3 * kItemMargin) / 2)   // cell的宽度
#define kNormalItemH (kItemW * 3 / 4)   // 普通cell的高度
#define kHeaderViewH 80*KPixel           // header的高度
#define kGameHeaderId @"GameHeaderId"   // 游戏界面的头ID
#define kGameCellId @"GameCellId"       // 游戏界面的cellID

@interface GameViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
{
    NSArray *_dataArray;        // 展现数据数组
}
@property (strong, nonatomic) UICollectionView *collectionView;

@end

@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:kWhiteColor];
    
    [self setUpSubViews];   // 设置子控件
    
    // Do any additional setup after loading the view.
}

#pragma mark - 设置子控件
- (void)setUpSubViews{
    [self.view addSubview:self.collectionView];
}

#pragma mark - 懒加载
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(kItemW, kNormalItemH);
        layout.minimumLineSpacing = 0;      // 行间距
        layout.minimumInteritemSpacing = kItemMargin;       // cell间距
        layout.sectionInset = UIEdgeInsetsMake(0, kItemMargin, 0, kItemMargin);
        layout.headerReferenceSize = CGSizeMake(kScreenWidth, kHeaderViewH);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kTabbarH - kNavigationBarH - kStatusBarH - 68*KPixel) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = kWhiteColor;
        [_collectionView registerClass:[RecommendCollectionViewCell class] forCellWithReuseIdentifier:kGameCellId];// 注册cell
        [_collectionView registerClass:[RecommendReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kGameHeaderId];    // 注册header
        
    }
    return _collectionView;
}

#pragma mark - UICollectionDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 15;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
        RecommendReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kGameHeaderId forIndexPath:indexPath];
        
        if(headerView == nil){
            headerView = [[RecommendReusableView alloc] init];
        }
        if (indexPath.section == 0) {// 最热
            headerView.iconImageView.image = [UIImage imageNamed:@"home_header_hot"];
        }else{// 其他
            headerView.iconImageView.image = [UIImage imageNamed:@"home_header_normal"];
        }
        ReusableModel *model = [ReusableModel objectWithKeyValues:_dataArray[indexPath.section]];
        [headerView setReusableModel:model];
        headerView.backgroundColor = kWhiteColor;
        
        return headerView;
    }
    return nil;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    RecommendCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kGameCellId forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[RecommendCollectionViewCell alloc] init];
    }
    
    NSDictionary *dic = [_dataArray[indexPath.section] objectForKey:@"room_list"][indexPath.row];
    
    YanZhiModel *model = [YanZhiModel objectWithKeyValues:dic];
    
    [cell setYanzhiModel:model];
    
    cell.backgroundColor = [UIColor whiteColor];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog_Cus(@"indexPath.row = %ld",indexPath.row);
    
    [[NetworkSingleton sharedManager] getHomeGameDataWithSuccessBlock:^(id response) {
        
        _dataArray = response;
        
        NSLog_Cus(@"dataArray.count = %ld",_dataArray.count);
        
        [self.collectionView reloadData];   // 刷新界面
        
    } failureBlock:^(NSString *error) {
        NSLog_Cus(@"error = %@",error);
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
