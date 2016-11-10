//
//  GameViewController.m
//  WY_DYZB
//
//  Created by apple on 16/10/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()
{
    NSArray *_dataArray;        // 展现数据数组
}

@property (strong, nonatomic) GameHeaderView *gameHeaderView;

@end

@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    // Do any additional setup after loading the view.
}

#pragma mark - 获取游戏数据
- (void)getDataRequest{
    [[NetworkSingleton sharedManager] getHomeGameDataWithSuccessBlock:^(id response) {
        
        _dataArray = response;
        
        NSLog_Cus(@"dataArray.count = %ld",_dataArray.count);
        
        NSMutableArray *headerArray = [[NSMutableArray alloc] initWithArray:_dataArray];
        if (headerArray.count) {// 去掉第一个最热的数据
            [headerArray removeObjectAtIndex:0];
            NSDictionary *dic = @{@"tag_name":@"更多分类",@"tag_id":@"16",@"icon_url":@"home_column_more",@"small_icon_url":@"",@"count":@"",@"count_ios":@"",@"push_vertical_screen":@""};    // 手动增加一个更多分类选项
            if (headerArray.count >= 16) {
                [headerArray replaceObjectAtIndex:15 withObject:dic];
            }else{
                [headerArray replaceObjectAtIndex:(headerArray.count-1) withObject:dic];
            }
        }
        [self finishRequest];   // 请求数据完毕回调
        self.gameHeaderView.dataArray = headerArray; // 刷新头部数据
        [self.collectionView reloadData];   // 刷新界面
        
    } failureBlock:^(NSString *error) {
        NSLog_Cus(@"error = %@",error);
    }];
}

#pragma mark - 重写父类方法
- (void)setUpSubViews{
    [super setUpSubViews];  // 调用父类方法
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
    return 15;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
        RecommendReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kNormalHeaderId forIndexPath:indexPath];
        
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
    
    RecommendCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kNormalCellId forIndexPath:indexPath];
    
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
