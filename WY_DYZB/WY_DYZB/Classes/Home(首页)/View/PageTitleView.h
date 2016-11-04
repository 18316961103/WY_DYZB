//
//  PageTitleView.h
//  WY_DYZB
//
//  Created by apple on 16/10/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PageTitleClickDelegate <NSObject>

@optional

- (void)pageTitleClick:(NSInteger)index;

@end

@interface PageTitleView : UIView

@property (nonatomic, assign) id<PageTitleClickDelegate> delegate;

/** 构造方法*/
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles;

/** 对外暴露的方法*/ 
- (void)setTitleViewWithProgress:(CGFloat)progress sourceIndex:(NSInteger)sourceIndex targetIndex:(NSInteger)targetIndex;

@end
