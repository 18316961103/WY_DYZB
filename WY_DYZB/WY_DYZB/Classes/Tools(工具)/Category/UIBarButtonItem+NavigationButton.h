//
//  UIBarButtonItem+NavigationButton.h
//  WY_DYZB
//
//  Created by apple on 16/10/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (NavigationButton)

+ (UIBarButtonItem *)barButtonWithImage:(UIImage *)image
                       highlightedImage:(UIImage *)highlightedImage
                                   size:(CGSize)size
                                 target:(id)target
                                 action:(SEL)action;

@end
