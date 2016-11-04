//
//  PageTitleView.m
//  WY_DYZB
//
//  Created by apple on 16/10/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "PageTitleView.h"

#define kScrollViewLineH 2
#define kNormalTextColor kRGBColor(85, 85, 85)
#define kSelectTextColor kRGBColor(255, 128, 0)

@interface PageTitleView ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) UIView *scrollLine;
@property (nonatomic, strong) NSMutableArray *titleLabArray;
@property (nonatomic, assign) NSInteger currentIndex;           // 当前index

@end

@implementation PageTitleView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.titles = titles;
        
        [self initData];    // 初始化数据
        [self setUpSubViews]; // 设置子控件
    }
    return self;
}

#pragma mark - 初始化数据
- (void)initData
{
    self.currentIndex = 0;
    _titleLabArray = [[NSMutableArray alloc] init];
}

#pragma mark - 懒加载
- (UIScrollView *)scrollView
{
    if (!_scrollView)
    {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        
        [self addSubview:_scrollView];
    }
    
    return _scrollView;
}

- (UIView *)scrollLine
{
    if (!_scrollLine)
    {
        _scrollLine = [[UIView alloc] init];
        _scrollLine.backgroundColor = kOrangeColor;
    }
    return _scrollLine;
}

#pragma mark - 设置子控件
- (void)setUpSubViews
{
    [self setUpTitleLabels];    // 创建标题label
    
    [self setUpScrollLine];    // 设置滑动的View
}

#pragma mark - 创建标题label
- (void)setUpTitleLabels
{
    CGFloat labY = 0.0;
    CGFloat labW = self.width / self.titles.count;
    CGFloat labH = self.height - kScrollViewLineH;
    
    for (int i = 0; i < _titles.count; i++)
    {
        UILabel *label = [[UILabel alloc] init];
        
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = kNormalTextColor;
        label.font = kFont(26*KPixel);
        label.tag = i;
        label.text = _titles[i];
        
        label.frame = CGRectMake(i * labW, labY, labW, labH);
        
        [self.scrollView addSubview:label];
        [_titleLabArray addObject:label];
        
        label.userInteractionEnabled = YES;     // 设置可以点击，默认不可点击
        
        // 为label添加点击事件
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleTap:)];
        [label addGestureRecognizer:tap];
    }
}

#pragma mark - 设置滑块的View
- (void)setUpScrollLine
{
    UILabel *firstLab = [_titleLabArray firstObject];
    firstLab.textColor = kSelectTextColor;
    self.scrollLine.frame = CGRectMake(firstLab.x + 15*KPixel, (self.height - kScrollViewLineH), firstLab.width-30*KPixel, kScrollViewLineH);
    [self.scrollView addSubview:self.scrollLine];
}

#pragma mark - 标题的点击事件
- (void)titleTap:(UITapGestureRecognizer *)tap
{
    NSLog_Cus(@"标题index=========%ld",tap.view.tag);
    
    // 获取点击的当前label
    UILabel *currentLab = _titleLabArray[tap.view.tag];
    
    if (currentLab.tag == self.currentIndex)
    {// 如果是点击当前label，则返回
        return;
    }
    // 获取上一个label
    UILabel *lastLab = _titleLabArray[_currentIndex];
    
    // 切换文字的颜色
    lastLab.textColor = kNormalTextColor;
    currentLab.textColor = kSelectTextColor;
    // 更新最新label的索引
    self.currentIndex = currentLab.tag;

    [UIView animateWithDuration:0.15 animations:^{
        self.scrollLine.x = self.currentIndex * currentLab.width + 15*KPixel;
    }];
    
    if ([_delegate respondsToSelector:@selector(pageTitleClick:)])
    {
        [_delegate pageTitleClick:_currentIndex];
    }
}

#pragma mark 对外暴露的方法
- (void)setTitleViewWithProgress:(CGFloat)progress sourceIndex:(NSInteger)sourceIndex targetIndex:(NSInteger)targetIndex
{
    // 取出起始label和目标label
    UILabel *sourceLab = _titleLabArray[sourceIndex];
    UILabel *targetLab = _titleLabArray[targetIndex];
    
    // 处理滑块的逻辑
    CGFloat moveTotalX = targetLab.x - sourceLab.x;
    CGFloat moveX = moveTotalX * progress;
    self.scrollLine.x = sourceLab.x + moveX + 15*KPixel;

//    CGRect colorDelta = CGRectMake(255 - 85, 125 - 85, 0 - 85, 0);
    
    // 颜色的渐变
    sourceLab.textColor = kRGBColor((255 - 170*progress), (125 - 40*progress), (0 - (-85 * progress)));
    
    targetLab.textColor = kRGBColor((85 + 170*progress), (85 + 40*progress), (85 + (-85 * progress)));
    
    // 更新最新label的索引
    self.currentIndex = targetIndex;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
