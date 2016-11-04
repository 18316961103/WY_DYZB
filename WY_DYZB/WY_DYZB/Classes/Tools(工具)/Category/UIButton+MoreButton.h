//
//  UIButton+MoreButton.h
//  WY_DYZB
//
//  Created by apple on 16/10/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (MoreButton)

+ (UIButton *)moreBtnWithFrame:(CGRect)frame
                         title:(NSString *)title
                       moreImg:(NSString *)moreImage
                        target:(id)target
                        action:(SEL)action;

@end
