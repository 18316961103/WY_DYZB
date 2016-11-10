//
//  BaseViewController.h
//  WY_DYZB
//
//  Created by apple on 16/11/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *dataArray;       // 数据源

/** 设置子控件*/
- (void)setUpSubViews;
/** 发送数据请求*/
- (void)getDataRequest;
/** 请求数据完成后回调*/
- (void)finishRequest;


@end
