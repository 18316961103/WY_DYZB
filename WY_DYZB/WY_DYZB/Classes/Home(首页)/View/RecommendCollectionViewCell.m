//
//  RecommendCollectionViewCell.m
//  WY_DYZB
//
//  Created by apple on 16/10/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "RecommendCollectionViewCell.h"

@interface RecommendCollectionViewCell ()

@property (strong, nonatomic) UIImageView *liveImageView;       // 直播界面
@property (strong, nonatomic) UIImageView *eyeImageView;        // 观看人数图片
@property (strong, nonatomic) UIImageView *anchorImageView;     // 主播默认图片
@property (strong, nonatomic) UILabel *peopleCountLab;          // 观看人数
@property (strong, nonatomic) UILabel *anchorNameLab;           // 主播姓名
@property (strong, nonatomic) UILabel *titleLab;                // 直播标题

@end

@implementation RecommendCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setUpSubViews];   // 设置子控件
    }
    
    return self;
}

#pragma mark - 懒加载
- (UIImageView *)liveImageView{
    if (!_liveImageView) {
        UIImageView *imageView = [[UIImageView alloc] init];
        
        imageView.frame = CGRectMake(0, 0, self.width-0, self.height-35);
        imageView.layer.masksToBounds = YES;        // 隐藏边界
        imageView.layer.cornerRadius = 5.0;
        _liveImageView = imageView;
        
        imageView.image = [UIImage imageNamed:@"Img_default"];
    }
    return _liveImageView;
}

- (UIImageView *)eyeImageView{
    if (!_eyeImageView) {
        UIImageView *imageView = [[UIImageView alloc] init];
        
//        imageView.frame = CGRectMake(_liveImageView.width-55, 5, 15, 15);
        _eyeImageView = imageView;
        
        _eyeImageView.image = [UIImage imageNamed:@"Image_online"];

    }
    return _eyeImageView;
}

- (UILabel *)peopleCountLab{
    if (!_peopleCountLab) {
        UILabel *label = [[UILabel alloc] init];
        
//        label.frame = CGRectMake(CGRectGetMaxX(_eyeImageView.frame)+5, _eyeImageView.y-3, 40, 20);
        label.textColor = kWhiteColor;
        label.backgroundColor = kRGBAColor(0, 0, 0, 0.3);
        label.font = kFont(11);
        _peopleCountLab = label;
    }
    return _peopleCountLab;
}

- (UIImageView *)anchorImageView{
    if (!_anchorImageView) {
        UIImageView *imageView = [[UIImageView alloc] init];
        
//        imageView.frame = CGRectMake(5, _liveImageView.height - 20, 15, 15);
        _anchorImageView = imageView;
        
        _anchorImageView.image = [UIImage imageNamed:@"userNameIcon"];
    }
    return _anchorImageView;
}

- (UILabel *)anchorNameLab{
    if (!_anchorNameLab) {
        UILabel *label = [[UILabel alloc] init];
        
//        label.frame = CGRectMake(CGRectGetMaxX(_anchorImageView.frame)+5, _anchorImageView.y-3, _liveImageView.width-CGRectGetMaxX(_anchorImageView.frame)-10, 20);
        label.textColor = kWhiteColor;
        label.font = kFont(12);
        _anchorNameLab = label;
    }
    return _anchorNameLab;
}

- (UILabel *)titleLab{
    if (!_titleLab) {
        UILabel *label = [[UILabel alloc] init];
        
//        label.frame = CGRectMake(0, CGRectGetMaxY(_liveImageView.frame), self.width-20, 30);
        label.textColor = kBlackColor;
        label.font = kFont(13);
        _titleLab = label;
    }
    return _titleLab;
}

#pragma mark - 设置子控件
- (void)setUpSubViews{
    
    [self addSubview:self.liveImageView];
    [self addSubview:self.eyeImageView];
    [self addSubview:self.anchorImageView];
    [self addSubview:self.peopleCountLab];
    [self addSubview:self.anchorNameLab];
    [self addSubview:self.titleLab];
    
    self.peopleCountLab.sd_layout
    .leftSpaceToView(self , 5)
    .rightSpaceToView(self , 5)
    .topSpaceToView(self , 5)
    .heightIs(20)
    .autoHeightRatio(0);
    // 单行label宽度自适应
    [self.peopleCountLab setSingleLineAutoResizeWithMaxWidth:self.width-20];
    
    self.eyeImageView.sd_layout
    .rightSpaceToView(self.peopleCountLab , 5)
    .topSpaceToView(self , 3)
    .widthIs(15)
    .heightIs(15);
    
    self.anchorImageView.sd_layout
    .leftSpaceToView(self , 2)
    .topSpaceToView(self , self.liveImageView.height-20)
    .widthIs(15)
    .heightIs(15);
    
    self.anchorNameLab.sd_layout
    .leftSpaceToView(self.anchorImageView , 3)
    .rightSpaceToView(self , 5)
    .topSpaceToView(self , self.liveImageView.height-23)
    .heightIs(20);
    
    self.titleLab.sd_layout
    .leftSpaceToView(self , 0)
    .topSpaceToView(self.liveImageView , 5)
    .widthIs(self.liveImageView.width)
    .heightIs(20);
}

- (void)setYanzhiModel:(YanZhiModel *)yanzhiModel{
    
    _yanzhiModel = yanzhiModel;
    if (_yanzhiModel) {
        [_liveImageView sd_setImageWithURL:[NSURL URLWithString:_yanzhiModel.vertical_src] placeholderImage:kDefaultImage]; // 直播图片
        NSString *onLineStr = @"";
        NSInteger onLine = [_yanzhiModel.online integerValue];
        if (onLine >= 10000) {// 在线人数大于10000，转换以万为单位
            double temp = (double)onLine / (double)10000.0;
            onLineStr = [NSString stringWithFormat:@"%0.1f万",temp];
            onLineStr = [onLineStr stringByReplacingOccurrencesOfString:@".0" withString:@""];  // 排除出现.0万的情况
        }else{// 在线人数小于10000，直接显示数字
            onLineStr = [NSString stringWithFormat:@"%ld",onLine];
        }
        _peopleCountLab.text = onLineStr;               // 在线人数
        _anchorNameLab.text = _yanzhiModel.nickname;    // 主播名字
        _titleLab.text = _yanzhiModel.room_name;        // 直播标题
    }
    
}

@end
