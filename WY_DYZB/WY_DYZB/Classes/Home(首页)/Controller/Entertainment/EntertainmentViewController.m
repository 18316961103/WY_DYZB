//
//  EntertainmentViewController.m
//  WY_DYZB
//
//  Created by apple on 16/10/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "EntertainmentViewController.h"

@interface EntertainmentViewController ()

@property (strong, nonatomic) GameHeaderView *gameHeaderView;   // 顶部的headerView

@end

@implementation EntertainmentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    // Do any additional setup after loading the view.
}

#pragma mark - 重写父类的请求方法
- (void)getDataRequest{
    [[NetworkSingleton sharedManager] getHomeEntertainmentDataWithSuccessBlock:^(id response) {
        self.dataArray = response;
        [self finishRequest];
        NSMutableArray *headerArray = [[NSMutableArray alloc] initWithArray:self.dataArray];
        if (headerArray.count) {// 去掉第一个最热的数据
            [headerArray removeObjectAtIndex:0];
        }
        self.gameHeaderView.dataArray = headerArray;
        [self.collectionView reloadData];
    } failureBlock:^(NSString *error) {
        NSLog_Cus(@"error = %@",error);
    }];
}

#pragma mark - 重写父类的方法
- (void)setUpSubViews{
    [super setUpSubViews];
    
    [self.collectionView addSubview:self.gameHeaderView];
    self.collectionView.contentInset = UIEdgeInsetsMake(kGameHeaderH, 0, 0, 0);
}

#pragma mark - 懒加载
- (GameHeaderView *)gameHeaderView{
    if (!_gameHeaderView) {
        _gameHeaderView = [[GameHeaderView alloc] initWithFrame:CGRectMake(0, -kGameHeaderH, kScreenWidth, kGameHeaderH)];
    }
    return _gameHeaderView;
}

#pragma mark - UICollectionDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 12;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        RecommendReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kNormalHeaderId forIndexPath:indexPath];
        if (!reusableView) {
            reusableView = [[RecommendReusableView alloc] init];
        }
        reusableView.backgroundColor = kWhiteColor;
        if (indexPath.section == 0) {
            reusableView.iconImageView.image = [UIImage imageNamed:@"home_header_hot"];
        }else{
            reusableView.iconImageView.image = [UIImage imageNamed:@"home_header_normal"];
        }
        ReusableModel *model = [ReusableModel objectWithKeyValues:self.dataArray[indexPath.section]];
        [reusableView setReusableModel:model];
        
        return reusableView;
    }
    return nil;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    RecommendCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kNormalCellId forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[RecommendCollectionViewCell alloc] init];
    }
    
    NSDictionary *dic = [self.dataArray[indexPath.section] objectForKey:@"room_list"][indexPath.row];
    
    YanZhiModel *model = [YanZhiModel objectWithKeyValues:dic];
    
    [cell setYanzhiModel:model];
    
    return cell;
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
