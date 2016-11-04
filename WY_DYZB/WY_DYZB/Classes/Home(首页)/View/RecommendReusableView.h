//
//  RecommendReusableView.h
//  WY_DYZB
//
//  Created by apple on 16/10/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MoreBtnClick <NSObject>

@optional

- (void)moreBtnClick:(NSInteger)index;

@end

@interface RecommendReusableView : UICollectionReusableView

@end
