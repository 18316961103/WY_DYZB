//
//  RecommendGameCell.m
//  WY_DYZB
//
//  Created by apple on 16/11/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "RecommendGameCell.h"

#define kIconW 60*KPixel            // 图标宽度和高度


@interface RecommendGameCell ()

@property (strong, nonatomic) UIImageView *iconImgView;     // 图标
@property (strong, nonatomic) UILabel *titleLab;            // 标题

@end

@implementation RecommendGameCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpSubviews];   // 设置子控件
    }
    return self;
}

#pragma mark - 设置子控件
- (void)setUpSubviews{
    
    [self addSubview:self.iconImgView];
    [self addSubview:self.titleLab];
    
    // 自动布局
    self.iconImgView.sd_layout
    .topSpaceToView(self , 15*KPixel)
    .widthIs(kIconW)
    .heightIs(kIconW);
    
    _iconImgView.layer.cornerRadius = _iconImgView.width * 0.5;     // 设置圆形
    _iconImgView.layer.masksToBounds = YES;

    self.titleLab.sd_layout
    .topSpaceToView(self.iconImgView, 0*KPixel)
    .bottomSpaceToView(self,0*KPixel)
    .widthIs(self.width);
}

#pragma mark - 懒加载
- (UIImageView *)iconImgView{
    if (!_iconImgView) {
        _iconImgView = [[UIImageView alloc] init];
        _iconImgView.x = self.width/2 - kIconW/2;
        _iconImgView.image = kDefaultImage;
    }
    return _iconImgView;
}

- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textColor = kRGBColor(85, 85, 85);
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.backgroundColor = [UIColor clearColor];
        _titleLab.font = kFont(12);
        _titleLab.text = @"英雄联盟";
    }
    return _titleLab;
}

- (void)setRecommendGameModel:(RecommendGameModel *)recommendGameModel{
    _recommendGameModel = recommendGameModel;
    
    if (_recommendGameModel) {
        _titleLab.text = _recommendGameModel.tag_name;
        if ([_titleLab.text isEqualToString:@"更多分类"]) {
            _iconImgView.image = [UIImage imageNamed:@"home_column_more"];
        }else{
            [_iconImgView sd_setImageWithURL:[NSURL URLWithString:_recommendGameModel.icon_url] placeholderImage:kDefaultImage];
        }
    }
}

@end
