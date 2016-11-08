//
//  RecommendReusableView.m
//  WY_DYZB
//
//  Created by apple on 16/10/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "RecommendReusableView.h"

#define kEmptyViewH 20*KPixel       // 分割View的高度

@interface RecommendReusableView ()

@property (strong, nonatomic) UIView *emptyView;        // 分割View
@property (strong, nonatomic) UIButton *moreBtn;       // 更多按钮
@property (assign, nonatomic) NSInteger btnTag;        // 更多按钮的tag

@end

@implementation RecommendReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setUpSubVIews];   // 设置子控件
    }
    
    return self;
}

#pragma mark - 懒加载
- (UIView *)emptyView{
    if (!_emptyView) {
        _emptyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, kEmptyViewH)];
        _emptyView.backgroundColor = kRGBColor(234, 234, 234);
    }
    return _emptyView;
}

- (UIImageView *)iconImageView{
    if (!_iconImageView) {
        UIImageView *imageView = [[UIImageView alloc] init];
        
        imageView.frame = CGRectMake(10, kEmptyViewH + 15 *KPixel, 30*KPixel, 30*KPixel);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        _iconImageView = imageView;
        
        _iconImageView.image = [UIImage imageNamed:@"home_header_normal"];
    }
    return _iconImageView;
}

- (UILabel *)titleLab{
    if (!_titleLab) {
        UILabel *label = [[UILabel alloc] init];
        
        label.frame = CGRectMake(CGRectGetMaxX(self.iconImageView.frame)+10*KPixel, 10*KPixel + kEmptyViewH, 200*KPixel, 40*KPixel);
        _titleLab = label;
        _titleLab.text = @"最热";
    }
    return _titleLab;
}

- (UIButton *)moreBtn{
    if (!_moreBtn) {
        UIButton *button = [UIButton moreBtnWithFrame:CGRectMake(self.width-120*KPixel, 10*KPixel + kEmptyViewH, 120*KPixel, 40*KPixel) title:@"更多" moreImg:@"homeMoreIcon" target:self action:@selector(moreBtnClick:)];

        _moreBtn = button;
    }
    return _moreBtn;
}

#pragma mark - 设置子控件
- (void)setUpSubVIews{
    [self addSubview:self.emptyView];
    [self addSubview:self.iconImageView];
    [self addSubview:self.titleLab];
    [self addSubview:self.moreBtn];
}

#pragma mark - 更多按钮的点击事件
- (void)moreBtnClick:(UIButton *)sender{
    NSLog_Cus(@"moreBtnClick");
}

@end
