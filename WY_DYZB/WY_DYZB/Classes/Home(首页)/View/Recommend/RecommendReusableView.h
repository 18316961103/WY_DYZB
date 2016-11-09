//
//  RecommendReusableView.h
//  WY_DYZB
//
//  Created by apple on 16/10/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReusableModel.h"

@protocol MoreBtnClick <NSObject>

@optional

- (void)moreBtnClick:(NSInteger)index;

@end

@interface RecommendReusableView : UICollectionReusableView

@property (strong, nonatomic) UIImageView *iconImageView;       // 图标
@property (strong, nonatomic) UILabel *titleLab;       // 标题

@property (strong, nonatomic) ReusableModel *reusableModel;

@end
