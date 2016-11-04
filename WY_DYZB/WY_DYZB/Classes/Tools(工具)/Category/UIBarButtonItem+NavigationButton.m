//
//  UIBarButtonItem+NavigationButton.m
//  WY_DYZB
//
//  Created by apple on 16/10/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIBarButtonItem+NavigationButton.h"

@implementation UIBarButtonItem (NavigationButton)

+ (UIBarButtonItem *)barButtonWithImage:(UIImage *)image
                       highlightedImage:(UIImage *)highlightedImage
                                   size:(CGSize)size
                                 target:(id)target
                                 action:(SEL)action
{
    UIButton *button = [[UIButton alloc] init];
    
    [button setImage:image forState:UIControlStateNormal];      // 普通图片
    
    if (highlightedImage)
    {
        [button setImage:highlightedImage forState:UIControlStateHighlighted];     // 高亮图片
    }
    if (CGSizeEqualToSize(size, CGSizeZero))
    {
        [button sizeToFit];
    }
    else
    {
        button.frame = CGRectMake(CGPointZero.x, CGPointZero.y, size.width, size.height);
    }
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return item;
}

@end
