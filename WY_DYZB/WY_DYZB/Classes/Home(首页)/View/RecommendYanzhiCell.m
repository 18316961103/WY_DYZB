//
//  RecommendYanzhiCell.m
//  WY_DYZB
//
//  Created by apple on 16/10/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "RecommendYanzhiCell.h"

@interface RecommendYanzhiCell ()

@property (strong, nonatomic) UIImageView *liveImageView;       // 直播界面
@property (strong, nonatomic) UIImageView *eyeImageView;        // 观看人数图片
@property (strong, nonatomic) UIImageView *anchorImageView;     // 主播默认图片
@property (strong, nonatomic) UILabel *peopleCountLab;          // 观看人数
@property (strong, nonatomic) UILabel *anchorNameLab;           // 主播姓名
@property (strong, nonatomic) UIImageView *locationImageView;   // 位置图片
@property (strong, nonatomic) UILabel *locationLab;             // 位置

@end

@implementation RecommendYanzhiCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setUpSubViews];   // 设置子控件
    }
    
    return self;
}

#pragma mark - 懒加载
#pragma mark - 懒加载
- (UIImageView *)liveImageView{
    if (!_liveImageView) {
        UIImageView *imageView = [[UIImageView alloc] init];
        
        imageView.frame = CGRectMake(0, 0, self.width-0, self.height-35);
        imageView.layer.masksToBounds = YES;        // 隐藏边界
        [imageView setContentScaleFactor:[[UIScreen mainScreen] scale]];
        imageView.layer.cornerRadius = 5.0;
        _liveImageView = imageView;
        
        imageView.image = kDefaultImage;
    }
    return _liveImageView;
}

- (UIImageView *)eyeImageView{
    if (!_eyeImageView) {
        UIImageView *imageView = [[UIImageView alloc] init];
        
//        imageView.frame = CGRectMake(_liveImageView.width-55, 5, 15, 15);
        imageView.contentMode =  UIViewContentModeScaleAspectFill;
        _eyeImageView = imageView;
        
        _eyeImageView.image = [UIImage imageNamed:@"Image_online"];
        
    }
    return _eyeImageView;
}

- (UILabel *)peopleCountLab{
    if (!_peopleCountLab) {
        UILabel *label = [[UILabel alloc] init];
        
//        label.frame = CGRectMake(CGRectGetMaxX(_eyeImageView.frame)+5, _eyeImageView.y-3, 40, 20);
        label.textAlignment = NSTextAlignmentRight;
        label.textColor = kWhiteColor;
        label.font = kFont(11);
        _peopleCountLab = label;
        
        _peopleCountLab.text = @"3.2万";
    }
    return _peopleCountLab;
}

- (UIImageView *)anchorImageView{
    if (!_anchorImageView) {
        UIImageView *imageView = [[UIImageView alloc] init];
        
//        imageView.frame = CGRectMake(5, CGRectGetMaxY(_liveImageView.frame) , 15, 15);
        imageView.contentMode =  UIViewContentModeScaleAspectFill;
        _anchorImageView = imageView;
        
        _anchorImageView.image = [UIImage imageNamed:@"yanzhiUserIcon"];
    }
    return _anchorImageView;
}

- (UILabel *)anchorNameLab{
    if (!_anchorNameLab) {
        UILabel *label = [[UILabel alloc] init];
        
//        label.frame = CGRectMake(CGRectGetMaxX(_anchorImageView.frame)+5, _anchorImageView.y-3, _liveImageView.width-CGRectGetMaxX(_anchorImageView.frame)-10, 20);
        label.textColor = kBlackColor;
        label.font = kFont(14);
        _anchorNameLab = label;
        _anchorNameLab.text = @"wen岳表演wen岳表演";
    }
    return _anchorNameLab;
}

- (UIImageView *)locationImageView{
    if (!_locationImageView) {
        UIImageView *imageView = [[UIImageView alloc] init];
        
//        imageView.frame = CGRectMake(5, CGRectGetMaxY(_liveImageView.frame) , 15, 15);
        imageView.contentMode =  UIViewContentModeScaleAspectFill;
        _locationImageView = imageView;
        
        _locationImageView.image = [UIImage imageNamed:@"ico_location"];
    }
    return _locationImageView;
}

- (UILabel *)locationLab{
    if (!_locationLab) {
        UILabel *label = [[UILabel alloc] init];
        
//        label.frame = CGRectMake(0, CGRectGetMaxY(_liveImageView.frame), self.width-20, 30);
        label.textColor = kRGBColor(85, 85, 85);
        label.textAlignment = NSTextAlignmentRight;
        label.font = kFont(14);
        _locationLab = label;
        
        _locationLab.text = @"佛山市";
    }
    return _locationLab;
}

#pragma mark - 设置子控件
- (void)setUpSubViews{
//    [self setMaskView:self.liveImageView];
    [self addSubview:self.liveImageView];
    [self addSubview:self.eyeImageView];
    [self addSubview:self.peopleCountLab];
    [self addSubview:self.anchorImageView];
    [self addSubview:self.locationLab];
    [self addSubview:self.locationImageView];
    [self addSubview:self.anchorNameLab];
    
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
    
    self.locationLab.sd_layout
    .rightSpaceToView(self , 2)
    .topSpaceToView(_liveImageView , 5)
    .widthIs(self.liveImageView.width/2-10)
    .heightIs(20);
    // 单行label宽度自适应
    [self.locationLab setSingleLineAutoResizeWithMaxWidth:self.liveImageView.width/2-10];
    
    self.locationImageView.sd_layout
    .rightSpaceToView(self.locationLab , 3)
    .topSpaceToView(_liveImageView , 8)
    .widthIs(15)
    .heightIs(15);
    
    self.anchorImageView.sd_layout
    .leftSpaceToView(self , 2)
    .topSpaceToView(_liveImageView , 8)
    .widthIs(15)
    .heightIs(15);
    
    self.anchorNameLab.sd_layout
    .leftSpaceToView(self.anchorImageView , 3)
    .rightSpaceToView(self.locationImageView , 5)
    .topSpaceToView(_liveImageView , 5)
    .heightIs(20);
}

- (void)setYanzhiModel:(YanZhiModel *)yanzhiModel{
    
    _yanzhiModel = yanzhiModel;
    if (_yanzhiModel) {
        [_liveImageView sd_setImageWithURL:[NSURL URLWithString:_yanzhiModel.vertical_src] placeholderImage:kDefaultImage]; // 直播图片
        _peopleCountLab.text = _yanzhiModel.online;     // 在线人数
        _anchorNameLab.text = _yanzhiModel.nickname;    // 主播名字
        _locationLab.text = _yanzhiModel.anchor_city;   // 主播城市
    }
    
}


@end
