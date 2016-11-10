//
//  DYHomeViewController.m
//  WY_DYZB
//
//  Created by apple on 16/10/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "DYHomeViewController.h"
#import "PageTitleView.h"
#import "PageContentView.h"
#import "RecommendViewController.h"
#import "GameViewController.h"
#import "EntertainmentViewController.h"
#import "FunViewController.h"
#import "MobileGameController.h"

@interface DYHomeViewController () <PageTitleClickDelegate,PageContentViewDelegate>

@property (nonatomic, strong) PageTitleView *pageTitleView;
@property (nonatomic, strong) PageContentView *contentView;

@end

@implementation DYHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self setLeftBarButton];        // 设置左导航栏
    [self setRightBarButton];       // 设置右导航栏

    [self setPageTitleView];        // 设置标题
    [self setPageContentView];      // 设置首页滑动的View
    
    // Do any additional setup after loading the view.
}

#pragma mark - 设置首页的左导航栏
- (void)setLeftBarButton
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonWithImage:[UIImage imageNamed:@"logo"] highlightedImage:nil size:CGSizeZero target:self action:@selector(leftItemClick)];
}

#pragma mark - 设置首页的右导航栏
- (void)setRightBarButton
{
    // 按钮的size
    CGSize size = CGSizeMake(40, 44);
    // 历史记录
    UIBarButtonItem *historyItem = [UIBarButtonItem barButtonWithImage:[UIImage imageNamed:@"image_my_history"] highlightedImage:[UIImage imageNamed:@"Image_my_history_click"] size:size target:self action:@selector(historyItemClick)];
    // 查找
    UIBarButtonItem *searchItem = [UIBarButtonItem barButtonWithImage:[UIImage imageNamed:@"btn_search"] highlightedImage:[UIImage imageNamed:@"btn_search_clicked"] size:size target:self action:@selector(searchItemClick)];
    // 扫描二维码
    UIBarButtonItem *qrCodeItem = [UIBarButtonItem barButtonWithImage:[UIImage imageNamed:@"Image_scan"] highlightedImage:[UIImage imageNamed:@"Image_scan_click"] size:size target:self action:@selector(qrCodeItemClick)];
    
    // 从右向左创建item
    self.navigationItem.rightBarButtonItems = @[historyItem,searchItem,qrCodeItem];
}

//#pragma mark - 懒加载
//- (PageTitleView *)pageTitleView
//{
//    if (!_pageTitleView)
//    {
//        _pageTitleView = [[PageTitleView alloc] initWithFrame:CGRectMake(0, kStatusBarH + kNavigationBarH, kScreenWidth, 40*KPixel) titles:@[@"推荐",@"游戏",@"娱乐",@"趣玩"]];
//        
//        [self.view addSubview:_pageTitleView];
//    }
//    return _pageTitleView;
//}

#pragma mark - 设置标题view 
- (void)setPageTitleView
{
    _pageTitleView = [[PageTitleView alloc] initWithFrame:CGRectMake(0, kStatusBarH + kNavigationBarH, kScreenWidth, 60*KPixel) titles:@[@"推荐",@"游戏",@"娱乐",@"手游",@"趣玩"]];
    
    _pageTitleView.delegate = self;
    
    [self.view addSubview:_pageTitleView];
}

#pragma mark - PageTitleClickDelegate
- (void)pageTitleClick:(NSInteger)index
{
    [_contentView setCurrentIndex:index];
}

#pragma mark - 设置首页滑动的View
- (void)setPageContentView
{
    _contentView = [[PageContentView alloc] initWithFrame:CGRectMake(0, kStatusBarH + kNavigationBarH + 60*KPixel, kScreenWidth, kScreenHeight - kStatusBarH - kNavigationBarH - 60*KPixel - kTabbarH) parentController:self childVCArray:@[[[RecommendViewController alloc] init],[[GameViewController alloc] init],[[EntertainmentViewController alloc] init],[[MobileGameController alloc] init],[[FunViewController alloc] init]]];
    
    _contentView.delegate = self;
    
    [self.view addSubview:_contentView];
}

#pragma mark - PageContentViewDelegate
- (void)contentScrollWithProgress:(CGFloat)progress sourceIndex:(NSInteger)sourceIndex targetIndex:(NSInteger)targetIndex
{
    [_pageTitleView setTitleViewWithProgress:progress sourceIndex:sourceIndex targetIndex:targetIndex];
}

#pragma mark - 左导航栏 的点击事件
- (void)leftItemClick
{
    NSLog_Cus(@"leftItemClick");
}

#pragma mark - 历史记录 导航栏的点击事件
- (void)historyItemClick
{
    NSLog_Cus(@"historyItemClick");
}

#pragma mark - 查找 导航栏的点击事件
- (void)searchItemClick
{
    NSLog_Cus(@"searchItemClick");
}

#pragma mark - 扫描二维码 导航栏的点击事件
- (void)qrCodeItemClick
{
    NSLog_Cus(@"qrCodeItemClick");
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
