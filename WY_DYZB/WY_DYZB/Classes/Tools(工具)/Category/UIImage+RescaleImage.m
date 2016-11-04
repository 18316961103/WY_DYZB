//
//  UIImage+RescaleImage.m
//  WY_DYZB
//
//  Created by apple on 16/11/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIImage+RescaleImage.h"

@implementation UIImage (RescaleImage)

- (UIImage *)rescaleImageToSize:(CGSize)size {
    
    CGRect rect = CGRectMake(0.0, 0.0, size.width, size.height);
    
    UIGraphicsBeginImageContext(rect.size);
    
    [self drawInRect:rect];  // scales image to rect
    
    UIImage *resImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resImage;
    
}

@end
