//
//  PageContentView.h
//  WY_DYZB
//
//  Created by apple on 16/10/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PageContentViewDelegate <NSObject>

@optional

- (void)contentScrollWithProgress:(CGFloat)progress sourceIndex:(NSInteger)sourceIndex targetIndex:(NSInteger)targetIndex;

@end

@interface PageContentView : UIView


/** 构造方法*/
- (instancetype)initWithFrame:(CGRect)frame parentController:(UIViewController *)parentController childVCArray:(NSArray *)childVCArray;

@property (nonatomic, assign) id<PageContentViewDelegate> delegate;

// 对外暴露的方法
- (void)setCurrentIndex:(NSInteger)currentIndex;

@end
