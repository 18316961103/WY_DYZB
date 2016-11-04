//
//  UIButton+MoreButton.m
//  WY_DYZB
//
//  Created by apple on 16/10/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIButton+MoreButton.h"

@implementation UIButton (MoreButton)

+ (UIButton *)moreBtnWithFrame:(CGRect)frame
                         title:(NSString *)title
                       moreImg:(NSString *)moreImage
                        target:(id)target
                        action:(SEL)action
{
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    
    btn.backgroundColor = kWhiteColor;
    [btn setTitle:title?title:@"更多" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1.0] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    btn.titleEdgeInsets = UIEdgeInsetsMake(5, -btn.bounds.size.width+50, 5, 20);
    [btn setImage:[UIImage imageNamed:moreImage?moreImage:@"homeMoreIcon"] forState:UIControlStateNormal];
    
    btn.imageEdgeInsets = UIEdgeInsetsMake(5, btn.bounds.size.width-20, 5, 5);
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

@end
